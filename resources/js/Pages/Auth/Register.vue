<template>
  <Head title="Register" />

  <jet-authentication-card>
    <template #logo>
      <jet-authentication-card-logo />
    </template>

    <jet-validation-errors class="tw-mb-4" />

    <form @submit.prevent="submit">
      <div>
        <jet-label for="name" value="Name" />
        <jet-input
          id="name"
          v-model="form.name"
          type="text"
          class="tw-mt-1 tw-block tw-w-full"
          required
          autofocus
          autocomplete="name"
        />
      </div>

      <div class="tw-mt-4">
        <jet-label for="email" value="Email" />
        <jet-input
          id="email"
          v-model="form.email"
          type="email"
          class="tw-mt-1 tw-block tw-w-full"
          required
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

      <div v-if="$page.props.jetstream.hasTermsAndPrivacyPolicyFeature" class="tw-mt-4">
        <jet-label for="terms">
          <div class="tw-flex tw-items-center">
            <jet-checkbox id="terms" v-model:checked="form.terms" name="terms" />

            <div class="tw-ml-2">
              I agree to the
              <a
                target="_blank"
                :href="route('terms.show')"
                class="tw-underline tw-text-sm tw-text-gray-600 hover:tw-text-gray-900"
                >Terms of Service</a
              >
              and
              <a
                target="_blank"
                :href="route('policy.show')"
                class="tw-underline tw-text-sm tw-text-gray-600 hover:tw-text-gray-900"
                >Privacy Policy</a
              >
            </div>
          </div>
        </jet-label>
      </div>

      <div class="tw-flex tw-items-center tw-justify-end tw-mt-4">
        <Link
          :href="route('login')"
          class="tw-underline tw-text-sm tw-text-gray-600 hover:tw-text-gray-900"
        >
          Already registered?
        </Link>

        <jet-button
          class="tw-ml-4"
          :class="{'opacity-25': form.processing}"
          :disabled="form.processing"
        >
          Register
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
import BlankLayout from '@/Layouts/BlankLayout';

export default defineComponent({
  layout: BlankLayout,

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

  data() {
    return {
      form: this.$inertia.form({
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
        terms: false,
      }),
    };
  },

  methods: {
    submit() {
      this.form.post(this.route('register'), {
        onFinish: () => this.form.reset('password', 'password_confirmation'),
      });
    },
  },
});
</script>
