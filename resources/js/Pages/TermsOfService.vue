<template>
  <Head title="Terms of Service" />

  <div class="tw-font-sans tw-text-gray-900 tw-antialiased">
    <div class="tw-pt-4 tw-bg-gray-100">
      <div class="tw-min-h-screen tw-flex tw-flex-col tw-items-center tw-pt-6 sm:tw-pt-0">
        <div>
          <jet-authentication-card-logo />
        </div>

        <div
          class="
            tw-w-full
            sm:tw-max-w-2xl
            tw-mt-6 tw-p-6 tw-bg-white tw-shadow-md tw-overflow-hidden
            sm:tw-rounded-lg
            tw-prose
          "
          v-html="terms"
        ></div>
      </div>
    </div>
  </div>
</template>

<script>
import {defineComponent} from 'vue';
import {Head} from '@inertiajs/inertia-vue3';
import JetAuthenticationCardLogo from '@/Jetstream/AuthenticationCardLogo.vue';

export default defineComponent({
  components: {
    Head,
    JetAuthenticationCardLogo,
  },
  props: ['terms'],
});
</script>
