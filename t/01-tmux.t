#!perl
use strict;
use open IO => ':locale';
use warnings qw(all);

use File::Temp;
use Test::More;

plan skip_all => qq(The platform $^O is unsupported)
    if $^O !~ m{(?:darwin|freebsd|linux)}ix;

my $tmp = File::Temp->newdir;

local $ENV{RAINBARF} = q(/dev/null);
my $file = $tmp->dirname . '/rainbarf.dat';

my $n = 10;

my $color_set = qr{
    \#\[
        fg=(\w+)
        (?:,bg=\1)?
    \]
}x;
my $color_reset = qr{
    \#\[
        (?:[bf]g=default,?) {2}
    \]
}x;
my $chart = qr{
    [\x{2581}-\x{2588}]*
}x;

for my $i (1 .. $n) {
    ok(
        open(
            my $out,
            q(-|:encoding(utf8)),
            $^X => qw[
                rainbarf
                    --nobattery
                    --swap
                    --tmux
                    --datfile
            ], $file),
        qq(pipe $i),
    );
    chomp(my $line = <$out>);
    close $out;
    like(
        $line,
        qr{
            ^
            (?:
                $color_set
                $chart
            ) {2,}
            $color_reset
            $
        }msx,
        qq(pattern $i),
    );

    sleep 1;
}

done_testing 2 * $n;
