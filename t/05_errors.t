#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
use Data::Validate::WithYAML::Plugin::Phone;

my $module = 'Data::Validate::WithYAML::Plugin::Phone';

my $error;
eval {
    $module->check(undef);
} or $error = $@;

like $error, qr/no value to check/;

done_testing();
