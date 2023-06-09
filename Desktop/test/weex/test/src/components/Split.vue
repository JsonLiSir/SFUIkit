<template>
<!-- 分割线 -->
    <div class="split-wrapper" v-if="isShow">
    </div>
</template>
<script>
export default {
    props: {
        'isShow': {
            type: Boolean,
            default: true
        }
    }
}
</script>
<style>
.split-wrapper {
    background-color: #f5f7f9;
    width: 100%;
    height: 20px;
}
</style>
