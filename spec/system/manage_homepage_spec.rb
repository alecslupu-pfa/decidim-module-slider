# frozen_string_literal: true

require "spec_helper"

describe "Admin manages organization homepage", type: :system do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :admin, :confirmed, organization: organization) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
  end

  context "when editing a persisted content block" do
    let!(:content_block) { create :slider, organization: organization }

    it "updates the settings of the content block" do
      visit decidim_admin.edit_organization_homepage_content_block_path(:slider)

      fill_in(
        :content_block_settings_upload_size,
        with: 1024
      )

      click_button "Update"

      expect(content_block.reload.settings.upload_size).to eq(1024)
    end
  end
end
