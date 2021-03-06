<template>
  <jet-action-section>
    <template #title> Two Factor Authentication </template>

    <template #description>
      Add additional security to your account using two factor authentication.
    </template>

    <template #content>
      <h3 v-if="twoFactorEnabled" class="tw-text-lg tw-font-medium tw-text-gray-900">
        You have enabled two factor authentication.
      </h3>

      <h3 v-else class="tw-text-lg tw-font-medium tw-text-gray-900">
        You have not enabled two factor authentication.
      </h3>

      <div class="tw-mt-3 tw-max-w-xl tw-text-sm tw-text-gray-600">
        <p>
          When two factor authentication is enabled, you will be prompted for a secure, random token
          during authentication. You may retrieve this token from your phone's Google Authenticator
          application.
        </p>
      </div>

      <div v-if="twoFactorEnabled">
        <div v-if="qrCode">
          <div class="tw-mt-4 tw-max-w-xl tw-text-sm tw-text-gray-600">
            <p class="tw-font-semibold">
              Two factor authentication is now enabled. Scan the following QR code using your
              phone's authenticator application.
            </p>
          </div>

          <div class="tw-mt-4" v-html="qrCode"></div>
        </div>

        <div v-if="recoveryCodes.length > 0">
          <div class="tw-mt-4 tw-max-w-xl tw-text-sm tw-text-gray-600">
            <p class="tw-font-semibold">
              Store these recovery codes in a secure password manager. They can be used to recover
              access to your account if your two factor authentication device is lost.
            </p>
          </div>

          <div
            class="grid gap-1 max-w-xl tw-mt-4 px-4 py-4 font-mono text-sm bg-gray-100 rounded-lg"
          >
            <div v-for="code in recoveryCodes" :key="code">
              {{ code }}
            </div>
          </div>
        </div>
      </div>

      <div class="tw-mt-5">
        <div v-if="!twoFactorEnabled">
          <jet-confirms-password @confirmed="enableTwoFactorAuthentication">
            <jet-button type="button" :class="{'tw-opacity-25': enabling}" :disabled="enabling">
              Enable
            </jet-button>
          </jet-confirms-password>
        </div>

        <div v-else>
          <jet-confirms-password @confirmed="regenerateRecoveryCodes">
            <jet-secondary-button v-if="recoveryCodes.length > 0" class="tw-mr-3">
              Regenerate Recovery Codes
            </jet-secondary-button>
          </jet-confirms-password>

          <jet-confirms-password @confirmed="showRecoveryCodes">
            <jet-secondary-button v-if="recoveryCodes.length === 0" class="tw-mr-3">
              Show Recovery Codes
            </jet-secondary-button>
          </jet-confirms-password>

          <jet-confirms-password @confirmed="disableTwoFactorAuthentication">
            <jet-danger-button :class="{'tw-opacity-25': disabling}" :disabled="disabling">
              Disable
            </jet-danger-button>
          </jet-confirms-password>
        </div>
      </div>
    </template>
  </jet-action-section>
</template>

<script>
import {defineComponent} from 'vue';
import JetActionSection from '@/Components/Molecules/Jetstream/ActionSection.vue';
import JetButton from '@/Components/Molecules/Jetstream/Button.vue';
import JetConfirmsPassword from '@/Components/Molecules/Jetstream/ConfirmsPassword.vue';
import JetDangerButton from '@/Components/Molecules/Jetstream/DangerButton.vue';
import JetSecondaryButton from '@/Components/Molecules/Jetstream/SecondaryButton.vue';

export default defineComponent({
  components: {
    JetActionSection,
    JetButton,
    JetConfirmsPassword,
    JetDangerButton,
    JetSecondaryButton,
  },

  data() {
    return {
      enabling: false,
      disabling: false,

      qrCode: null,
      recoveryCodes: [],
    };
  },

  computed: {
    twoFactorEnabled() {
      return !this.enabling && this.$page.props.user.two_factor_enabled;
    },
  },

  methods: {
    enableTwoFactorAuthentication() {
      this.enabling = true;

      this.$inertia.post(
        '/user/two-factor-authentication',
        {},
        {
          preserveScroll: true,
          onSuccess: () => Promise.all([this.showQrCode(), this.showRecoveryCodes()]),
          onFinish: () => (this.enabling = false),
        },
      );
    },

    showQrCode() {
      return axios.get('/user/two-factor-qr-code').then((response) => {
        this.qrCode = response.data.svg;
      });
    },

    showRecoveryCodes() {
      return axios.get('/user/two-factor-recovery-codes').then((response) => {
        this.recoveryCodes = response.data;
      });
    },

    regenerateRecoveryCodes() {
      axios.post('/user/two-factor-recovery-codes').then((response) => {
        this.showRecoveryCodes();
      });
    },

    disableTwoFactorAuthentication() {
      this.disabling = true;

      this.$inertia.delete('/user/two-factor-authentication', {
        preserveScroll: true,
        onSuccess: () => (this.disabling = false),
      });
    },
  },
});
</script>
