<template>
<!-- 3/6图横排-有标题，有更多跳转 -->
    <div class="triple-wrapper">
        <Split/>
        <Title :title="title" :isMoreShow="isMoreShow" @clickHandler="clickMore"/>
        <div class="content-wrapper">
            <a class="double-content" @click="clickLink(item, index)" v-for="(item, index) in content.middleList" :key="index">
               <img v-lazy="item.imgUrl" alt="">
            </a>
        </div>
    </div>
</template>
<script>
import Split from '@/components/Split'
import Title from '@/components/Title'

export default {
    props: ['title', 'isMoreShow', 'content'],
    methods: {
        clickLink(item, index) {
            this.$emit('clickLink', {
                type: 'triple',
                no: index + 1,
                tileId: this.content.tileId,
                link: item.link
            })
        },
        clickMore() {
            this.$emit('clickTitle', {
                type: 'triple',
                tileId: this.content.tileId,
                link: this.content.bottomList[0].link
            })
        }
    },
	components: {
		Split,
		Title
	}
}
</script>
<style>
.triple-wrapper .content-wrapper {
    background: #fff;
    padding: 0 16px 0 14px;
    font-size: 0;
    margin-bottom: -10px;
}
.triple-wrapper .content-wrapper a {
    display: inline-block;
    width: 33.3333333%;
    box-sizing: border-box;
    margin-bottom: 10px;
}
.triple-wrapper .content-wrapper img {
    width: 100%;
}
</style>
