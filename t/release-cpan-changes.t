#!perl

BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
}


use strict;
use warnings;

use Test::More 0.96 tests => 2;
use_ok('Test::CPAN::Changes');
subtest 'changes_ok' => sub {
    changes_file_ok('Changes');
};
done_testing();
