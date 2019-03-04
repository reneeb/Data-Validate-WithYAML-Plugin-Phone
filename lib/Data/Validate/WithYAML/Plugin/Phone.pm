package Data::Validate::WithYAML::Plugin::Phone;

use warnings;
use strict; 

use Carp;
use Try::Tiny;
use Scalar::Util qw(blessed);

# ABSTRACT: Plugin to check Phone numbers (basic check)

our $VERSION = '0.05';

=head1 SYNOPSIS

    use Data::Validate::WithYAML::Plugin::Phone;

    my $foo = Data::Validate::WithYAML::Plugin::Phone->check( '+49 123 456789' );
    ...
    
    # use the plugin via Data::Validate::WithYAML
    
    use Data::Validate::WithYAML;
    
    my $phone     = '+49 123 456789';
    my $validator = Data::Validate::WithYAML->new( 'test.yml' );
    print "yes" if $validator->check( 'phone', $phone );

test.yml

  ---
  step1:
      phone:
          plugin: Phone
          type: required
  

=head1 SUBROUTINES

=head2 check

=cut

sub check {
    my ($class, $value, $config) = @_;
    
    croak "no value to check" unless defined $value;

    if ( $config && $config->{country} ) {
        my $country = $config->{country};
        my $return = 0;
        my $number;
        my $error;

        require 'Number/Phone.pm';

        try {
            $number = Number::Phone->new( $country, $value );

            return if !blessed $number;

            $error = 'No support for ' . $country if $number->isa('Number::Phone::StubCountry');

            $return = 1;
        };

        croak $error if $error;

        return $return;
    }
    
    my $return = 0;
    $value =~ s/\s//g;
    if( $value =~ m{\A (?: \+ | 00? ) [1-9]{2,6} \s*? [/-]? \s*? [0-9]{4,12} \z}x ){
        $return = 1;
    }
    
    return $return;
}

1;
