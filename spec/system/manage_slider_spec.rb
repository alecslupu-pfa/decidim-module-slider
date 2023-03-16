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
    shared_examples "manageable tabs" do |field_name, file|
      let(:asset_folder) { Dir.new([__dir__, "..", "..", "lib", "decidim", "slider", "test", "assets"].join("/")) }

      it "saves the data" do
        visit decidim_admin.decidim_admin_slider_path
        within ".grid-container" do
          find("svg.icon--pencil").click
        end

        fill_in_i18n(:content_block_settings_title, "#content_block-settings--title-tabs", **title)
        fill_in_i18n(:content_block_settings_content, "#content_block-settings--content-tabs", **content)
        fill_in_i18n(:content_block_settings_cta, "#content_block-settings--cta-tabs", **cta)
        fill_in_i18n(:content_block_settings_url, "#content_block-settings--url-tabs", **url)
        attach_file field_name, File.expand_path(File.join(asset_folder, file))

        click_button "Save"

        tab.reload
        expect(tab.settings.title).to eq(title)
        expect(tab.settings.content).to eq(content)
        expect(tab.settings.cta).to eq(cta)
        expect(tab.settings.url).to eq(url)
      end
    end

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
    shared_examples "addable tabs" do |link_caption|
      before do
        click_button("Add Tabs")
        within ".add-components" do
          click_link link_caption
        end
      end

      it { within(".grid-container") { expect(page).to have_content(link_caption) } }
      it { expect(Decidim::ContentBlock.count).to eq 1 }
    end

    context "when image" do
      it_behaves_like "addable tabs", "Image"
    end

    context "when video" do
      it_behaves_like "addable tabs", "Video and Text"
    end
  end

  context "when removing tabs" do
    shared_examples "removes the tabs" do
      it "saves the data" do
        expect(Decidim::ContentBlock.count).to eq 1

        visit decidim_admin.decidim_admin_slider_path
        within ".grid-container" do
          find("svg.icon--x").click
        end
        within ".confirm-reveal" do
          click_link "OK"
        end
        expect(Decidim::ContentBlock.count).to eq 0
      end
    end

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
