# Call timecop directly from rspec metadata, example:
# Rspec.describe 'what_to_test', timecop: { travel: Time.local(2016, 10, 15) } do
AVAILABLE_METHODS = %w(freeze return scale travel).freeze

module TimecopModule
  RSpec.configure do |config|
    config.around(:example, :timecop) do |example|
      example.metadata[:timecop].each do |method, params|
        Timecop.public_send(method, params) if AVAILABLE_METHODS.include? method.to_s
      end
      example.run
    end
  end
end
