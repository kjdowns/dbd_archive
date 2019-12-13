
# Dead by Daylight Archive

Dead by Daylight Archive is a Ruby CLI which scrapes the Dead by Daylight wiki to display various bits of information about the game to the user. 
Some options include Characters, Items, Realms, etc.

The Dead by Daylight wiki page can be found here : "https://deadbydaylight.gamepedia.com/Dead_by_Daylight_Wiki"

## Installation

Fork and clone the dbd-archive repo. If bundler is installed, you can simply run `bundle` before running the program in order to install all dependencies and gems.

If bundle is not installed, simply use `gem install bundler` and then `bundle` to ensure all necessary gems and dependencies are installed.

To start the program, use `./bin/dbd-archive`. It may take a few moments for everything to start, this is normal as all necessary data is scraped from the Wiki website before the program starts to allow a smoother and more dynamic user experience. 

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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/'kdowns'/dbd_archive. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the DbdArchive project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/'kdowns'/dbd_archive/blob/master/CODE_OF_CONDUCT.md).
