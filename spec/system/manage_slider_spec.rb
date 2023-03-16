# frozen_string_literal: true

require "spec_helper"

describe "Manage slider tabs", type: :system do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :admin, :confirmed, organization: organization) }
  let(:title) { { en: "A fancy newsletter for Me", es: "Un correo mu para me", ca: "Un correu electrònic" } }
  let(:content) { { en: "My fancy newsletter ", es: "Un correo muy chulo", ca: "Un correu electrònic flipant" } }
  let(:cta) { { en: "A fancy CTA", es: "A ES fancy CTA", ca: "A CA fancy CTA" } }
  let(:url) { { en: "https://decidim.org/", es: "https://decidim.org/es/", ca: "https://decidim.org/ca/" } }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim_admin.decidim_admin_slider_path
  end

  it { expect(page).to have_content("The title for Tabs") }

  context "when managing tabs" do
    before do
      switch_to_host(organization.host)
      login_as user, scope: :user
    end

    context "when manage image" do
      let!(:tab) { create :image_tab, organization: organization }

      it_behaves_like "manageable tabs", :content_block_images_image, "city.jpeg"
    end

    context "when manage video text" do
      let!(:tab) { create :video_text_tab, organization: organization }

      it_behaves_like "manageable tabs", :content_block_images_video, "mov_bbb.mp4"
    end
  end

  context "when adding tabs" do
    context "when image" do
      it_behaves_like "addable tabs", "Image"
    end

    context "when video" do
      it_behaves_like "addable tabs", "Video and Text"
    end
  end

  context "when removing tabs" do
    context "when manage image" do
      let!(:tab) { create :image_tab, organization: organization }

      it_behaves_like "removes the tabs"
    end

    context "when manage image" do
      let!(:tab) { create :video_text_tab, organization: organization }

      it_behaves_like "removes the tabs"
    end
  end
end
