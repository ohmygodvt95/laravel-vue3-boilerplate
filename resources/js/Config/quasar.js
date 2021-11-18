import 'quasar/dist/quasar.css';
import '@quasar/extras/material-icons/material-icons.css';
import {Dialog, Notify} from 'quasar';

export default {
  config: {
    notify: {},
  },
  plugins: {
    Dialog,
    Notify,
  },
};
