<template>
  <div>
    <SingleLayout
		v-if="type==301"
		@clickLink="clickHandler"
		:content="listItem"
	/>
    <QuadrupleLayout
		v-else-if="type==302"
		@clickLink="clickHandler"
		:content="listItem"
	/>
    <TripleLayout
		v-else-if="type==303"
		@clickTitle="clickTitle"
		@clickLink="clickHandler"
		:title="listItem.name"
		:content="listItem"
	/>
    <DoubleLayout
		v-else-if="type==304"
		@clickTitle="clickTitle"
		@clickLink="clickHandler"
		:title="listItem.name"
		:content="listItem"
	/>
	<NoticeBarLayout
		v-else-if="type==306"
		@clickLink="clickHandler"
		:content="listItem"
	/>
	<LoanProductLayout
		v-else-if="type==305"
		@clickTitle="clickTitle"
		@clickLink="clickHandler"
		:title="listItem.name"
		:content="listItem"
	/>
	<ArticlesLayout
		v-else-if="type==307"
		@clickTitle="clickTitle"
		@clickLink="clickHandler"
		:title="listItem.name"
		:content="listItem"
	/>
  </div>
</template>

<script>

import LoanProductLayout from '@/components/LoanProductLayout'
import DoubleLayout from '@/components/DoubleLayout'
import TripleLayout from '@/components/TripleLayout'
import QuadrupleLayout from '@/components/QuadrupleLayout'
import NoticeBarLayout from '@/components/NoticeBarLayout'
import SingleLayout from '@/components/SingleLayout'
import ArticlesLayout from '@/components/ArticlesLayout'
import { getQueryString } from '@/service/config'
import { getStatistic } from '@/service/index'
// 首页替换参数
// e.g. http://m.dev.51kabao.cn/play2/201811homepage/index.html?_t=@time&c=gg&ap=@appid&uk=@ukey&v=@ver&lkey=@lkey&mobile=@mobile&udid=@udid&ukey=@ukey&akey=@akey&ver=@ver&appid=@appid&ugroupId=@ugroupId
const arr = ['mobile', 'udid', 'ukey', 'lkey', 'akey', 'ver', 'time', 'appid', 'ugroupId']
let paramObj = {}
arr.forEach((item) => {
	paramObj[item] = getQueryString(item)
})
paramObj.time = getQueryString('_t')
// 埋点点击位置命名
const positionMap = {
	// 通知条
	noticebar: {
		content: {
			normal: '_NB_NC_TXT',
			external: '_NB_ELC_TXT'
		}
	},
	// 产品列表
	loanproduct: {
		title: '_PL_LT_TRC',
		content: '_PL_LT_PIC'
	},
	// 二图
	double: {
		title: '_TWI_CW_TRC',
		content: '_TWI-CW-PIC'
	},
	// 贷款资讯
	articles: {
		title: '_LN_NM_TRC',
		content: '_LN_EL_PIC'
	},
	// 单图or轮播
	single: {
		content: '_TI_CS_PIC'
	},
	// 四图
	quadruple: {
		content: '_FI_PIC'
	},
	// 三图
	triple: {
		title: '_TI_CW_TRC',
		content: '_TI_CW_PIC'
	}

}
export default {
	data() {
		return {
		}
	},
	created() {
		// 301: 轮播图(单图) 302: 4图横排 303: 3图横排 304: 2图横排
		// 305: 借贷产品列表 306: 通知条 307: 资讯
	},
	methods: {
		// 点击内容项
		clickHandler(item) {
			// console.log(item)
			let content = positionMap[item.type].content
			let positiontype = item.tileId
			// 通知条特殊处理
			let position = `${item.tileId}${item.type === 'noticebar' ? (item.external ? content.external : content.normal) : content}${item.no}`
			this.clickStat(positiontype, position)
			// 替换参数
			let link = this.replaceParams(item.link)
			window.location.href = link
		},
		// 点击标题更多按钮
		clickTitle(item) {
			// console.log(item)
			let positiontype = item.tileId
			let position = `${item.tileId}${positionMap[item.type].title}`
			this.clickStat(positiontype, position)
			// 替换参数
			let link = this.replaceParams(item.link)
			window.location.href = link
		},
		// 埋点统计
		clickStat(postiontype, position) {
			getStatistic(postiontype, position, paramObj.appid, paramObj.ukey, paramObj.ver)
			.then((data) => {
				console.log(data)
			})
		},
		// 替换参数
		replaceParams(str) {
			for (let item in paramObj) {
				str = str.replace(new RegExp(`@${item}`, 'g'), paramObj[item])
			}
			return str
		},
	},
    props: ['type', 'listItem'],
	components: {
		SingleLayout,
		LoanProductLayout,
		DoubleLayout,
		TripleLayout,
		QuadrupleLayout,
		NoticeBarLayout,
		ArticlesLayout
	}
}
</script>

<style>
</style>
