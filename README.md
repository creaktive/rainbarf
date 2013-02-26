# NAME

rainbarf - CPU/RAM/battery stats chart bar for tmux (and GNU screen)

# VERSION

version 0.6

# SYNOPSIS

    rainbarf --tmux --width 40 --no-battery

# DESCRIPTION

Fancy resource usage charts to put into the [tmux](http://tmux.sourceforge.net/) status line.
The CPU utilization history chart is tinted with the following colors to reflect the system memory allocation:

- __green__: free memory;
- __yellow__: active memory;
- __blue__: inactive memory;
- __red__: wired memory on _Mac OS X_;
- __cyan__: cached memory on _Linux_.

If available, battery charge is displayed on the right.

# SCREENSHOTS

## iTerm2 with solarized theme and ProFont

    rainbarf --battery --no-bright

![Mac OS X screenshot](http://i.imgur.com/KetTk5o.png?1)

## OSX Terminal with [Tomorrow Night](https://github.com/chriskempson/tomorrow-theme#tomorrow-night) theme and Menlo font

    rainbarf --battery --remaining --no-bright

![Mac OS X screenshot, v2](http://i.imgur.com/g4wNnRj.png?1)

## Ubuntu Terminal with default theme and Monospace font

    rainbarf --battery --bolt --bright

![Ubuntu screenshot](http://i.imgur.com/kgIdeRa.png?1)

# USAGE

## Installation

    perl Build.PL
    ./Build test
    ./Build install

## Configuration

Add the following line to your `~/.tmux.conf` file:

    set -g status-right '#(rainbarf)'

Or, under _GNOME Terminal_:

    set -g status-right '#(rainbarf --bright)'

Reload the tmux config by running `tmux source-file ~/.tmux.conf`.

# CONFIGURATION FILE

`~/.rainbarf.conf` can be used to persistently store ["OPTIONS"](#OPTIONS):

    # example configuration file
    width=20   # widget width
    bolt       # fancy charging character
    remaining  # display remaining battery
    rgb        # 256-colored palette

["OPTIONS"](#OPTIONS) specified via command line override that values.

# OPTIONS

- \--help

    This.

- \--\[no\]battery

    Display the battery charge indicator.

- \--\[no\]remaining

    Display the time remaining until the battery is fully charged/empty. See ["CAVEAT"](#CAVEAT).

- \--\[no\]bolt

    Display even fancier battery indicator `⚡`.

- \--\[no\]bright

    Tricky one. Disabled by default. See ["CAVEAT"](#CAVEAT).

- \--\[no\]rgb

    Use the __RGB__ palette instead of the system colors.
    Also disabled by default, for the same reasons as above.

- \--fg COLOR\_NAME

    Force chart foreground color.

- \--bg COLOR\_NAME

    Force chart background color.

- \--\[no\]loadavg

    Use [load average](https://en.wikipedia.org/wiki/Load\_(computing)) metric instead of CPU utilization.
    You might want to set the `--max` threshold since this is an absolute value and has varying ranges on different systems.

- \--max NUMBER

    Maximum `loadavg` you expect before rescaling the chart. Default is 1.

- \--order INDEXES

    Specify the memory usage bar order.
    The default is `fwaic` ( __f__ree, __w__ired, __a__ctive, __i__nactive & __c__ached ).

- \--\[no\]tmux

    Force `tmux` colors mode.
    By default, [rainbarf](http://search.cpan.org/perldoc?rainbarf) detects automatically if it is being called from `tmux` or from the interactive shell.

- \--screen

    [screen(1)](http://manpages.ubuntu.com/manpages/hardy/man1/screen.1.html) colors mode. __Experimental__. See ["CAVEAT"](#CAVEAT).

- \--width NUMBER

    Chart width. Default is 38, so both the chart and the battery indicator fit the `tmux` status line.
    Higher values may require disabling the battery indicator or raising the `status-right-length` value in `~/.tmux.conf`.

# CAVEAT

## Time remaining

If the `--remaining` option is present but you do not see the time in your status bar, you may need to increase the value of `status-right-length` to 48.

## Color scheme

If you only see the memory usage bars but no CPU utilization chart, that's because your terminal's color scheme need an explicit distinction between foreground and background colors.
For instance, "red on red background" will be displayed as a red block on such terminals.
Thus, you may need the ANSI __bright__ attribute for greater contrast.
There are two issues with it, though:

1. Other color schemes (notably, [solarized](http://ethanschoonover.com/solarized)) have different meaning for the ANSI __bright__ attribute.
So using it will result in a quite psychedelic appearance.
2. The older versions of [Term::ANSIColor](http://search.cpan.org/perldoc?Term::ANSIColor) dependency do not recognize it at all, resulting in a confusing error message _Invalid attribute name bright\_yellow at ..._.
However, the whole [Term::ANSIColor](http://search.cpan.org/perldoc?Term::ANSIColor) is optional, it is only required to preview the effects of the ["OPTIONS"](#OPTIONS) via command line before actually editing the `~/.tmux.conf`.
That is, `rainbarf --bright --tmux` __is guaranteed to work__ despite the outdated [Term::ANSIColor](http://search.cpan.org/perldoc?Term::ANSIColor)!

Another option is skipping the system colors altogether and use the __RGB__ palette (`rainbarf --rgb`).
This fixes the _issue 1_, but doesn't affect the _issue 2_.
It still looks better, though.

## Persistent storage

CPU utilization stats are persistently stored in the `~/.rainbarf.dat` file.
Every [rainbarf](http://search.cpan.org/perldoc?rainbarf) execution will update and rotate that file.
Since `tmux` calls [rainbarf](http://search.cpan.org/perldoc?rainbarf) periodically (every 15 seconds, by default), the chart will display CPU utilization for the last ~9.5 minutes (15 \* 38).
Thus, several `tmux` instances running simultaneously for the same user will result in a faster chart scrolling.

## screen

Stable `screen` version unfortunately has a broken UTF-8 handling specifically for the status bar.
Thus, I have only tested the [rainbarf](http://search.cpan.org/perldoc?rainbarf) with the variant from [git://git.savannah.gnu.org/screen.git](git://git.savannah.gnu.org/screen.git).
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

- [Clemens Hammacher](https://github.com/hammacher)
- [Joe Hassick](https://github.com/jh3)
- [Tuomas Jormola](https://github.com/tjormola)

# COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Stanislaw Pusep <stas@sysd.org>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
