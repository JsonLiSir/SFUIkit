// 首页请求
import { HttpCall } from './config.js'

// 首页
export function getHomeList(minId = 0, rows = 100) { // 最小记录minId默认为0
	return HttpCall({
		url: 'E.H.0.22',
		data: {
			minId: minId,
			rows: rows
		}
	})
}

// 资讯-pass接口
export function getArticles(nums = 5, type = 0) {
	return HttpCall({
		url: 'http://paas.dev.zmapi.cn/hold/hold.pu03', // 测试
		// url: 'http://paas.rc.zmapi.cn/hold/hold.pu03', // 预发
		// url: '//paas.zmapi.cn/hold/hold.pu03', // 正式
		data: {
			// 不需要加密，默认加密
			noEncrypted: true,
			nums: nums,
			type: type
		}
	})
}

// 埋点统计
export function getStatistic(postiontype, position, appid, ukey, ver) {
	return HttpCall({
		method: 'GET',
		url: `http://dev.zmi6.cn/ge2sad?pst=${postiontype}&ps=${position}&ap=${appid}&uk=${ukey}&v=${ver}`,
		// url: `https://zmi6.cn/ge2pjk?pst=${postiontype}&ps=${position}&ap=${appid}&uk=${ukey}&v=${ver}`, // 正式
		data: {
			// 不需要加密，默认加密
			noEncrypted: true
		}
	})
}
