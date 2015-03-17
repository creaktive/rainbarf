
BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
}

# this test was generated with Dist::Zilla::Plugin::Test::Kwalitee 2.11
use strict;
use warnings;
use Test::More 0.88;
use Test::Kwalitee 1.21 'kwalitee_ok';

kwalitee_ok();

done_testing;
