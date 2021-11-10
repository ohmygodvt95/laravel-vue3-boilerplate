<template>
  <input
    v-model="proxyChecked"
    type="checkbox"
    :value="value"
    class="
      tw-rounded tw-border-gray-300 tw-text-indigo-600 tw-shadow-sm
      focus:tw-border-indigo-300 focus:tw-ring focus:tw-ring-indigo-200 focus:tw-ring-opacity-50
    "
  />
</template>

<script>
import {defineComponent} from 'vue';

export default defineComponent({
  props: {
    checked: {
      type: [Array, Boolean],
      default: false,
    },
    value: {
      default: null,
    },
  },
  emits: ['update:checked'],

  computed: {
    proxyChecked: {
      get() {
        return this.checked;
      },

      set(val) {
        this.$emit('update:checked', val);
      },
    },
  },
});
</script>
