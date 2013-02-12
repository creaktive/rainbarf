#!perl

use strict;
use warnings;
use Test::More;

like(qx{$^X -c rainbarf 2>&1}, qr{rainbarf syntax OK}ms, q{compiles});
done_testing 1;
