# NAME

rainbarf - CPU/RAM stats for TUI

# VERSION

version 0.1

# SYNOPSIS

    rainbarf --tmux --width 20 --no-battery

# DESCRIPTION

Fancy load graphs to put into [tmux](http://tmux.sourceforge.net/) status line.
The load history graph is tinted with the following colors to reflect the memory allocation:

- __green__: free memory;
- __red__: wired memory on _Mac OS X_, cached memory on _Linux_;
- __yellow__: active memory;
- __blue__: inactive memory.

If available, battery charge is displayed on the right.

Just go to [https://github.com/creaktive/rainbarf](https://github.com/creaktive/rainbarf) to see some screenshots.

# USAGE

Put `rainbarf` into your `$PATH`.
Add the following lines to your `~/.tmux.conf` file:

    set -g status-right '#(rainbarf --tmux)'
    set -g status-interval 30

Reload the tmux config by running `tmux source-file ~/.tmux.conf`.

# SEE ALSO

- [Battery](https://github.com/Goles/Battery)
- [Spark](http://zachholman.com/spark/)

# AUTHOR

Stanislaw Pusep <stas@sysd.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Stanislaw Pusep.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
