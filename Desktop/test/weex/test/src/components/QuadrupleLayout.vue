<template>
<!-- 4图横排-无标题，无更多跳转，只能四图 -->
    <div class="quadruple-wrapper">
        <div class="content-wrapper">
             <a class="double-content" @click="clickLink(item, index)" v-for="(item, index) in content.middleList" :key="index">
               <img v-lazy="item.imgUrl" alt="">
            </a>
        </div>
    </div>
</template>
<script>
export default {
    props: ['content'],
    methods: {
        clickLink(item, index) {
            this.$emit('clickLink', {
                type: 'quadruple',
                no: index + 1,
                tileId: this.content.tileId,
                link: item.link
            })
        }
    }
}
</script>
<style>
.quadruple-wrapper .content-wrapper{
    display: flex;
    font-size: 0;
}
.quadruple-wrapper .content-wrapper a{
    flex: 1;
    display: inline-block;
    width: 25%; 
}
.content-wrapper a img{
    width: 100%;
}
</style>
