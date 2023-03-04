# frozen_string_literal: true

require "spec_helper"

describe "Homepage", type: :system do
  let(:organization) { create(:organization) }
  let(:slider_settings) { {} }
  let!(:slider) { create :content_block, organization: organization, manifest_name: :slider, scope_name: :homepage, settings: slider_settings }
  let!(:tab) { create :content_block, organization: organization, manifest_name: manifest, scope_name: :homepage, settings: tab_settings }
  let(:manifest) { :video_text }
  let(:tab_settings) do
    {
      "title_en" => "This is my title",
      "content_en" => "This is my content",
      "cta_en" => "Call to action",
      "url_en" => "http://mytesturl.me"
    }
  end

  before do
    visit decidim.root_path
  end
end
