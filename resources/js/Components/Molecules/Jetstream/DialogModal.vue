<template>
  <modal :show="show" :max-width="maxWidth" :closeable="closeable" @close="close">
    <div class="tw-px-6 tw-py-4">
      <div class="tw-text-lg">
        <slot name="title"> </slot>
      </div>

      <div class="tw-mt-4">
        <slot name="content"> </slot>
      </div>
    </div>

    <div class="tw-px-6 tw-py-4 bg-gray-100 text-right">
      <slot name="footer"> </slot>
    </div>
  </modal>
</template>

<script>
import {defineComponent} from 'vue';
import Modal from './Modal.vue';

export default defineComponent({
  components: {
    Modal,
  },

  props: {
    show: {
      default: false,
    },
    maxWidth: {
      default: 'sm',
    },
    closeable: {
      default: true,
    },
  },
  emits: ['close'],

  methods: {
    close() {
      this.$emit('close');
    },
  },
});
</script>
