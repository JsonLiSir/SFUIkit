/*global Vue*/
// import Toast from '@/utils/toast.js'
import VueLazyload from 'vue-lazyload'
// Vue.use(Toast)
// 图片懒加载
Vue.use(VueLazyload, {
  preLoad: 1.3,
  error: '',
  loading: '',
  attempt: 1
})
/* weex initialized here, please do not move this line */
const router = require('./router');
const App = require('@/index.vue');
/* eslint-disable no-new */
new Vue(Vue.util.extend({el: '#root', router}, App));
router.push('/');

