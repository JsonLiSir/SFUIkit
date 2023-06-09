
<template>
<!-- 轮播图（单图）-无标题，无更多跳转，最多可三图轮播，一图时则为单图 -->
    <div class="single-wrapper">
        <Split/>
        <!-- 异步加载轮播图 -->
        <Swiper v-if="content.middleList.length > 0" :autoPlay="true" :showIndicator="true" interval="2500" duration="500">
            <Slide @click="clickLink(item, index)" v-for="(item, index) in content.middleList" :key="index">
                <img v-lazy="item.imgUrl" alt="">
            </Slide>
        </Swiper>
    </div>
</template>
<script>
import Split from '@/components/Split'
import Swiper from '@/components/Swiper'
import Slide from '@/components/Slide'
export default {
    props: ['content'],
    created() {
    },
    methods: {
        clickLink(item, index) {
            this.$emit('clickLink', {
                type: 'single',
                no: index + 1,
                tileId: this.content.tileId,
                link: item.link
            })
        }
    },
    components: {
		Split,
        Swiper,
        Slide
    }
}
</script>
<style>
.single-wrapper img {
    width: 100%
}
.single-wrapper .wh_slide {
    min-height: 10px
}
/* change swiper item */
.single-wrapper .wh_indicator {
    bottom: 5px;
}
.single-wrapper .wh_indicator_item {
    width: 10px;
    height: 10px;
    margin: 0px 6px;
    background: #fff2f1;
    border-radius: 5px;
}
/* selected color */
.single-wrapper .wh_show_bgcolor {
    background: #ffa49a
}
</style>
