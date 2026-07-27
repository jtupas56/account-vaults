ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"  # ✅ Add this

# ✅ Generate HTML report
Minitest::Reporters.use! Minitest::Reporters::HtmlReporter.new(
  output_dir: "public/test_reports"
)

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end

module ActiveSupport
  class TestCase
    parallelize(workers: :number_of_processors)
    fixtures :all
  end
end