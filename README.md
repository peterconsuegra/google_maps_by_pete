# Ruby On Rails Google Maps By Pete

An agile way to implement Google Maps geolocation in a Ruby On Rails scaffold
## Support

Ruby On Rails: 5, 6, 7

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'google_maps_by_pete'

```

Go to your application's directory in Terminal and run the command:
```ruby
bundle install
```


## Usage
Let's create a example for a Place scaffold:

1. Let's create a new rails app:

```ruby
rails new myapp
```

2. Create the database:

```ruby
bundle exec rake db:create
```

3. Go to your application's directory in Terminal and run the command:

```ruby
bundle exec rails g scaffold Place name:string description:text
```

4. Add this line to your application's Gemfile:

```ruby
gem 'google_maps_by_pete'
```

5. Go to your application's directory in Terminal and run:

```ruby
bundle install
```

6. Go to the application directory in Terminal and run the following command to install the necessary files from the gem:
```ruby
bundle exec rake 'install_google_maps_by_pete[Place]'
```
7. Add jQuery to your layout file: /app/views/layouts/application.html.erb
```html
<script src='/google_maps_by_pete/jquery-3.6.0.min.js'></script>
```
8. Add maps.css to your layout file: /app/views/layouts/application.html.erb
```html
<link rel='stylesheet' href='/google_maps_by_pete/maps.css'>
```
9. Paste this partial to your _form.html.erb file: /app/views/places/_form.html.erb

```ruby
<%= render 'shared/google_maps_by_pete', api_key: 'your_google_api_key',  height: '500px', center_map_on: {lat: 25.761681, lng: -80.191788}, model: place%>
```

10. Allow parameters (lat and lng) in your controller: /app/controllers/places_controller.rb

```ruby
def place_params
   params.require(:place).permit(:name, :description, :lat, :lng)
end
```

## Video Tutorial

Watch this video to see how it works

[![IMAGE ALT TEXT HERE](https://raw.githubusercontent.com/peterconsuegra/google_maps_by_pete/master/templates/MapsByPete.png)](https://www.youtube.com/watch?v=YCp1Yv2A4Dc)



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/peterconsuegra/google_maps_by_pete. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/peterconsuegra/google_maps_by_pete/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the GoogleMapsByPete project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/peterconsuegra/google_maps_by_pete/blob/master/CODE_OF_CONDUCT.md).
