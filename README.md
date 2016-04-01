# pva

A Command Line Interface for the
[Portland Volleyball Association](http://portlandvolleyball.org)

## Installation and Usage

At this point the project is set up to be built and installed as a ruby gem,
but I have not pushed it up to rubygems. So, for the time being, this is how
you would build the latest version of the gem and get it installed on your
system.

1. `git clone https://github.com/drueck/pva.git`
2. `cd pva`
2. `gem build pva.gemspec`
3. `gem install pva-<version>.gem`

Then just run `pva` to display the help and see what commands are available.

See it in action:

[![asciicast](https://asciinema.org/a/13412.png)](https://asciinema.org/a/13412)

## About

This is mostly just something I'm playing around with. At this point it can
list the current teams and display schedules and standings for a
given team or for all of the teams in your "teams cache".

The UX is not the greatest, and it does not yet have the ability to show
scores or manage your list of teams via the cli. It's also dependent on the
current structure of the [PVA website](http://portlandvolleyball.org) as it
is implemented via screen scraping.

## Development Roadmap

- Add scores subcommand
- Add ability to manage your teams list with the cli
- Eventually convert the project to Go to eliminate the ruby dependencies and
  allow for cross compilation on multiple platforms (and for fun)
