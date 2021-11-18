<template>
  <page title="Dashboard">
    <template #header>
      <h2 class="tw-font-semibold tw-text-xl tw-text-gray-800 tw-leading-tight">
        {{ $t('dashboard') }}
      </h2>
    </template>

    <div>
      <div class="tw-max-w-7xl tw-mx-auto sm:tw-px-6 lg:tw-px-8">
        <div class="tw-bg-white tw-overflow-hidden tw-shadow-xl sm:tw-rounded-lg">
          <welcome />
        </div>
      </div>
    </div>
  </page>
</template>

<script>
import {defineComponent} from 'vue';
import Page from '@/Components/Templates/Page';
import Welcome from '@/Components/Molecules/Jetstream/Welcome.vue';

export default defineComponent({
  components: {
    Page,
    Welcome,
  },
});
</script>
