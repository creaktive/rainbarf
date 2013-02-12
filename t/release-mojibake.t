#!perl

BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
}


use strict;
use warnings qw(all);

use Test::More;

## no critic (ProhibitStringyEval, RequireCheckingReturnValueOfEval)
eval q(use Test::Mojibake);
plan skip_all => q(Test::Mojibake required for source encoding testing) if $@;

all_files_encoding_ok();
