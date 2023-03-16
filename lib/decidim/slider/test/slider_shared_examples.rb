# frozen_string_literal: true

shared_examples "displays video tabs" do
  before do
    switch_to_host(organization.host)
    visit decidim.root_path
  end

  it "is expected to find tab elements" do
    expect(page).to have_content(tab.settings.title["en"])
    expect(page).to have_content(tab.settings.cta["en"])
    expect(page).to have_content(tab.settings.content["en"])
  end

  it "is expected to find second tab elements" do
    expect(page).to have_content(tab2.settings.title["en"])
    expect(page).to have_content(tab2.settings.cta["en"])
    expect(page).to have_content(tab2.settings.content["en"])
  end

  it_behaves_like "accessible page" do
    before do
      within ".cookie-warning" do
        click_button "I agree"
      end
    end
  end
end

shared_examples "manageable tabs" do |field_name, file|
  let(:asset_folder) { Dir.new([__dir__, "assets"].join("/")) }

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
