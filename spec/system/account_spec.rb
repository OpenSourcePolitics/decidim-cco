# frozen_string_literal: true

require "spec_helper"

describe "Account", type: :system do
  let(:user) { create(:user, :confirmed, password: password, password_confirmation: password) }
  let(:password) { "dqCFgjfDbC7dPbrv" }
  let(:organization) { user.organization }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
  end

  describe "navigation" do
    it "shows the account form when clicking on the menu" do
      visit decidim.account_path

      expect(page).to have_css("form.edit_user")
    end
  end

  context "when on the account page" do
    before do
      visit decidim.account_path
    end

    describe "updating personal data" do
      it "updates the user's data" do
        within "form.edit_user" do
          fill_in :user_name, with: "Nikola Tesla"
          fill_in :user_personal_url, with: "https://example.org"
          fill_in :user_about, with: "A Serbian-American inventor, electrical engineer, mechanical engineer, physicist, and futurist."
          find("*[type=submit]").click
        end

        within_flash_messages do
          expect(page).to have_content("successfully")
        end

        within ".title-bar" do
          expect(page).to have_content("Nikola Tesla")
        end
      end
    end

    describe "updating the password" do
      context "when password and confirmation match" do
        it "updates the password successfully" do
          within "form.edit_user" do
            page.find(".change-password").click

            fill_in :user_password, with: "sekritpass123"
            fill_in :user_password_confirmation, with: "sekritpass123"

            find("*[type=submit]").click
          end

          within_flash_messages do
            expect(page).to have_content("successfully")
          end

          expect(user.reload.valid_password?("sekritpass123")).to eq(true)
        end
      end

      context "when passwords don't match" do
        it "doesn't update the password" do
          within "form.edit_user" do
            page.find(".change-password").click

            fill_in :user_password, with: "sekritpass123"
            fill_in :user_password_confirmation, with: "oopseytypo"

            find("*[type=submit]").click
          end

          within_flash_messages do
            expect(page).to have_content("There was a problem")
          end

          expect(user.reload.valid_password?("sekritpass123")).to eq(false)
        end
      end

      context "when updating the email" do
        it "needs to confirm it" do
          within "form.edit_user" do
            fill_in :user_email, with: "foo@bar.com"

            find("*[type=submit]").click
          end

          within_flash_messages do
            expect(page).to have_content("email to confirm")
          end
        end
      end
    end

    context "when on the notifications settings page" do
      before do
        visit decidim.notifications_settings_path
      end

      it "updates the user's notifications" do
        within ".switch.newsletter_notifications" do
          page.find(".switch-paddle").click
        end

        within "form.edit_user" do
          find("*[type=submit]").click
        end

        within_flash_messages do
          expect(page).to have_content("successfully")
        end
      end
    end
  end
end
