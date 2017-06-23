module Fastlane
    module Actions
        class XmlAddAction < Action
            def self.run(params)
                require "nokogiri"

                path_to_file = File.expand_path(params[:path_to_xml_file])
                xml_search_path = params[:xml_path]
                new_attribute_value = params[:new_value]

                @doc = Nokogiri::XML(File.open(path_to_file))
                @doc.at_xpath(xml_search_path).add_child(new_attribute_value)
                File.write(path_to_file, @doc.to_xml)
                UI.success("XML element added successfully!")
            end

            def self.description
                "Generic XML file add content using XPath"
            end

            def self.authors
                ["Felipe Plets"]
            end

            def self.details
                "This plugin allows you to remove any element of a standard XML document."
            end

            def self.available_options
                [
                    FastlaneCore::ConfigItem.new(key: :path_to_xml_file,
                        env_name: "PATH_TO_XML_FILE",
                        description: "The path to the XML file in your project",
                        optional: false,
                    type: String),
                    FastlaneCore::ConfigItem.new(key: :xml_path,
                        env_name: "XML_PATH",
                        description: "The xmlpath to the XML element that will be modified",
                        optional: true,
                    type: String),
                    FastlaneCore::ConfigItem.new(key: :new_value,
                        env_name: "NEW_VALUE",
                        description: "The new XML attribute value which will be inserted into the XML file",
                        optional: false,
                    type: String)
                ]
            end

            def self.is_supported?(platform)
                [:ios, :mac, :android].include?(platform)
                true
            end
        end
    end
end
