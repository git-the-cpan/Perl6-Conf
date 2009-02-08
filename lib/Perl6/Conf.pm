class Perl6::Conf;

=begin pod

=head1 NAME

Perl6::Conf - Experimental Perl 6 implementation of an INI file reader

=head1 SYNOPSIS

TBD.

=end pod 

our $VERSION = '0.02';

use Perl6::Conf::Grammar;

has $!in;

method from_string( Str $in ) {
    return self.new(in => $in);
}

method from_file($file_path) {
    return self.from_string( slurp($file_path) );
}

#method parse( $in? ) {
    # TODO: If used .parse fall tests, fix it! ????
    #($in || $!in) ~~ /<Perl6::Conf::Grammar::TOP>/;
    #die("No match") unless $/;
    #return $/<Perl6::Conf::Grammar::TOP><contents>;
#}

method parse {
	my %data;
	my $section;
	for $!in.split(/\n/) -> $line {
		#say "L $line";
		if ($line ~~ / \[ (.*) \] /) {
			$section = $0;
			%data{$section} = {};
			next;
		}
		if ($line ~~ / ^^ (\w+) \s*\=\s* (.*) $$ /) {
			my $key = $0;
			my $value = $1;
			die "No section yet" if not defined $section;
			%data{$section}{$key} = $value;
		}
	}
	return %data;
}

# Copyright 2009 Gabor Szabo. L<http://www.szabgab.com/>
# License:
# This program is free software; you can redistribute it and/or
# modify it under the Artistic 2 license.


# DISCLAIMER OF WARRANTY

# BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
# FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN
# OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
# PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER
# EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
# ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE SOFTWARE IS WITH
# YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
# NECESSARY SERVICING, REPAIR, OR CORRECTION.
# 
# IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
# WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
# REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE
# LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL,
# OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE
# THE SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
# RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
# FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
# SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGES.


