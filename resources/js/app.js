import {createApp, h} from 'vue';
import {createInertiaApp} from '@inertiajs/inertia-vue3';
import {InertiaProgress} from '@inertiajs/progress';
import {Quasar} from 'quasar';
import quasarConfigs from './Config/quasar';
import i18n from './Config/i18n';
import store from './Store';
import AppLayout from '@/Layouts/AppLayout';

require('./bootstrap');

const appName = window.document.getElementsByTagName('title')[0]?.innerText || 'Laravel';

createInertiaApp({
  title: (title) => `${title} - ${appName}`,
  resolve: (name) => {
    const page = require(`./Pages/${name}`).default;
    page.layout = page.layout || AppLayout;
    return page;
  },
  setup({el, app, props, plugin}) {
    return createApp({render: () => h(app, props)})
      .use(plugin)
      .use(Quasar, quasarConfigs)
      .use(i18n)
      .use(store)
      .mixin({methods: {route}})
      .mount(el);
  },
});

InertiaProgress.init({color: '#4B5563'});
