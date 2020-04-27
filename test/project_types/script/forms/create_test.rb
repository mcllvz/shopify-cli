# frozen_string_literal: true

require "project_types/script/test_helper"

module Script
  module Forms
    class CreateTest < MiniTest::Test
      include TestHelpers::Partners

      def setup
        super
        ShopifyCli::ProjectType.load_type(:script)
      end

      def test_returns_all_defined_attributes_if_valid
        name = 'name'
        extension_point = 'discount'
        form = ask(name: name, extension_point: extension_point)
        assert_equal(form.name, name)
        assert_equal(form.extension_point, extension_point)
      end

      def test_asks_extension_point_if_no_flag
        eps = ['discount', 'another']
        Layers::Application::ExtensionPoints.stubs(:types).returns(eps)
        CLI::UI::Prompt.expects(:ask).with('Which extension point do you want to use?', options: eps)
        ask(name: 'name')
      end

      def test_asks_name_if_no_flag
        name = 'name'
        CLI::UI::Prompt.expects(:ask).with('Script Name').returns(name)
        form = ask(extension_point: 'discount')
        assert_equal name, form.name
      end

      def test_name_is_cleaned_after_prompt
        name = 'name with space'
        CLI::UI::Prompt.expects(:ask).with('Script Name').returns(name)
        form = ask(extension_point: 'discount')
        assert_equal 'name_with_space', form.name
      end

      def test_name_is_cleaned_when_using_flag
        form = ask(name: 'name with space', extension_point: 'discount')
        assert_equal 'name_with_space', form.name
      end

      private

      def ask(name: nil, extension_point: nil)
        Create.ask(@context, [], name: name, extension_point: extension_point)
      end
    end
  end
end
