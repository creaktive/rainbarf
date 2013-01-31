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

Load stats are persistently stored in the `~/.rainbarf.dat` file.
Every `rainbarf` execution will update and rotate that file.
Since `tmux` calls `rainbarf` periodically (every 15 seconds, by default), the chart will display load for the last ~9.5 minutes (15 \* 38).
Thus, several `tmux` instances running simultaneously for the same user will result in a faster chart scrolling.

# SEE ALSO

- [Battery](https://github.com/Goles/Battery)
- [Spark](http://zachholman.com/spark/)

# AUTHOR

Stanislaw Pusep <stas@sysd.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Stanislaw Pusep.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
