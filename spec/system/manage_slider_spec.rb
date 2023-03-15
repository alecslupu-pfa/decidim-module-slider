# frozen_string_literal: true

require "spec_helper"

describe "Manage slider tabs", type: :system do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :admin, :confirmed, organization: organization) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim_admin.decidim_admin_slider_path
  end

  it { expect(page).to have_content("The title for Tabs") }

  context "when adding tabs" do
    context "when image" do
      before do
        click_button("Add Tabs")
        within ".add-components" do
          click_link "Image"
        end
      end

      it { within(".grid-container") { expect(page).to have_content("Image") } }
    end

    context "when video" do
      before do
        click_button("Add Tabs")
        within ".add-components" do
          click_link "Video and Text"
        end
      end

      it { within(".grid-container") { expect(page).to have_content("Video and Text") } }
    end
  end
end
