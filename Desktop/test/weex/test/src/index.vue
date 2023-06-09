<template>
	<div class="app">
		test
		<SelectComponent v-for="(item, index) in list" :key="index" :type="item.type" :listItem="item"/>
	</div>
</template>

<script>

import SelectComponent from '@/components/SelectComponent'
import { getHomeList } from '@/service/index'
export default {
	data() {
		return {
			list: [] // 单个卡片内容
		}
	},
	created() {
    console.log(233444)
		// 获取首页卡片
		getHomeList()
		.then(data => {
			// console.log(data)
			this.list = data.data.list
		})
	},
	methods: {
	},
	components: {
		SelectComponent
	}
}
</script>


