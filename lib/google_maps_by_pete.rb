# frozen_string_literal: true

require_relative "google_maps_by_pete/version"

module GoogleMapsByPete
  class Error < StandardError; end
  # Your code goes here...
end

require_relative "railtie" if defined?(Rails::Railtie)
