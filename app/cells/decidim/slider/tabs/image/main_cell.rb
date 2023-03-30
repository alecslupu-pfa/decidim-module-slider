# frozen_string_literal: true

module Decidim
  module Slider
    module Tabs
      module Image
        class MainCell < ::Decidim::Slider::Tabs::Generic::MainCell
          def image_url
            model.images_container.attached_uploader(:image).path(variant: :big)
          end

        end
      end
    end
  end
end
