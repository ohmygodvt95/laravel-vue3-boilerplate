<template>
  <jet-form-section @submitted="updatePassword">
    <template #title> Update Password </template>

    <template #description>
      Ensure your account is using a long, random password to stay secure.
    </template>

    <template #form>
      <div class="tw-col-span-6 sm:tw-col-span-4">
        <jet-label for="current_password" value="Current Password" />
        <jet-input
          id="current_password"
          ref="current_password"
          v-model="form.current_password"
          type="password"
          class="tw-mt-1 tw-block tw-w-full"
          autocomplete="current-password"
        />
        <jet-input-error :message="form.errors.current_password" class="tw-mt-2" />
      </div>

      <div class="tw-col-span-6 sm:tw-col-span-4">
        <jet-label for="password" value="New Password" />
        <jet-input
          id="password"
          ref="password"
          v-model="form.password"
          type="password"
          class="tw-mt-1 tw-block tw-w-full"
          autocomplete="new-password"
        />
        <jet-input-error :message="form.errors.password" class="tw-mt-2" />
      </div>

      <div class="tw-col-span-6 sm:tw-col-span-4">
        <jet-label for="password_confirmation" value="Confirm Password" />
        <jet-input
          id="password_confirmation"
          v-model="form.password_confirmation"
          type="password"
          class="tw-mt-1 tw-block tw-w-full"
          autocomplete="new-password"
        />
        <jet-input-error :message="form.errors.password_confirmation" class="tw-mt-2" />
      </div>
    </template>

    <template #actions>
      <jet-action-message :on="form.recentlySuccessful" class="tw-mr-3">
        Saved.
      </jet-action-message>

      <jet-button :class="{'tw-opacity-25': form.processing}" :disabled="form.processing">
        Save
      </jet-button>
    </template>
  </jet-form-section>
</template>

<script>
import {defineComponent} from 'vue';
import JetActionMessage from '@/Components/Molecules/Jetstream/ActionMessage.vue';
import JetButton from '@/Components/Molecules/Jetstream/Button.vue';
import JetFormSection from '@/Components/Molecules/Jetstream/FormSection.vue';
import JetInput from '@/Components/Molecules/Jetstream/Input.vue';
import JetInputError from '@/Components/Molecules/Jetstream/InputError.vue';
import JetLabel from '@/Components/Molecules/Jetstream/Label.vue';

export default defineComponent({
  components: {
    JetActionMessage,
    JetButton,
    JetFormSection,
    JetInput,
    JetInputError,
    JetLabel,
  },

  data() {
    return {
      form: this.$inertia.form({
        current_password: '',
        password: '',
        password_confirmation: '',
      }),
    };
  },

  methods: {
    updatePassword() {
      this.form.put(route('user-password.update'), {
        errorBag: 'updatePassword',
        preserveScroll: true,
        onSuccess: () => this.form.reset(),
        onError: () => {
          if (this.form.errors.password) {
            this.form.reset('password', 'password_confirmation');
            this.$refs.password.focus();
          }

          if (this.form.errors.current_password) {
            this.form.reset('current_password');
            this.$refs.current_password.focus();
          }
        },
      });
    },
  },
});
</script>
