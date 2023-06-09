<template>
<!-- 通知条-无标题， 无更多跳转，
手动输入最多5条内容轮播，或获取资讯若干文章标题轮播 -->
    <div class="notice-wrapper">
        <Split/>
        <div class="content-wrapper">
            <img src="https://static.kdz6.cn/m.51kabao.cn/app/home_static/images/home_news.png" alt="">
            <div class="notices">
                <div ref="list" v-if="content.middleList.length > 1">
                    <p v-for="(item, index) in content.middleList" :key="index" @click="clickNotice(item, index)">{{item.sub}}</p>
                </div>
                <div ref="article_list" v-else>
                    <p v-for="(item, index) in articles" :key="index" @click="clickNotice(item, index, true)">{{item.title}}</p>
                </div>
            </div>
            <img src="https://static.kdz6.cn/m.51kabao.cn/app/home_static/images/home_next.png" alt="" class="more">
        </div>
    </div>
</template>
<script>
import Split from '@/components/Split'
import { getArticles } from '@/service/index'
export default {
    data() {
        return {
            articles: []
        }
    },
    props: ['content'],
    created() {
        // 需要获取资讯通知
        if (this.content.middleList.length === 1) {
            let nums = this.content.middleList[0].extra.news
            getArticles(nums)
            .then(data => {
                this.articles = data.data.res
                this.$nextTick(() => {
                    this.checkLength(this.$refs.article_list)
                })
            })
        } else {
            this.$nextTick(() => {
                this.checkLength(this.$refs.list)
            })
        }
    },
    methods: {
        clickNotice(item, index, external = false) {
            this.$emit('clickLink', {
                type: 'noticebar',
                no: index + 1,
                external: external,
                tileId: this.content.tileId,
                link: item.link
            })
        },
        checkLength(ref) {
            let length = ref.children.length // 通知条数
            let i = 1 // 当前显示第几个
            setInterval(() => {
                if (i >= length) {
                    i = 0
                }
                ref.style.marginTop = `${-i * 18}px`
                i++
            }, 2000)
        }
    },
    components: {
        Split
    }
}
</script>
<style>
.notice-wrapper .content-wrapper{
    display: flex;
    background-color: #fff;
    padding: 28px 30px 24px;
    box-sizing: border-box;
    height: 88px;
}
.notice-wrapper .content-wrapper img:first-child{
    width: 34px;
    height: 34px;
}

.notice-wrapper .content-wrapper img:last-child{
    width: 12px;
    height: 22px;
    margin-top: 6px;
}
.notices{
    flex: 1;
    margin: 0 4px 0 10px;
    overflow: hidden;
}
.notices div{
    transition: margin-top 1s;
} 
.notices div p{
    font-size: 30px;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    line-height: 72px;
}

</style>
