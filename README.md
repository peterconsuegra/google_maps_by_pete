# GoogleMapsByPete

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/google_maps_by_pete`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'google_maps_by_pete'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install google_maps_by_pete

## Usage

1. rails g scaffold Place name:string description:text
2. gem "google_maps_by_pete", path: "/Users/pedroconsuegra/Sites/ruby/google_maps_by_pete"
3. bundle exec rake 'install_google_maps_by_pete[place]
4. <%= render 'shared/google_maps_by_pete', api_key: 'your_google_api_key',  height: '500px', center_map_on: {lat: 25.761681, lng: -80.191788}, model: @model%>
5. Go to places edit

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/google_maps_by_pete. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/google_maps_by_pete/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the GoogleMapsByPete project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/google_maps_by_pete/blob/master/CODE_OF_CONDUCT.md).
