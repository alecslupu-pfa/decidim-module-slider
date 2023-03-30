# frozen_string_literal: true

module Decidim
  module Slider
    module Tabs
      module Generic
        class MainCell < Decidim::ViewModel

          def index
            context[:index]
          end

          def content
            translated_attribute(model.settings.content)
          end

          def title
            translated_attribute(model.settings.title)
          end

          def accessibility_label
            translated_attribute(model.settings.accessibility_label)
          end

          def valid_link?
            url.present? && cta.present?
          end

          def url
            translated_attribute(model.settings.url)
          end

          def cta
            translated_attribute(model.settings.cta)
          end

          def secondary_link?
            secondary_url.present? && secondary_cta.present?
          end

          def secondary_url
            translated_attribute(model.settings.secondary_url)
          end

          def secondary_cta
            translated_attribute(model.settings.secondary_cta)
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
