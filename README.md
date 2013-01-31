# NAME

rainbarf - CPU/RAM stats for TUI

# VERSION

version 0.1

# SYNOPSIS

    rainbarf --tmux --width 40 --no-battery

# DESCRIPTION

Fancy resource usage charts to put into the [tmux](http://tmux.sourceforge.net/) status line.
The load history chart is tinted with the following colors to reflect the system memory allocation:

- __green__: free memory;
- __red__: wired memory on _Mac OS X_, cached memory on _Linux_;
- __yellow__: active memory;
- __blue__: inactive memory.

If available, battery charge is displayed on the right.

# SCREENSHOTS

## iTerm2 with solarized theme and ProFont:

![Mac OS X screenshot](http://i.imgur.com/XhtmoTY.png?1)

## Ubuntu Terminal with default settings:

![Ubuntu screenshot](http://i.imgur.com/jOZtOdl.png)

# USAGE

Put `rainbarf` into your `$PATH`.
Add the following line to your `~/.tmux.conf` file:

    set -g status-right '#(rainbarf)'

Or, under _GNOME Terminal_:

    set -g status-right '#(rainbarf --bright)'

Reload the tmux config by running `tmux source-file ~/.tmux.conf`.

# OPTIONS

- \--help

    This.

- \--\[no\]battery

    Display the battery charge indicator.

- \--\[no\]bolt

    Display even fancier battery indicator C<⚡>.

- \--\[no\]bright

    Tricky one. Disabled by default. See ["CAVEAT"](#CAVEAT).

- \--max

    Maximum load you expect before rescaling the chart (default: 1).

- \--\[no\]tmux

    Force `tmux` colors mode.
    By default, `rainbarf` detects automatically if it is being called from `tmux` or from the interactive shell.

- \--width

    Chart width. Default is 38, so both the chart and the battery indicator fit the `tmux` status line.
    Higher values may require disabling the battery indicator or raising the `status-right-length` value in `~/.tmux.conf`.

# CAVEAT

## Color scheme

If you only see the memory usage bars but no load chart, that's because your terminal's color scheme need an explicit distinction between foreground and background colors.
For instance, "red on red background" will be displayed as a red block on such terminals.
Thus, you may need the ANSI __bright__ attribute for greater contrast.
There are two problems with it, though:

1. Other color schemes (notably, [solarized](http://ethanschoonover.com/solarized)) have different meaning for the ANSI __bright__ attribute.
So using it will result in a quite psychedelic appearance.
2. The older versions of [Term::ANSIColor](http://search.cpan.org/perldoc?Term::ANSIColor) dependency do not recognize it at all, resulting in a confusing error message _Invalid attribute name bright\_yellow at ..._.
However, the whole [Term::ANSIColor](http://search.cpan.org/perldoc?Term::ANSIColor) is optional, it is only required to preview the effects of the ["OPTIONS"](#OPTIONS) via command line before actually editing the `~/.tmux.conf`.
That is, `rainbarf --bright --tmux` __is guaranteed to work__ despite the outdated [Term::ANSIColor](http://search.cpan.org/perldoc?Term::ANSIColor)!

## Persistent storage

Load stats are persistently stored in the `~/.rainbarf.dat` file.
Every `rainbarf` execution will update and rotate that file.
Since `tmux` calls `rainbarf` periodically (every 15 seconds, by default), the chart will display load for the last ~9.5 minutes (15 \* 38).
Thus, several `tmux` instances running simultaneously for the same user will result in a faster chart scrolling.

# REFERENCES

- [uptime(1)](http://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/uptime.1.html) is used to get the load stats if `/proc/loadavg` is unavailable.
- [vm\_stat(1)](http://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man1/vm\_stat.1.html) is used to get the memory stats if `/proc/meminfo` is unavailable.
- [ioreg(8)](http://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man8/ioreg.8.html) is used to get the battery status on _Mac OS X_.
- [acpi(1)](http://manpages.ubuntu.com/manpages/precise/man1/acpi.1.html) is used to get the battery status on _Linux_.
- [Battery](https://github.com/Goles/Battery) was a source of inspiration.
- [Spark](http://zachholman.com/spark/) was another source of inspiration.

# AUTHOR

Stanislaw Pusep <stas@sysd.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Stanislaw Pusep.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
