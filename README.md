# pva

A command line utility to check
[Portland Volleyball Association](http://portlandvolleyball.org) schedules

## Installation and Usage

Requires `ruby` and the `httparty` and `chronic` gems. Once those are
installed, put the `pva` file somewhere in your path and make sure it's
executable.

Then just run `pva` to display the help and see what commands are available.

## About

This is mostly just something I'm playing around with. Currently it can list
all the teams for the current season and list the posted schedules for a given
team or for all of "your" teams. The UX is not the greatest, and it does not
yet have the ability to show scores and standings or manage your list of teams
via the cli. It's also dependent on the current structure of the
[PVA website](http://portlandvolleyball.org) as it is implemented via screen
scraping.

## Development Roadmap

- Add standings subcommand
- Add scores subcommand
- Add ability to manage your teams list with the cli
- Separate classes into their own files
- Add tests
- Make it into a gem so it can be easily installed
- Eventually convert the project to Go to eliminate the ruby dependencies and
  allow for cross compilation on multiple platforms (and for fun)
