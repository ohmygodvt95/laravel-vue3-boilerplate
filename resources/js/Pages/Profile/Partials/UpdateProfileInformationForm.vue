<template>
  <jet-form-section @submitted="updateProfileInformation">
    <template #title> Profile Information </template>

    <template #description> Update your account's profile information and email address. </template>

    <template #form>
      <!-- Profile Photo -->
      <div v-if="$page.props.jetstream.managesProfilePhotos" class="tw-col-span-6 sm:tw-col-span-4">
        <!-- Profile Photo File Input -->
        <input ref="photo" type="file" class="tw-hidden" @change="updatePhotoPreview" />

        <jet-label for="photo" value="Photo" />

        <!-- Current Profile Photo -->
        <div v-show="!photoPreview" class="tw-mt-2">
          <img
            :src="user.profile_photo_url"
            :alt="user.name"
            class="tw-rounded-full tw-h-20 tw-w-20 tw-object-cover"
          />
        </div>

        <!-- New Profile Photo Preview -->
        <div v-show="photoPreview" class="tw-mt-2">
          <span
            class="
              tw-block tw-rounded-full tw-w-20 tw-h-20 tw-bg-cover tw-bg-no-repeat tw-bg-center
            "
            :style="'background-image: url(\'' + photoPreview + '\');'"
          >
          </span>
        </div>

        <jet-secondary-button class="tw-mt-2 tw-mr-2" type="button" @click.prevent="selectNewPhoto">
          Select A New Photo
        </jet-secondary-button>

        <jet-secondary-button
          v-if="user.profile_photo_path"
          type="button"
          class="tw-mt-2"
          @click.prevent="deletePhoto"
        >
          Remove Photo
        </jet-secondary-button>

        <jet-input-error :message="form.errors.photo" class="tw-mt-2" />
      </div>

      <!-- Name -->
      <div class="tw-col-span-6 sm:tw-col-span-4">
        <jet-label for="name" value="Name" />
        <jet-input
          id="name"
          v-model="form.name"
          type="text"
          class="tw-mt-1 tw-block tw-w-full"
          autocomplete="name"
        />
        <jet-input-error :message="form.errors.name" class="tw-mt-2" />
      </div>

      <!-- Email -->
      <div class="tw-col-span-6 sm:tw-col-span-4">
        <jet-label for="email" value="Email" />
        <jet-input
          id="email"
          v-model="form.email"
          type="email"
          class="tw-mt-1 tw-block tw-w-full"
        />
        <jet-input-error :message="form.errors.email" class="tw-mt-2" />
      </div>
    </template>

    <template #actions>
      <jet-action-message :on="form.recentlySuccessful" class="tw-mr-3">
        Saved.
      </jet-action-message>

      <jet-button :class="tw - {'opacity-25': form.processing}" :disabled="form.processing">
        Save
      </jet-button>
    </template>
  </jet-form-section>
</template>

<script>
import {defineComponent} from 'vue';
import JetButton from '@/Components/Molecules/Jetstream/Button.vue';
import JetFormSection from '@/Components/Molecules/Jetstream/FormSection.vue';
import JetInput from '@/Components/Molecules/Jetstream/Input.vue';
import JetInputError from '@/Components/Molecules/Jetstream/InputError.vue';
import JetLabel from '@/Components/Molecules/Jetstream/Label.vue';
import JetActionMessage from '@/Components/Molecules/Jetstream/ActionMessage.vue';
import JetSecondaryButton from '@/Components/Molecules/Jetstream/SecondaryButton.vue';

export default defineComponent({
  components: {
    JetActionMessage,
    JetButton,
    JetFormSection,
    JetInput,
    JetInputError,
    JetLabel,
    JetSecondaryButton,
  },

  props: ['user'],

  data() {
    return {
      form: this.$inertia.form({
        _method: 'PUT',
        name: this.user.name,
        email: this.user.email,
        photo: null,
      }),

      photoPreview: null,
    };
  },

  methods: {
    updateProfileInformation() {
      if (this.$refs.photo) {
        this.form.photo = this.$refs.photo.files[0];
      }

      this.form.post(route('user-profile-information.update'), {
        errorBag: 'updateProfileInformation',
        preserveScroll: true,
        onSuccess: () => this.clearPhotoFileInput(),
      });
    },

    selectNewPhoto() {
      this.$refs.photo.click();
    },

    updatePhotoPreview() {
      const photo = this.$refs.photo.files[0];

      if (!photo) return;

      const reader = new FileReader();

      reader.onload = (e) => {
        this.photoPreview = e.target.result;
      };

      reader.readAsDataURL(photo);
    },

    deletePhoto() {
      this.$inertia.delete(route('current-user-photo.destroy'), {
        preserveScroll: true,
        onSuccess: () => {
          this.photoPreview = null;
          this.clearPhotoFileInput();
        },
      });
    },

    clearPhotoFileInput() {
      if (this.$refs.photo?.value) {
        this.$refs.photo.value = null;
      }
    },
  },
});
</script>
