# frozen_string_literal: true

module Decidim
  module Slider
    module Tabs
      module VideoText
        class MainCell < Decidim::ViewModel
          def index
            context[:index]
          end

          def title
            translated_attribute(model.settings.title)
          end

          def content
            translated_attribute(model.settings.content)
          end

          def video_url
            model.images_container.attached_uploader(:video).path
          end

          def valid_link?
            url.present? && cta.present?
          end

          def cta
            translated_attribute(model.settings.cta)
          end

          def url
            translated_attribute(model.settings.url)
          end

          def video_content_type
            model.images_container.video.content_type
          end

          def cache_hash
            hash = []
            hash.push(I18n.locale)
            hash.push(model.cache_key_with_version)
            hash.join(Decidim.cache_key_separator)
          end
        end
      end
    end
  end
end
