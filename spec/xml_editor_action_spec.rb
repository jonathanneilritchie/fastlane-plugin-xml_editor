describe Fastlane::Actions::XmlEditorAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The xml_editor plugin is working!")

      Fastlane::Actions::XmlEditorAction.run(nil)
    end
  end
end
