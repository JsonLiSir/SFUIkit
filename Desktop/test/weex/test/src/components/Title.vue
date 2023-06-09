<template>
<!-- 标题 -->
    <div class="title-wrapper">
        <h2 class="title">{{title}}</h2>
        <div class="more" v-if="isMoreShow" @click="clickMore">
            <span>{{more}}</span>
            <img src="https://static.kdz6.cn/m.51kabao.cn/app/home_static/images/home_next.png">
        </div>
    </div>
</template>
<script>
export default {
    props: {
        'isMoreShow': {
            type: Boolean,
            default: true
        },
        'title': {
            type: String
        },
        'more': {
            type: String,
            default: '更多'
        }
    },
    methods: {
        clickMore() {
            this.$emit('clickHandler')
        }
    }
}
</script>
<style>
.title-wrapper{
    /* @include hairline(bottom, $border-1px-color); */
    position: relative;
    background: #fff;
    height: 88px;
    line-height: 88px;
    padding: 0 80px;
    box-sizing: border-box;
}
.title{
    color: #333;
    font-weight: 500;
}
.title:before{
    content: '';
    display: inline-block;
    position: relative;
    top: 2px;
    width: 6px;
    height: 28px;
    background-color: #fff;
    margin-right: 20px;
    margin-top: 4px;
}
.more{
    position: absolute;
    right: 0;
    top: 0;
    padding-right: 30px;
    font-size: 26px;
    color: #999;
}
.more img{
    width: 12px;
    vertical-align: -1px;
    margin-left: 4px;
}                   
</style>
