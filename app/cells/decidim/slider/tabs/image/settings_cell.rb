# frozen_string_literal: true

module Decidim
  module Slider
    module Tabs
      module Image
        class SettingsCell < Decidim::ViewModel
          alias form model

          def content_block
            options[:content_block]
          end

          def locales
            @locales ||= if @template.respond_to?(:available_locales)
                           Set.new([@template.current_locale] + @template.available_locales).to_a
                         else
                           Decidim.available_locales
                         end
          end
        end
      end
    end
  end
end
