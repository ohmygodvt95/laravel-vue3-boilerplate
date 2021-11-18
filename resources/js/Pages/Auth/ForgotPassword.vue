<template>
  <Head title="Forgot Password" />

  <jet-authentication-card>
    <template #logo>
      <jet-authentication-card-logo />
    </template>

    <div class="tw-mb-4 tw-text-sm tw-text-gray-600">
      Forgot your password? No problem. Just let us know your email address and we will email you a
      password reset link that will allow you to choose a new one.
    </div>

    <div v-if="status" class="tw-mb-4 tw-font-medium tw-text-sm tw-text-green-600">
      {{ status }}
    </div>

    <jet-validation-errors class="tw-mb-4" />

    <form @submit.prevent="submit">
      <div>
        <jet-label for="email" value="Email" />
        <jet-input
          id="email"
          v-model="form.email"
          type="email"
          class="tw-mt-1 tw-block tw-w-full"
          required
          autofocus
        />
      </div>

      <div class="tw-flex tw-items-center tw-justify-end tw-mt-4">
        <jet-button :class="{'opacity-25': form.processing}" :disabled="form.processing">
          Email Password Reset Link
        </jet-button>
      </div>
    </form>
  </jet-authentication-card>
</template>

<script>
import {defineComponent} from 'vue';
import {Head} from '@inertiajs/inertia-vue3';
import JetAuthenticationCard from '@/Components/Molecules/Jetstream/AuthenticationCard.vue';
import JetAuthenticationCardLogo from '@/Components/Molecules/Jetstream/AuthenticationCardLogo.vue';
import JetButton from '@/Components/Molecules/Jetstream/Button.vue';
import JetInput from '@/Components/Molecules/Jetstream/Input.vue';
import JetLabel from '@/Components/Molecules/Jetstream/Label.vue';
import JetValidationErrors from '@/Components/Molecules/Jetstream/ValidationErrors.vue';
import BlankLayout from '@/Layouts/BlankLayout';

export default defineComponent({
  layout: BlankLayout,

  components: {
    Head,
    JetAuthenticationCard,
    JetAuthenticationCardLogo,
    JetButton,
    JetInput,
    JetLabel,
    JetValidationErrors,
  },

  props: {
    status: String,
  },

  data() {
    return {
      form: this.$inertia.form({
        email: '',
      }),
    };
  },

  methods: {
    submit() {
      this.form.post(this.route('password.email'));
    },
  },
});
</script>
