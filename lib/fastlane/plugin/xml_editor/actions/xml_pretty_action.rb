module Fastlane
    module Actions
        class XmlPrettyAction < Action
            def self.run(params)
                require "nokogiri"

                path_to_file = File.expand_path(params[:path_to_xml_file])

                @doc = Nokogiri::XML(File.open(path_to_file)) do |config|
                  config.default_xml.noblanks
                end
                File.write(path_to_file, @doc.to_xml(:indent => 2))
                UI.success("XML pretty applied successfully!")
            end

            def self.description
                "Generic XML file to format content"
            end

            def self.authors
                ["Felipe Plets"]
            end

            def self.details
                "This plugin allows you to format a standard XML document."
            end

            def self.available_options
                [
                    FastlaneCore::ConfigItem.new(key: :path_to_xml_file,
                        env_name: "PATH_TO_XML_FILE",
                        description: "The path to the XML file in your project",
                        optional: false,
                    type: String),
                ]
            end

            def self.is_supported?(platform)
                [:ios, :mac, :android].include?(platform)
                true
            end
        end
    end
end
