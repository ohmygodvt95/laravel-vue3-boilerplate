import {createStore, createLogger} from 'vuex';
import auth from './Auth';

export default createStore({
  modules: {
    auth,
  },
  plugins: process.env.NODE_ENV !== 'production' ? [createLogger()] : [],
});
