require_relative '../peterconsuegra_recipes'
require 'fileutils'
require "tty-file"

#bundle exec rake 'install_google_maps_by_pete[place]'

desc 'install_google_maps_by_pete required files'
task :install_google_maps_by_pete, [:model] do |t, args|
  
  #route files
  rails_app_folder = Dir.pwd 
  gem_folder = File.expand_path('../../../.', __FILE__)
  
  #model vars
  model_name = args[:model].capitalize
  model_plural = model_name+"s"
  model_plural = model_plural.capitalize
  model_plural_downcase = model_plural.downcase
  
  puts "model: #{model_name}"
  puts "model_plural: #{model_plural}"
  puts "model_plural_downcase: #{model_plural_downcase}"
  
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
  file="google_maps_by_pete.rb"
  FileUtils.mkdir_p dest_folder
  FileUtils.cp src_folder+file,dest_folder+file
  puts "File copied to: #{dest_folder+file}".green
  
  #Copy maps.css file
  dest_folder="#{rails_app_folder}/public/googlemaps/"
  file="maps.css"
  FileUtils.mkdir_p dest_folder
  FileUtils.cp src_folder+file,dest_folder+file
  puts "File copied to: #{dest_folder+file}".green
   
  #Adding route to routes.rb
  file="#{rails_app_folder}/config/routes.rb"
  code = "post '/#{model_plural_downcase}/set_location', to: '#{model_plural_downcase}#set_location'"
  PeterConsuegraRecipes::append_before_last_appearance_of("end",code,file)
  puts "Adding route: #{code}".blue
  
  #Adding include GoogleMapsByPete in Controller
  file="#{rails_app_folder}/app/controllers/#{model_plural_downcase}_controller.rb"
  code="include GoogleMapsByPete\n"
  TTY::File.inject_into_file file, code, after: "class #{model_plural}Controller < ApplicationController\n"
  puts "Adding concern to controller #{file}: include GoogleMapsByPete".blue
  
  puts "Add this to your _form.html.erb file:".red
  puts "<%= render 'shared/google_maps_by_pete', api_key: 'your_google_api_key',  height: '500px', center_map_on: {lat: 25.761681, lng: -80.191788}, model: #{model_name}%>".red
  puts "Add jQuery CDN to your layout file:".red
  puts "<script src='https://code.jquery.com/jquery-3.6.0.min.js' integrity='sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=' crossorigin='anonymous'></script>".red
  puts "Add maps.css to your layout file:".red
  puts "<link rel='stylesheet' href='/googlemaps/maps.css'>".red
  
  #Add required migration
  `rails generate migration AddFieldsTo#{model_name} lat:decimal{10-6} lng:decimal{10-6}`
  sleep 2
  `rake db:migrate`
  
end
