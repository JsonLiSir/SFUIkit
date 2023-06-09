import axios from 'axios'
import CryptoJS from 'crypto-js'

// 项目的主要配置
const Config = {
	// 测试地址
  URL: 'http://hold.dev.zmapi.cn/CMD/' // 请求地址

  // 预发地址
  // URL: 'http://rc.rock.zmapi.cn/CMD/' // 请求地址

	// 正式地址
	// URL: 'https://hold.zmapi.cn/CMD/'
}

/**
 * 1. 有修改时，需要去build/webpack.prod.conf.js中修改资源文件版本号（version字段）
 * 2. 测试版本需要去config/index.js中修改assetsPublicPath字段为测试路径
 * 3. src/service/index.js需要修改接口路径
 */

// 控制后端数据是否加解密
let gEncode = 0 // 1-加密 0-不加密
let vid = getQueryString('ver') || 230
let gLkey = getQueryString('lkey') || '92a5c8c43515e6da589ab8e7f7bcc249'
let appId = '1' // 渠道ID
let appKey = 'apFsrHfPSj1v6rEB'

// 设置超时
Object.assign(axios.defaults, {
  timeout: 30000,
  method: 'POST'
})

// 封装的请求
export const HttpCall = axios.create({
	baseURL: Config.URL,
	transformRequest(data) {
		return toFormData(data)
	},
	transformResponse(data) {
		return data
	}
})

// 发起请求前处理请求参数
HttpCall.interceptors.request.use(function (config) {
    // 不加密
    if (config.data.noEncrypted) {
      // TODO去除noEncrypted参数
      return config
    }
    config.data = setParams(config.data, config.url.slice(-8))
    return config
  }, function (error) {
    return Promise.reject(error)
  })

// 收到请求后处理返回值
HttpCall.interceptors.response.use(data => {
    // 需要解密，检查传递参数不包含noEncrypted
    if (gEncode === 1 && !data.config.data.includes('noEncrypted')) {
      data.data = xorDecode(data.data, appKey)
    }
    return JSON.parse(data.data)
  }, error => {
    console.log(error)
  })

// 按服务端协议拼接参数
function setParams(params, cmd) {
    params.g_lkey = gLkey
    params.g_encode = gEncode
    params.g_time = (new Date()).getTime()
    var p = JSON.stringify(params)
    var k = appId + '.' + vid + '.' + CryptoJS.SHA1(cmd + '#' + p + '#' + appKey)
    // console.log(params)
    return {
      p: gEncode === 1 ? xorEndoe(p, appKey) : p,
      k: k,
      cmd: cmd
    }
}

function toFormData(obj) {
  var str = []
  for (var p in obj) {
    str.push(encodeURIComponent(p) + '=' + encodeURIComponent(obj[p]))
  }
  return str.join('&')
}

// 解密
function xorDecode(str, key) {
  str = CryptoJS.enc.Base64.parse(str).toString(CryptoJS.enc.Utf8)
  var data = stringToByte(str)
  var keyData = stringToByte(key + '')

  var keyIndex = 0
  for (var x = 0; x < data.length; x++) {
    data[x] = (data[x] ^ keyData[keyIndex])
    keyIndex += 1
    if (keyIndex === keyData.length) {
      keyIndex = 0
    }
  }
  str = byteToString(data)
  str = CryptoJS.enc.Base64.parse(str).toString(CryptoJS.enc.Utf8)
  return str
}

function stringToByte (str) {
  var bytes = []
  var len, c
  len = str.length
  for (var i = 0; i < len; i++) {
    c = str.charCodeAt(i)
    if (c >= 0x010000 && c <= 0x10FFFF) {
      bytes.push(((c >> 18) & 0x07) | 0xF0)
      bytes.push(((c >> 12) & 0x3F) | 0x80)
      bytes.push(((c >> 6) & 0x3F) | 0x80)
      bytes.push((c & 0x3F) | 0x80)
    } else if (c >= 0x000800 && c <= 0x00FFFF) {
      bytes.push(((c >> 12) & 0x0F) | 0xE0)
      bytes.push(((c >> 6) & 0x3F) | 0x80)
      bytes.push((c & 0x3F) | 0x80)
    } else if (c >= 0x000080 && c <= 0x0007FF) {
      bytes.push(((c >> 6) & 0x1F) | 0xC0)
      bytes.push((c & 0x3F) | 0x80)
    } else {
      bytes.push(c & 0xFF)
    }
  }
  return bytes
}

function byteToString (arr) {
  if (typeof arr === 'string') {
    return arr
  }
  var str = ''
  var _arr = arr
  for (var i = 0; i < _arr.length; i++) {
    var one = _arr[i].toString(2)
    var v = one.match(/^1+?(?=0)/)
    if (v && one.length === 8) {
      var bytesLength = v[0].length
      var store = _arr[i].toString(2).slice(7 - bytesLength)
      for (var st = 1; st < bytesLength; st++) {
        store += _arr[st + i].toString(2).slice(2)
      }
      str += String.fromCharCode(parseInt(store, 2))
      i += bytesLength - 1
    } else {
      str += String.fromCharCode(_arr[i])
    }
  }
  return str
}
// 加密
function xorEndoe (str, key) {
  str = CryptoJS.enc.Base64.stringify(CryptoJS.enc.Utf8.parse(str))
  var data = stringToByte(str)
  var keyData = stringToByte(key + '')
  var keyIndex = 0
  for (var x = 0; x < data.length; x++) {
    data[x] = (data[x] ^ keyData[keyIndex])
    if (++keyIndex === keyData.length) {
      keyIndex = 0
    }
  }
  str = byteToString(data)
  str = CryptoJS.enc.Base64.stringify(CryptoJS.enc.Utf8.parse(str))
  return str
}
// 获取地址栏参数
export function getQueryString (name) {
  const href = window.location.href
  const i = href.indexOf('?')
  const search = href.slice(i)
  var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i')
  var r = search.substr(1).match(reg)
  if (r != null) return decodeURI(r[2])
  return null
}
