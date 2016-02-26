#!/usr/bin/perl
use strict;
use warnings;
use Module::Build;

my $build = Module::Build->new(
    module_name         => 'App::rainbarf',
    dist_abstract       => 'CPU/RAM/battery stats chart bar for tmux (and GNU screen)',
    dist_version_from   => 'rainbarf',
    script_files        => ['rainbarf'],

    license             => 'perl',
    create_license      => 1,
    create_readme       => 1,
    sign                => 1,

    meta_add            => {
        resources       => {
            bugtracker  => 'https://github.com/creaktive/rainbarf/issues',
            homepage    => 'https://github.com/creaktive/rainbarf',
            repository  => 'git://github.com/creaktive/rainbarf.git',
        },
        x_contributors  => [
            'Chris Knadler <takeshi91k@gmail.com>',
            'cinaeco',
            'Clemens Hammacher <hammacher@cs.uni-saarland.de>',
            'H.Merijn Brand <h.m.brand@xs4all.nl>',
            'Henrik Hodne <henrik@hodne.io>',
            'Joe Hassick <joe.hassick@gmail.com>',
            'Josh Matthews <josh@jmatthews.us>',
            'Sergey Romanov <complefor@rambler.ru>',
            'Tom Cammann <tom.cammann@vmci.net>',
            'Tuomas Jormola <tj@solitudo.net>',
        ],
    },

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
        'perl'          => '5.008',
    },

    dynamic_config      => 0,
);
$build->create_build_script;
