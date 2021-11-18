<template>
  <Head title="Email Verification" />

  <jet-authentication-card>
    <template #logo>
      <jet-authentication-card-logo />
    </template>

    <div class="tw-mb-4 tw-text-sm tw-text-gray-600">
      Thanks for signing up! Before getting started, could you verify your email address by clicking
      on the link we just emailed to you? If you didn't receive the email, we will gladly send you
      another.
    </div>

    <div v-if="verificationLinkSent" class="tw-mb-4 tw-font-medium tw-text-sm tw-text-green-600">
      A new verification link has been sent to the email address you provided during registration.
    </div>

    <form @submit.prevent="submit">
      <div class="tw-mt-4 tw-flex tw-items-center tw-justify-between">
        <jet-button :class="{'opacity-25': form.processing}" :disabled="form.processing">
          Resend Verification Email
        </jet-button>

        <Link
          :href="route('logout')"
          method="post"
          as="button"
          class="tw-underline tw-text-sm tw-text-gray-600 hover:tw-text-gray-900"
          >Log Out</Link
        >
      </div>
    </form>
  </jet-authentication-card>
</template>

<script>
import {defineComponent} from 'vue';
import JetAuthenticationCard from '@/Components/Molecules/Jetstream/AuthenticationCard.vue';
import JetAuthenticationCardLogo from '@/Components/Molecules/Jetstream/AuthenticationCardLogo.vue';
import JetButton from '@/Components/Molecules/Jetstream/Button.vue';
import {Head, Link} from '@inertiajs/inertia-vue3';
import BlankLayout from '@/Layouts/BlankLayout';

export default defineComponent({
  layout: BlankLayout,

  components: {
    Head,
    JetAuthenticationCard,
    JetAuthenticationCardLogo,
    JetButton,
    Link,
  },

  props: {
    status: String,
  },

  data() {
    return {
      form: this.$inertia.form(),
    };
  },

  computed: {
    verificationLinkSent() {
      return this.status === 'verification-link-sent';
    },
  },

  methods: {
    submit() {
      this.form.post(this.route('verification.send'));
    },
  },
});
</script>
