package Data::Validate::WithYAML::Plugin::Phone;

use warnings;
use strict; 

use Carp;

# ABSTRACT: Plugin to check Phone numbers (basic check)

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

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
    my ($class, $value) = @_;
    
    croak "no value to check" unless defined $value;
    
    my $return = 0;
    if( $value =~ m{\A (?: \+ | 00? ) [1-9] [0-9]{7,} \z}x ){
        $return = 1;
    }
    return $return;
}

=head1 AUTHOR

Renee Baecker, C<< <module at renee-baecker.de> >>

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Data::Validate::WithYAML::Plugin::Phone

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2011 Renee Baecker, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
