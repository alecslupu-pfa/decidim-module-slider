# frozen_string_literal: true

require "spec_helper"

describe "Homepage", type: :system do
  let(:organization) { create(:organization) }
  let!(:slider) { create :slider, organization: organization }
  let!(:tab) { create :video_text_tab, organization: organization }

  before do
    switch_to_host(organization.host)
    visit decidim.root_path
  end

  it { expect(page).to have_content("foobar") }

  it_behaves_like "accessible page"
end
