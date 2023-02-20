# frozen_string_literal: true

module Decidim
  module Slider
    module Homepage
      class SettingsCell < Decidim::ViewModel
        alias form model

        def content_block
          options[:content_block]
        end
      end
    end
  end
end
