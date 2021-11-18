import {createI18n} from 'vue-i18n';
import en from '@/Utils/Locales/En';
import vi from '@/Utils/Locales/Vi';

const i18n = createI18n({
  locale: 'en',
  fallbackLocale: 'en',
  messages: {
    en,
    vi,
  },
  enableInSFC: true,
});

export default i18n;
