# frozen_string_literal: true

module Decidim
  module Slider
    module Tabs
      module Image
        class MainCell < Decidim::ViewModel
          def image_url
            model.images_container.attached_uploader(:image).path(variant: :big)
          end

          def index
            context[:index]
          end

          def text
            translated_attribute(model.settings.text)
          end

          def cta
            translated_attribute(model.settings.cta)
          end

          def url
            translated_attribute(model.settings.url)
          end

          def valid_link?
            url.present? && cta.present?
          end
        end
      end
    end
  end
end
