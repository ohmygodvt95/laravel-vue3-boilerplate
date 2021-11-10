<template>
  <app-layout title="API Tokens">
    <template #header>
      <h2 class="tw-font-semibold tw-text-xl tw-text-gray-800 tw-leading-tight">API Tokens</h2>
    </template>

    <div>
      <div class="tw-max-w-7xl tw-mx-auto tw-py-10 sm:tw-px-6 lg:tw-px-8">
        <api-token-manager
          :tokens="tokens"
          :available-permissions="availablePermissions"
          :default-permissions="defaultPermissions"
        />
      </div>
    </div>
  </app-layout>
</template>

<script>
import {defineComponent} from 'vue';
import ApiTokenManager from '@/Pages/API/Partials/ApiTokenManager.vue';
import AppLayout from '@/Layouts/AppLayout.vue';

export default defineComponent({
  components: {
    ApiTokenManager,
    AppLayout,
  },
  props: ['tokens', 'availablePermissions', 'defaultPermissions'],
});
</script>
