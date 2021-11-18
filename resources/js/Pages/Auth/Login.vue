<template>
  <Head title="Log in" />

  <jet-authentication-card>
    <template #logo>
      <jet-authentication-card-logo />
    </template>

    <jet-validation-errors class="tw-mb-4" />

    <div v-if="status" class="tw-mb-4 tw-font-medium tw-text-sm tw-text-green-600">
      {{ status }}
    </div>

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
          autocomplete="current-password"
        />
      </div>

      <div class="tw-block tw-mt-4">
        <label class="tw-flex tw-items-center">
          <jet-checkbox v-model:checked="form.remember" name="remember" />
          <span class="tw-ml-2 tw-text-sm tw-text-gray-600">Remember me</span>
        </label>
      </div>

      <div class="tw-flex tw-items-center tw-justify-end tw-mt-4">
        <Link
          v-if="canResetPassword"
          :href="route('password.request')"
          class="tw-underline tw-text-sm tw-text-gray-600 hover:tw-text-gray-900"
        >
          Forgot your password?
        </Link>

        <jet-button
          class="tw-ml-4"
          :class="{'tw-opacity-25': form.processing}"
          :disabled="form.processing"
        >
          Log in
        </jet-button>
      </div>
    </form>
  </jet-authentication-card>
</template>

<script>
import {defineComponent} from 'vue';
import JetAuthenticationCard from '@/Components/Molecules/Jetstream/AuthenticationCard.vue';
import JetAuthenticationCardLogo from '@/Components/Molecules/Jetstream/AuthenticationCardLogo.vue';
import JetButton from '@/Components/Molecules/Jetstream/Button.vue';
import JetInput from '@/Components/Molecules/Jetstream/Input.vue';
import JetCheckbox from '@/Components/Molecules/Jetstream/Checkbox.vue';
import JetLabel from '@/Components/Molecules/Jetstream/Label.vue';
import JetValidationErrors from '@/Components/Molecules/Jetstream/ValidationErrors.vue';
import {Head, Link} from '@inertiajs/inertia-vue3';

export default defineComponent({
  components: {
    Head,
    JetAuthenticationCard,
    JetAuthenticationCardLogo,
    JetButton,
    JetInput,
    JetCheckbox,
    JetLabel,
    JetValidationErrors,
    Link,
  },

  props: {
    canResetPassword: Boolean,
    status: String,
  },

  data() {
    return {
      form: this.$inertia.form({
        email: '',
        password: '',
        remember: false,
      }),
    };
  },

  methods: {
    submit() {
      this.form
        .transform((data) => ({
          ...data,
          remember: this.form.remember ? 'on' : '',
        }))
        .post(this.route('login'), {
          onFinish: () => this.form.reset('password'),
        });
    },
  },
});
</script>
