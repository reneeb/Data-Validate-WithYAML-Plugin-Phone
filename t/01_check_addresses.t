#!perl -T

use Test::More tests => 10;

BEGIN {
    use_ok( 'Data::Validate::WithYAML::Plugin::Phone' );
}

my $module = 'Data::Validate::WithYAML::Plugin::Phone';

my @phones = (
    '+4412345677',
    '004412345677',
    '0157124567889',
);

my @blacklist = (
    'test',
    '123',
    '+12as',
    '+1234567',
    '00012345678',
    '+012455678832',
);

for my $phone ( @phones ){
    ok( $module->check($phone), "test: $phone" );
}

for my $check ( @blacklist ){
    my $retval = $module->check( $check );
    ok( !$retval, "test: $check" );
}
