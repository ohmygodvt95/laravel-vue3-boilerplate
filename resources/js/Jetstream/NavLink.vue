<template>
  <Link :href="href" :class="classes">
    <slot />
  </Link>
</template>

<script>
import {defineComponent} from 'vue';
import {Link} from '@inertiajs/inertia-vue3';

export default defineComponent({
  components: {
    Link,
  },
  props: ['href', 'active'],

  computed: {
    classes() {
      return this.active
        ? 'tw-inline-flex tw-items-center tw-px-1 tw-pt-1 tw-border-b-2 tw-border-indigo-400 tw-text-sm tw-font-medium tw-leading-5 tw-text-gray-900 focus:tw-outline-none focus:tw-border-indigo-700 tw-transition'
        : 'tw-inline-flex tw-items-center tw-px-1 tw-pt-1 tw-border-b-2 tw-border-indigo-400 tw-text-sm tw-font-medium tw-leading-5 tw-text-gray-900 hover:tw-text-gray-800 hover:tw-bg-gray-50 hover:tw-border-gray-300 focus:tw-outline-none focus:tw-text-gray-800 focus:tw-bg-gray-50 focus:tw-border-gray-300 tw-transition';
    },
  },
});
</script>
