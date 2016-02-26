[![Build Status](https://travis-ci.org/creaktive/rainbarf.png?branch=master)](https://travis-ci.org/creaktive/rainbarf "Build Status")

# NAME

rainbarf - CPU/RAM/battery stats chart bar for tmux (and GNU screen)

# VERSION

version 1.3

# SYNOPSIS

    rainbarf --tmux --width 40 --no-battery

# DESCRIPTION

Fancy resource usage charts to put into the [tmux](http://tmux.sourceforge.net/) status line.
The CPU utilization history chart is tinted with the following colors to reflect the system memory allocation:

- **green**: free memory;
- **yellow**: active memory;
- **blue**: inactive memory;
- **red**: wired memory on _Mac OS X_ / _FreeBSD_; "unaccounted" memory on _Linux_;
- **cyan**: cached memory on _Linux_, buf on _FreeBSD_.
- **magenta**: used swap memory.

If available, battery charge is displayed on the right.

# SCREENSHOTS

## iTerm2 with [tmux-powerline](https://github.com/erikw/tmux-powerline), Solarized theme and Terminus font

    rainbarf --battery --remaining --rgb

![Mac OS X screenshot](http://i.imgur.com/mxtz72V.png?1)

## OSX Terminal with [Tomorrow Night](https://github.com/chriskempson/tomorrow-theme#tomorrow-night) theme and Menlo font

    rainbarf --battery --remaining --no-bright

![Mac OS X screenshot, v2](http://i.imgur.com/g4wNnRj.png?1)

## Ubuntu Terminal with default theme and Monospace font

    rainbarf --battery --bolt --bright

![Ubuntu screenshot](http://i.imgur.com/kgIdeRa.png?1)

# USAGE

## Installation

- Traditional way:

        perl Build.PL
        ./Build test
        ./Build install

- [Homebrew](http://brew.sh/) way:

        brew install rainbarf

- [MacPorts](http://www.macports.org/) way:

        port install rainbarf

- CPAN way:

        cpan -i App::rainbarf

- Modern Perl way:

        cpanm git://github.com/creaktive/rainbarf.git

## Configuration

Add the following line to your `~/.tmux.conf` file:

    set-option -g status-utf8 on
    set -g status-right '#(rainbarf)'

Or, under _GNOME Terminal_:

    set-option -g status-utf8 on
    set -g status-right '#(rainbarf --rgb)'

Reload the tmux config by running `tmux source-file ~/.tmux.conf`.

# CONFIGURATION FILE

`~/.rainbarf.conf` can be used to persistently store ["OPTIONS"](#options):

    # example configuration file
    width=20   # widget width
    bolt       # fancy charging character
    remaining  # display remaining battery
    rgb        # 256-colored palette

["OPTIONS"](#options) specified via command line override that values.
Configuration file can be specified via `RAINBARF` environment variable:

    RAINBARF=~/.rainbarf.conf rainbarf

# OPTIONS

- `--help`

    This.

- `--[no]battery`

    Display the battery charge indicator.
    Enabled by default.

- `--[no]remaining`

    Display the time remaining until the battery is fully charged/empty. See ["CAVEAT"](#caveat).
    Disabled by default.

- `--[no]bolt`

    Display even fancier battery indicator `⚡`.
    Disabled by default.

- `--[no]bright`

    Tricky one. Disabled by default. See ["CAVEAT"](#caveat).

- `--[no]rgb`

    Use the **RGB** palette instead of the system colors.
    Also disabled by default, for the same reasons as above.

- `--fg COLOR_NAME`

    Force chart foreground color.

- `--bg COLOR_NAME`

    Force chart background color.

- `--[no]loadavg`

    Use [load average](https://en.wikipedia.org/wiki/Load_\(computing\)) metric instead of CPU utilization.
    You might want to set the `--max` threshold since this is an absolute value and has varying ranges on different systems.
    Disabled by default.

- `--[no]swap`

    Display the swap usage.
    Used swap amount is added to the total amount, but the free swap amount is not!
    Disabled by default.

- `--max NUMBER`

    Maximum `loadavg` you expect before rescaling the chart. Default is 1.

- `--order INDEXES`

    Specify the memory usage bar order.
    The default is `fwaic` (free, wired, active, inactive & cached).

- `--[no]tmux`

    Force `tmux` colors mode.
    By default, [rainbarf](https://metacpan.org/pod/rainbarf) detects automatically if it is being called from `tmux` or from the interactive shell.

- `--screen`

    [screen(1)](http://manpages.ubuntu.com/manpages/hardy/man1/screen.1.html) colors mode. **Experimental**. See ["CAVEAT"](#caveat).

- `--width NUMBER`

    Chart width. Default is 38, so both the chart and the battery indicator fit the `tmux` status line.
    Higher values may require disabling the battery indicator or raising the `status-right-length` value in `~/.tmux.conf`.

- `--datfile FILENAME`

    Specify the file to log CPU stats to.
    Default: `$HOME/.rainbarf.dat`

- `--skip NUMBER`

    Do not write CPU stats if file already exists and is newer than this many seconds.
    Useful if you refresh `tmux` status quite frequently.

# CAVEAT

## Time remaining

If the `--remaining` option is present but you do not see the time in your status bar, you may need to increase the value of `status-right-length` to 48.

## Color scheme

If you only see the memory usage bars but no CPU utilization chart, that's because your terminal's color scheme need an explicit distinction between foreground and background colors.
For instance, "red on red background" will be displayed as a red block on such terminals.
Thus, you may need the ANSI **bright** attribute for greater contrast, or maybe consider switching to the 256-color palette.
There are some issues with that, though:

1. Other color schemes (notably, [solarized](http://ethanschoonover.com/solarized)) have different meaning for the ANSI **bright** attribute.
So using it will result in a quite psychedelic appearance.
256-color pallette, activated by the `--rgb` flag, is unaffected by that.
2. The older versions of [Term::ANSIColor](https://metacpan.org/pod/Term::ANSIColor) dependency do not recognize bright/RGB settings, falling back to the default behavior (plain 16 colors).
However, the whole [Term::ANSIColor](https://metacpan.org/pod/Term::ANSIColor) is optional, it is only required to preview the effects of the ["OPTIONS"](#options) via command line before actually editing the `~/.tmux.conf`.
That is, `rainbarf --bright --tmux` **is guaranteed to work** despite the outdated [Term::ANSIColor](https://metacpan.org/pod/Term::ANSIColor)!

Another option is skipping the system colors altogether and use the **RGB** palette (`rainbarf --rgb`).
This fixes the _issue 1_, but doesn't affect the _issue 2_.
It still looks better, though.

## Persistent storage

CPU utilization stats are persistently stored in the `~/.rainbarf.dat` file.
Every [rainbarf](https://metacpan.org/pod/rainbarf) execution will update and rotate that file.
Since `tmux` calls [rainbarf](https://metacpan.org/pod/rainbarf) periodically (every 15 seconds, by default), the chart will display CPU utilization for the last ~9.5 minutes (15 \* 38).
Thus, several `tmux` instances running simultaneously for the same user will result in a faster chart scrolling.

## screen

Stable `screen` version unfortunately has a broken UTF-8 handling specifically for the status bar.
Thus, I have only tested the [rainbarf](https://metacpan.org/pod/rainbarf) with the variant from [git://git.savannah.gnu.org/screen.git](git://git.savannah.gnu.org/screen.git).
My `~/.screenrc` contents:

    backtick 1 15 15 rainbarf --bright --screen
    hardstatus string "%1`"
    hardstatus lastline

# REFERENCES

- [top(1)](http://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/top.1.html) is used to get the CPU/RAM stats if no `/proc` filesystem is available.
- [ioreg(8)](http://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man8/ioreg.8.html) is used to get the battery status on _Mac OS X_.
- [ACPI](http://www.tldp.org/howto/acpi-howto/usingacpi.html) is used to get the battery status on _Linux_.
- [Battery](https://github.com/Goles/Battery) was a source of inspiration.
- [Spark](http://zachholman.com/spark/) was another source of inspiration.

# AUTHOR

Stanislaw Pusep <stas@sysd.org>

# CONTRIBUTORS

- [Chris Knadler](https://github.com/cknadler)
- [cinaeco](https://github.com/cinaeco)
- [Clemens Hammacher](https://github.com/hammacher)
- [H.Merijn Brand](https://github.com/Tux)
- [Henrik Hodne](https://github.com/henrikhodne)
- [Joe Hassick](https://github.com/jh3)
- [Josh Matthews](https://github.com/jmatth)
- [Sergey Romanov](https://github.com/sergeyromanov)
- [Tom Cammann](https://github.com/takac)
- [Tuomas Jormola](https://github.com/tjormola)

# COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by Stanislaw Pusep <stas@sysd.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
