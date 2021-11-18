<template>
  <Head title="Two-factor Confirmation" />

  <jet-authentication-card>
    <template #logo>
      <jet-authentication-card-logo />
    </template>

    <div class="tw-mb-4 tw-text-sm tw-text-gray-600">
      <template v-if="!recovery">
        Please confirm access to your account by entering the authentication code provided by your
        authenticator application.
      </template>

      <template v-else>
        Please confirm access to your account by entering one of your emergency recovery codes.
      </template>
    </div>

    <jet-validation-errors class="tw-mb-4" />

    <form @submit.prevent="submit">
      <div v-if="!recovery">
        <jet-label for="code" value="Code" />
        <jet-input
          id="code"
          ref="code"
          v-model="form.code"
          type="text"
          inputmode="numeric"
          class="tw-mt-1 tw-block tw-w-full"
          autofocus
          autocomplete="one-time-code"
        />
      </div>

      <div v-else>
        <jet-label for="recovery_code" value="Recovery Code" />
        <jet-input
          id="recovery_code"
          ref="recovery_code"
          v-model="form.recovery_code"
          type="text"
          class="tw-mt-1 tw-block tw-w-full"
          autocomplete="one-time-code"
        />
      </div>

      <div class="tw-flex tw-items-center tw-justify-end tw-mt-4">
        <button
          type="button"
          class="tw-text-sm tw-text-gray-600 hover:tw-text-gray-900 tw-underline tw-cursor-pointer"
          @click.prevent="toggleRecovery"
        >
          <template v-if="!recovery"> Use a recovery code </template>

          <template v-else> Use an authentication code </template>
        </button>

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
      recovery: false,
      form: this.$inertia.form({
        code: '',
        recovery_code: '',
      }),
    };
  },

  methods: {
    toggleRecovery() {
      this.recovery ^= true;

      this.$nextTick(() => {
        if (this.recovery) {
          this.$refs.recovery_code.focus();
          this.form.code = '';
        } else {
          this.$refs.code.focus();
          this.form.recovery_code = '';
        }
      });
    },

    submit() {
      this.form.post(this.route('two-factor.login'));
    },
  },
});
</script>
