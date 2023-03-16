# frozen_string_literal: true

require "spec_helper"

describe "Homepage", type: :system do
  let(:organization) { create(:organization) }
  let!(:hero) { create :content_block, organization: organization, scope_name: :homepage, manifest_name: :hero }
  let!(:slider) { create :slider, organization: organization }

  context "when has video slider" do
    let!(:tab) { create :video_text_tab, :with_file, organization: organization }
    let!(:tab2) { create :video_text_tab, :with_file, organization: organization }

    it_behaves_like "displays video tabs"
  end

  context "when has video slider" do
    let!(:tab) { create :image_tab, :with_file, organization: organization }
    let!(:tab2) { create :image_tab, :with_file, organization: organization }

    it_behaves_like "displays video tabs"
  end
end
