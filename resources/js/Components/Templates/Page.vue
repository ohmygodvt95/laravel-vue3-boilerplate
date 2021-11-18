<template>
  <Head :title="props.title" />
  <!-- Page Heading -->
  <header v-if="$slots.header" class="tw-max-w-7xl tw-mx-auto tw-py-10 sm:tw-px-6 lg:tw-px-8">
    <slot name="header" />
  </header>

  <!-- Page Content -->
  <main>
    <slot></slot>
  </main>
</template>

<script setup>
import {defineProps} from 'vue';
import {Head} from '@inertiajs/inertia-vue3';

const props = defineProps({
  title: String,
});
</script>
