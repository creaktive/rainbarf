#!perl

BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
}


use Test::More;

eval "use Test::Vars";
plan skip_all => "Test::Vars required for testing unused vars"
  if $@;
all_vars_ok();
