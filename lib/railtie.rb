#require 'countries_regions_and_cities_by_peterconsuegra'
#require 'rails'

module GoogleMapsByPete
  class Railtie < Rails::Railtie
    railtie_name :google_maps_by_pete

    rake_tasks do
      path = File.expand_path(__dir__)
      Dir.glob("#{path}/tasks/*.rake").each { |f| load f }
    end
  end
end