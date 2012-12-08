require "test_helper"

module AbstractController
  module Testing

    class TestHelper
      BREADCRUMB_NAMES = [:class_level, :object_level, :i18n]

      class << self
        BREADCRUMB_NAMES.each do |name|
          define_method "#{name}_name" do
            "test-breadcrumb-#{name}"
          end

          define_method "#{name}_path" do
            "/test/breadcrumb/#{name}"
          end
        end
      end
    end

    class TestController < AbstractController::Base
      include AbstractController::Callbacks
      include Twitter::Bootstrap::BreadCrumbs

      add_breadcrumb TestHelper.class_level_name, TestHelper.class_level_path

      def index
        add_breadcrumb TestHelper.object_level_name, TestHelper.object_level_path
        add_breadcrumb :test_breadcrumb_i18n, TestHelper.i18n_path
      end

      def class_name
        self.class.name
      end

      def breadcrumbs
        @breadcrumbs
      end
    end

    class BreadcrumbsTest < MiniTest::Unit::TestCase
      def setup
        I18n.stubs(:t).returns(TestHelper.i18n_name)

        @controller = TestController.new
        @controller.process(:index)
      end

      def test_should_have_breadcrumbs
        TestHelper::BREADCRUMB_NAMES.each do |name|
          assert include_breadcrumb?(name), "#{name} breadcrumb not found"
        end
      end

      def include_breadcrumb?(name)
        selected = @controller.breadcrumbs.select { |b|
          b[:name] == TestHelper.send("#{name}_name") && b[:url] == TestHelper.send("#{name}_path")
        }
        selected.any?
      end
    end
  end
end
