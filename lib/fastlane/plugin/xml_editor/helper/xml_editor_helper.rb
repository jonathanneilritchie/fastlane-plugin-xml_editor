module Fastlane
  module Helper
    class XmlEditorHelper
      # class methods that you define here become available in your action
      # as `Helper::XmlEditorHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the xml_editor plugin helper!")
      end
    end
  end
end
