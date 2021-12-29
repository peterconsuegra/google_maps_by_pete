require_relative '../peterconsuegra_recipes'
require 'fileutils'
require "tty-file"

#bundle exec rake 'install_google_maps_by_pete[place]'

desc 'install_google_maps_by_pete required files'
task :install_google_maps_by_pete, [:model] do |t, args|
  
  #require all models
  Dir.glob("#{Rails.root}/app/models/*.rb").each { |file| require file }
  
  #route files
  rails_app_folder = Dir.pwd 
  gem_folder = File.expand_path('../../../.', __FILE__)
    
  #Get scaffold vars
  hash = PeterConsuegraRecipes::get_scaffold_vars(args[:model])
  
  #Templates folder
  src_folder="#{gem_folder}/templates/"
  
  #Adding partials
  dest_folder="#{rails_app_folder}/app/views/shared/"
  file="_google_maps_by_pete.html.erb"
  FileUtils.mkdir_p dest_folder
  FileUtils.cp src_folder+file,dest_folder+file
  puts "File copied to: #{dest_folder+file}".green
  
  #Adding concern
  dest_folder="#{rails_app_folder}/app/controllers/concerns/"
  file="maps_by_pete.rb"
  FileUtils.mkdir_p dest_folder
  FileUtils.cp src_folder+file,dest_folder+file
  puts "File copied to: #{dest_folder+file}".green
  
  #Copy maps.css file
  dest_folder="#{rails_app_folder}/public/google_maps_by_pete/"
  file="maps.css"
  FileUtils.mkdir_p dest_folder
  FileUtils.cp src_folder+file,dest_folder+file
  puts "File copied to: #{dest_folder+file}".green
  
  #Copy jquery-3.6.0.min.js file
  dest_folder="#{rails_app_folder}/public/google_maps_by_pete/"
  file="jquery-3.6.0.min.js"
  FileUtils.mkdir_p dest_folder
  FileUtils.cp src_folder+file,dest_folder+file
  puts "File copied to: #{dest_folder+file}".green
   
  #Adding route to routes.rb
  file="#{rails_app_folder}/config/routes.rb"
  code = "post '/#{hash['base_route']}/set_location', to: '#{hash['base_route']}#set_location'"
  PeterConsuegraRecipes::append_before_last_appearance_of("end",code,file)
  puts "Adding route: #{code}".blue
  
  #Adding include GoogleMapsByPete in Controller
  file="#{rails_app_folder}/app/controllers/#{hash['controller_file']}"
  code="include MapsByPete\n"
  TTY::File.inject_into_file file, code, after: "class #{hash['controller_class']} < ApplicationController\n"
  puts "Adding concern to controller #{file}: include MapsByPete".blue
  
  #Add required migration
  `rails generate migration AddFieldsTo#{hash['model_class']} lat:decimal{10-6} lng:decimal{10-6}`
  sleep 2
  `rake db:migrate`
  
  #Print necessary code 
  puts "-----------------------------------------".red
  puts "Copy and paste this code in your project".red
  puts "-----------------------------------------".red
  puts "Add jQuery to your layout file:".red
  puts "<script src='/google_maps_by_pete/jquery-3.6.0.min.js'></script>".red
  puts "Add maps.css to your layout file:".red
  puts "<link rel='stylesheet' href='/google_maps_by_pete/maps.css'>".red
  puts "Add this to your _form.html.erb file:".red
  puts "<%= render 'shared/google_maps_by_pete', api_key: 'your_google_api_key',  height: '500px', center_map_on: {lat: 25.761681, lng: -80.191788}, model: #{hash['model'].downcase}%>".red
  puts "Allow lat and lng params in your controller #{hash['controller_file']}:".red
  puts "params.require(:#{hash['model'].downcase}).permit(:lat, :lng)".red
 
  
end
