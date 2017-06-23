module Fastlane
    module Actions
        class XmlEditorAction < Action
            def self.run(params)
                require "plist"
                require "nokogiri"

                path_to_file = File.expand_path(params[:path_to_xml_file])
                new_attribute_value = params[:new_value]
                xml_is_plist = params[:xml_is_plist]

                if xml_is_plist
                    begin
                        UI.message("Modifying key-value pair in plist file located at: #{path_to_file}")
                        plist = Plist.parse_xml(path_to_file)
                        plist[params[:plist_key]] = new_attribute_value
                        new_plist = Plist::Emit.dump(plist)
                        File.write(path_to_file, new_plist)
                    rescue => exception
                        UI.error(exception)
                        UI.user_error!("Unable to set value to plist file at '#{path_to_file}'")
                    end
                    UI.success("Plist value changed for key: #{params[:plist_key]}")
                else
                    xml_search_path = params[:xml_path]
                    @doc = Nokogiri::XML(File.open(path_to_file))
                    @doc.at_xpath(xml_search_path).content = new_attribute_value
                    File.write(path_to_file, @doc.to_xml)
                    UI.success("XML element value successfully changed!")
                end
            end

            def self.description
                "Generic XML file editor"
            end

            def self.authors
                ["Jonathan Ritchie"]
            end

            def self.details
                "This plugin allows you to modify any element of a standard XML document or plist file"
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
                    type: String),
                    FastlaneCore::ConfigItem.new(key: :xml_is_plist,
                        env_name: "XML_IS_PLIST",
                        description: "Flag indicating if the specified XML file is a plist file",
                        is_string: false,
                        optional: false,
                        default_value: false),
                    FastlaneCore::ConfigItem.new(key: :plist_key,
                        env_name: "PLIST_KEY",
                        description: "Key in the specified property list that will have it's value modified",
                        optional: true,
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
