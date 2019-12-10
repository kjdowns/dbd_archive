
# Dead by Daylight Archive

Dead by Daylight Archive is a Ruby CLI which scrapes the Dead by Daylight wiki to display various bits of information about the game to the user. 
Some options include Characters, Items, Realms, etc.

The Dead by Daylight wiki page can be found here : "https://deadbydaylight.gamepedia.com/Dead_by_Daylight_Wiki"

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dbd_archive'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dbd_archive

## Usage

Upon launching the application, users will be presented with a welcome splash screen. Pressing enter will direct the user to the main menu and allow them to choose from menu list items to learn more about their selection. At any point the user is prompted for input, they may enter a menu name in place of a list item number to be automatically directed to that menu. Entering 'exit' at any point will terminate the program for the user. 

Below is a list of commands that may be used outside of number selection of menu items:

"help - help menu"
"main - main menu"
"killers - killers menu"
"survivors - survivors menu"
"realms - realms menu"
"items - items menu"
"about - about game"
"back - returns to current menu"
"exit - exits the program"

Points where the program states to press enter to continue are dummy input prompts and will return the program to the main menu regardless of input recieved. The purpose of this is to allow users time to read long menus, lore descriptions, or other long text outputs. If a menu redirect is desired, the user may enter that input upon return to the main menu.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/'kdowns'/dbd_archive. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DbdArchive project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/'kdowns'/dbd_archive/blob/master/CODE_OF_CONDUCT.md).
