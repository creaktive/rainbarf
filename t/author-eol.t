#!perl

BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for testing by the author');
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::EOL 0.17

use Test::More 0.88;
use Test::EOL;

my @files = qw(
    rainbarf
    lib/App/rainbarf.pm
    t/00-compile.t
    t/01-tmux.t
    t/author-critic.t
    t/author-eol.t
    t/author-no-tabs.t
    t/release-consistent-version.t
    t/release-cpan-changes.t
    t/release-dist-manifest.t
    t/release-distmeta.t
    t/release-kwalitee.t
    t/release-minimum-version.t
    t/release-mojibake.t
    t/release-pod-coverage.t
    t/release-pod-linkcheck.t
    t/release-pod-syntax.t
    t/release-portability.t
    t/release-test-version.t
    t/release-unused-vars.t
);

eol_unix_ok($_, { trailing_whitespace => 1 }) foreach @files;
done_testing;
