<template>
<!-- 借贷产品列表-有标题，有更多跳转 -->
    <div class="loan-product-wrapper">
        <Split/>
        <Title :title="title" :isMoreShow="isMoreShow" @clickHandler="clickMore"/>
        <div class="content-wrapper">
            <div class="loan-body"  v-for="(item, index) in content.middleList"
                :key="index" @click="loanClick(item, index)">
                <img v-lazy="item.logo" alt="" class="loan-img">
                <h3 class="loan-title">{{item.lp_name}}</h3>
                <button type="button" class="loan-button">立即申请</button>
                <p class="loan-price">{{item.loan_val}}</p>
                <p class="loan-content">{{item.loan_giventime}}放款 | {{item.loan_interest_unit}}{{item.loan_interest}}% | 可借{{item.loan_limit_time}}</p>
                <p class="loan-condition">{{item.loan_qualification}}</p>
            </div>
        </div>
    </div>
</template>
<script>
import Split from '@/components/Split'
import Title from '@/components/Title'

export default {
    props: ['isMoreShow', 'content', 'title'],
	components: {
		Split,
		Title
    },
    created() {
        this.content.middleList.sort(function(a, b) {
            if (a.sort > b.sort) {
                return 1
            } else if (b.sort === a.sort) {
                return 0
            } else {
                return -1
            }
        })
    },
    methods: {
        loanClick(item, index) {
            this.$emit('clickLink', {
                type: 'loanproduct',
                no: index + 1,
                tileId: this.content.tileId,
                link: item.link_url
            })
        },
        clickMore() {
            this.$emit('clickTitle', {
                type: 'loanproduct',
                tileId: this.content.tileId,
                link: this.content.bottomList[0] && this.content.bottomList[0].link
            })
        }
    }
}
</script>
<style>
.loan-product-wrapper .content-wrapper{
    background: #fff;
    padding: 0 30px;
}
.loan-body{
    padding: 32px 0 30px 28px;
    box-sizing: border-box;
    min-height: 280px;
}
.loan-body:not(:last-child){
    /* @include hairline(bottom, $border-1px-color); */
}
.loan-img{
    width: 72px;
    height: 72px;
}
.loan-title{
    display: inline-block;
    color: #333;
    font-size: 28px;
    max-width: 340px;
    padding: 20px 24px;
    vertical-align: 24px;
}
.loan-price{
    color: #fff;
    font-size: 30px;
    max-width: 90%;
    margin: 10px 0 28px;
    font-weight: 500;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
}
.loan-content{
    color: #666;
    font-size: 30px;
    max-width: 90%;
    margin: 28px 0 20px;
    line-height: 32px;
}
.loan-condition{
    color: #666;
    font-size: 30px;
    max-width: 90%;
    line-height: 32px;
}
.loan-button{
    display: inline-block;
    outline: none;
    float: right;
    background: #fff;
    color: #fe5850;
    font-size: 28;
    border-radius: 12px;
    border: 2px solid #fe5850;
    width: 164px;
    height: 62px;
}
</style>
