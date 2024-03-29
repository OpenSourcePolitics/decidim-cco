# frozen_string_literal: true

module Decidim
  # A command with all the business logic to create a user from omniauth
  class CreateOmniauthRegistration < Rectify::Command
    # Public: Initializes the command.
    #
    # form - A form object with the params.
    def initialize(form, verified_email = nil)
      @form = form
      @verified_email = verified_email
    end

    # Executes the command. Broadcasts these events:
    #
    # - :ok when everything is valid.
    # - :invalid if the form wasn't valid and we couldn't proceed.
    #
    # Returns nothing.
    def call
      verify_oauth_signature!

      begin
        return broadcast(:ok, existing_identity.user) if existing_identity
        return broadcast(:invalid) if form.invalid?

        transaction do
          create_or_find_user
          @identity = create_identity
        end
        trigger_omniauth_registration

        broadcast(:ok, @user)
      rescue ActiveRecord::RecordInvalid => e
        broadcast(:error, e.record)
      end
    end

    private

    attr_reader :form, :verified_email

    def create_or_find_user
      generated_password = SecureRandom.hex

      @user = User.find_or_initialize_by(
        email: verified_email,
        organization: organization
      )

      if !@user.persisted? || @user.invited_to_sign_up?
        @user.email = (verified_email || form.email)
        @user.name = form.name
        @user.nickname = form.normalized_nickname
        @user.newsletter_notifications_at = nil
        @user.email_on_notification = true
        @user.password = generated_password
        @user.password_confirmation = generated_password
        # TODO: raise ActiveRecord::RecordInvalid because of quality setting on uploader, this line is a quick fix
        @user.remote_avatar_url = form.avatar_url if form.avatar_url.present? && !form.avatar_url.end_with?("svg")
        @user.skip_confirmation! if verified_email
        @user.accept_invitation if @user.invited_to_sign_up?
      end

      @user.tos_agreement = "1"
      @user.save!
    end

    def create_identity
      @user.identities.create!(
        provider: form.provider,
        uid: form.uid,
        organization: organization
      )
    end

    def organization
      @form.current_organization
    end

    def existing_identity
      @existing_identity ||= Identity.find_by(
        user: organization.users,
        provider: form.provider,
        uid: form.uid
      )
    end

    def verify_oauth_signature!
      raise InvalidOauthSignature, "Invalid oauth signature: #{form.oauth_signature}" unless signature_valid?
    end

    def signature_valid?
      signature = OmniauthRegistrationForm.create_signature(form.provider, form.uid)
      form.oauth_signature == signature
    end

    def trigger_omniauth_registration
      ActiveSupport::Notifications.publish(
        "decidim.user.omniauth_registration",
        user_id: @user.id,
        identity_id: @identity.id,
        provider: form.provider,
        uid: form.uid,
        email: form.email,
        name: form.name,
        nickname: form.normalized_nickname,
        avatar_url: form.avatar_url,
        raw_data: form.raw_data
      )
    end
  end

  class InvalidOauthSignature < StandardError
  end
end
