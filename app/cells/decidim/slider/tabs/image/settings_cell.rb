# frozen_string_literal: true

module Decidim
  module Slider
    module Tabs
      module Image
        class SettingsCell < Decidim::ViewModel
          alias form model

          def locales
            current_organization.available_locales
          end
        end
      end
    end
  end
end
