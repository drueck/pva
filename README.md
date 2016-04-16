# pva

A Command Line Interface for the
[Portland Volleyball Association](http://portlandvolleyball.org)

## Installation and Usage

At this point the project is set up to be built and installed as a ruby gem,
but I have not pushed it up to rubygems. So, for the time being, this is how
you would build the latest version of the gem and get it installed on your
system. Note: The code requires Ruby 2.1+ and possibly build tools and
libraries to build the native extensions for nokogiri, one of the dependencies.

1. `git clone https://github.com/drueck/pva.git`
2. `cd pva`
3. `gem build pva.gemspec`
4. `[sudo] gem install pva-<version>.gem`

Then just run `pva` to display the help and see what commands are available.

See it in action:

[![asciicast](https://asciinema.org/a/13412.png)](https://asciinema.org/a/13412)

## About

At this point the cli can list the current teams, display schedules, standings,
and match results (scores) for a given team or for all of the teams in your
"teams cache". The teams cache is just a text file stored at ~/.pva that lists
info about each of the teams for which you have requested information. There is
currently no interface to manage this list with the cli, but you can manually
edit that file to remove teams you are no longer interested in or whose ids are
out of date.

Note that the code is dependent on the current structure of the [PVA
website](http://portlandvolleyball.org) as it is implemented via screen
scraping. If the website changed significantly it could easily break, but I
will attempt to keep it up-to-date.

## Development Roadmap

- Add the ability to manage your teams list with the cli.
- Eventually convert the project to Go to eliminate the ruby dependencies and
  allow for cross compilation on multiple platforms (and for fun).
