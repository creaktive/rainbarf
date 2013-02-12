#!/usr/bin/perl

=head1 NAME

Build.PL - Build script generator for App::rainbarf

=head1 SYNOPSIS

 perl Build.PL
 ./Build test
 ./Build install

=cut

use 5.008;
use strict;
use warnings;
use Module::Build;

my $build = Module::Build->new(
    module_name         => 'App::rainbarf',
    dist_abstract       => 'CPU/RAM/battery stats chart bar for tmux (and GNU screen)',
    script_files        => ['rainbarf'],

    license             => 'perl',
    create_license      => 1,

    build_requires      => {
        'English'       => '1.00',
        'Test::More'    => '0.45',
    },
    configure_requires  => { 'Module::Build' => '0.28' },
    requires            => {
        'Getopt::Long'  => '2.32',
        'List::Util'    => '1.07_00',
        'Pod::Usage'    => '1.14',
        'Storable'      => '2.04',
        'Term::ANSIColor' => '1.04',
    },
);
$build->create_build_script;

__END__

=head1 AUTHOR

Stanislaw Pusep <stas@sysd.org>

=cut
