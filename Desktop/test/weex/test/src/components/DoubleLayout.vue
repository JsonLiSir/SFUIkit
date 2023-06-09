<template>
<!-- 2/4图横排-有标题，有更多跳转 -->
    <div class="double-wrapper">
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
                type: 'double',
                no: index + 1,
                tileId: this.content.tileId,
                link: item.link
            })
        },
        clickMore() {
            this.$emit('clickTitle', {
                type: 'double',
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
.double-wrapper .content-wrapper{
    padding: 26px 30px 0px;
    font-size: 0px;
    margin-bottom: -24px;
}
.double-wrapper .content-wrapper a{
    display: inline-block;
    width: 50%;
    box-sizing: border-box;
    margin-bottom: 24px;
}
a img{
    width: 100%;
}                       
.double-wrapper .content-wrapper a:nth-child(2n){
    padding-left: 20px/2;
}
.double-wrapper .content-wrapper a:nth-child(2n+1){
    padding-right: 20px/2;
}
</style>
