
<template>
<!-- 资讯-有标题，有更多跳转 -->
    <div class="article-wrapper">
        <Split/>
        <Title :title="title" :isMoreShow="isMoreShow" @clickHandler="clickMore"/>
        <div class="content-wrapper">
            <div class="message-body" @click="messageClick(item, index)" v-for="(item, index) in articles"
                :key="index">
                <div class="img-wrapper" v-show="item.pic">
                    <img v-lazy="item.pic" alt="" class="message-image">
                </div>
                <div class="info-wrapper">
                    <p class="message-title">{{item.title}}</p>
                    <p class="message-time">{{item.date}}</p>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import Split from '@/components/Split'
import Title from '@/components/Title'
import { getArticles } from '@/service/index'

    export default {
        data() {
            return {
                articles: []
            }
        },
        created() {
            // 获取资讯参数
            if (this.content.middleList[0] && this.content.middleList[0].extra) {
                let nums = this.content.middleList[0].extra.counts // 资讯条数
                let type = this.content.middleList[0].extra.type // 资讯类型
                getArticles(nums, type)
                .then((data) => {
                    this.articles = data.data.res
                })
            }
        },
        props: ['title', 'isMoreShow', 'content'],
        components: {
            Split,
            Title
        },
        methods: {
            messageClick(item, index) {
                this.$emit('clickLink', {
                    type: 'articles',
                    no: index + 1,
                    tileId: this.content.tileId,
                    link: item.link
                })
            },
            clickMore() {
                this.$emit('clickTitle', {
                    type: 'articles',
                    tileId: this.content.tileId,
                    link: this.content.bottomList[0] && this.content.bottomList[0].link
                })
            }
        }
    }
</script>

<style>
.article-wrapper .content-wrapper{
    background: #fff;
}    
.message-body{
    display: table;
    padding: 30px;
    box-sizing: border-box;
    width: 100%;
    max-height: 168px;
}
.message-body:not(:last-child){
    /* @include hairline(bottom, $border-1px-color); */
}
.img-wrapper{
    display: table-cell;
    width: 134px;
    min-width: 134px;
    vertical-align: middle;
}
.info-wrapper{
    position: relative;
    min-height: 108px;
}
.message-image{
    display: inline-block;
    text-align: center;
    vertical-align: middle;
    width: 108px;
    max-height: 108px;
}
.message-title{
    display: inline-block;
    font-weight: 500;
    color: #333;
    font-size: 28px;
    line-height: 36px;
    margin: -4px 0 4px;
    /*! autoprefixer: off */
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
}
.message-time{
    position: absolute;
    color: #999;
    font-size: 24px;
    bottom: -4px;
}
        
</style>
