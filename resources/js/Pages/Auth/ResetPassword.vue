<template>
  <Head title="Reset Password" />

  <jet-authentication-card>
    <template #logo>
      <jet-authentication-card-logo />
    </template>

    <jet-validation-errors class="mb-4" />

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

      <div class="tw-mt-4">
        <jet-label for="password" value="Password" />
        <jet-input
          id="password"
          v-model="form.password"
          type="password"
          class="tw-mt-1 tw-block tw-w-full"
          required
          autocomplete="new-password"
        />
      </div>

      <div class="tw-mt-4">
        <jet-label for="password_confirmation" value="Confirm Password" />
        <jet-input
          id="password_confirmation"
          v-model="form.password_confirmation"
          type="password"
          class="tw-mt-1 tw-block tw-w-full"
          required
          autocomplete="new-password"
        />
      </div>

      <div class="tw-flex tw-items-center tw-justify-end tw-mt-4">
        <jet-button :class="{'tw-opacity-25': form.processing}" :disabled="form.processing">
          Reset Password
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
    email: String,
    token: String,
  },

  data() {
    return {
      form: this.$inertia.form({
        token: this.token,
        email: this.email,
        password: '',
        password_confirmation: '',
      }),
    };
  },

  methods: {
    submit() {
      this.form.post(this.route('password.update'), {
        onFinish: () => this.form.reset('password', 'password_confirmation'),
      });
    },
  },
});
</script>
