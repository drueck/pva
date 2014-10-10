# pva

A command line utility to check schedules, scores and standings for
[Portland Volleyball Association](http://portlandvolleyball.org) teams

## Installation and Usage

Requires `ruby` and the `httparty` and `chronic` gems. Once those are
installed, put the `pva` file somewhere in your path and make sure it's
executable.

Then just run `pva` to display the help and see what commands are available.

## About

This is mostly just something I'm playing around with. At this point it can
list all of the current teams, and display schedules and standings for a
given team or for all of the teams in your "teams cache".

The UX is not the greatest, and it does not yet have the ability to show
scores or manage your list of teams via the cli. It's also dependent on the
current structure of the[PVA website](http://portlandvolleyball.org) as it
is implemented via screen scraping.

## Development Roadmap

- Add scores subcommand
- Add ability to manage your teams list with the cli
- Separate classes into their own files
- Add tests
- Make it into a gem so it can be easily installed
- Eventually convert the project to Go to eliminate the ruby dependencies and
  allow for cross compilation on multiple platforms (and for fun)
