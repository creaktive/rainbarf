
BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
}

# this test was generated with Dist::Zilla::Plugin::Test::Kwalitee 2.07
use strict;
use warnings;
use Test::Kwalitee;
