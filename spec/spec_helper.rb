if ENV['CODECLIMATE_REPO_TOKEN']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

require "parapets/railties"

Dir[File.expand_path("../support/*.rb", __FILE__)].each { |f| require f }
