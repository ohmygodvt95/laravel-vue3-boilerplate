<template>
  <Head title="Secure Area" />

  <jet-authentication-card>
    <template #logo>
      <jet-authentication-card-logo />
    </template>

    <div class="tw-mb-4 tw-text-sm tw-text-gray-600">
      This is a secure area of the application. Please confirm your password before continuing.
    </div>

    <jet-validation-errors class="tw-mb-4" />

    <form @submit.prevent="submit">
      <div>
        <jet-label for="password" value="Password" />
        <jet-input
          id="password"
          v-model="form.password"
          type="password"
          class="tw-mt-1 tw-block tw-w-full"
          required
          autocomplete="current-password"
          autofocus
        />
      </div>

      <div class="tw-flex tw-justify-end tw-mt-4">
        <jet-button
          class="tw-ml-4"
          :class="{'tw-opacity-25': form.processing}"
          :disabled="form.processing"
        >
          Confirm
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

  data() {
    return {
      form: this.$inertia.form({
        password: '',
      }),
    };
  },

  methods: {
    submit() {
      this.form.post(this.route('password.confirm'), {
        onFinish: () => this.form.reset(),
      });
    },
  },
});
</script>
