# frozen_string_literal: true

module Decidim
  module Slider
    module Tabs
      module Image
        class MainCell < ::Decidim::Slider::Tabs::Generic::MainCell
          def uploader_name
            :image
          end

          def image_url
            asset.path(variant: :big)
          end
        end
      end
    end
  end
end
