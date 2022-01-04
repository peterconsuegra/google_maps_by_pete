require_relative '../peterconsuegra_recipes'
require 'colorize'

#bundle exec rake 'install_google_maps_by_pete[model]'

desc 'install google_maps_by_pete required files'
task :install_google_maps_by_pete, [:model] do |t, args|
  
  #Require all models
  Dir.glob("#{Rails.root}/app/models/*.rb").each { |file| require file }
  
  #Folders path
  rails_app_folder = Dir.pwd 
  gem_folder = File.expand_path('../../../.', __FILE__)
  src_folder="#{gem_folder}/templates/"
  
  #Get scaffold vars
  hash = PeterConsuegraRecipes::get_scaffold_vars(args[:model])
  
  #Adding partial
  PeterConsuegraRecipes::move_template(src_folder,"#{rails_app_folder}/app/views/shared/","_google_maps_by_pete.html.erb")

  #Adding concern file
  PeterConsuegraRecipes::move_template(src_folder,"#{rails_app_folder}/app/controllers/concerns/","maps_by_pete.rb")
  
  #Adding js and css assets
  PeterConsuegraRecipes::move_templates(src_folder,"#{rails_app_folder}/public/google_maps_by_pete/",["jquery-3.6.0.min.js","maps.css"])
     
  #Adding route
  PeterConsuegraRecipes::add_route(hash['base_route'],"set_location","post")
  
  #Adding concern to controller
  PeterConsuegraRecipes::add_concern_to_controller("include MapsByPete\n",hash['controller_file'],hash['controller_class'])
  
  #Adding lat and lng fields to model
  puts "Running command:".blue
  puts "rails generate migration AddFieldsTo#{hash['model_class']} lat:decimal{10-6} lng:decimal{10-6}".green
  `rails generate migration AddFieldsTo#{hash['model_class']} lat:decimal{10-6} lng:decimal{10-6}`
  sleep 2
  puts "Running command:".blue
  puts "rake db:migrate".green
  `rake db:migrate`
  
  #Print necessary code 
  puts "-----------------------------------------".red
  puts "Copy and paste this code in your project".red
  puts "-----------------------------------------".red
  puts "Add jQuery to your layout file:".red
  puts "<script src='/google_maps_by_pete/jquery-3.6.0.min.js'></script>".red
  puts "Add maps.css to your layout file:".red
  puts "<link rel='stylesheet' href='/google_maps_by_pete/maps.css'>".red
  puts "Add this partial to your _form.html.erb file:".red
  puts "<%= render 'shared/google_maps_by_pete', api_key: 'your_google_api_key',  height: '500px', center_map_on: {lat: 25.761681, lng: -80.191788}, model: #{hash['model'].downcase}%>".red
  puts "Allow :lat and :lng params in your controller #{hash['controller_file']}:".red
  puts "params.require(:#{hash['model'].downcase}).permit(:lat, :lng)".red
  
end
