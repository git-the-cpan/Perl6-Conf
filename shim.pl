use strict;
use warnings;

use Config;
use File::Spec;
my $sep = $Config{path_sep};

my $rakudo_dir = File::Spec->catdir($ENV{PARROT_DIR}, 'languages', 'rakudo');

my @libs = $ENV{PERL6LIB} ? split (/$sep/, $ENV{PERL6LIB}) : ();
$ENV{PERL6LIB} = join $sep, $rakudo_dir, @libs;


my $parrot = File::Spec->catfile($ENV{PARROT_DIR}, 'parrot') . ($^O eq "MSWin32" ? '.exe' : '');
my $rakudo = File::Spec->catfile($ENV{PARROT_DIR}, 'languages', 'rakudo', 'perl6.pbc');

(my $file = $0) =~ s/t$/t6/;
system "$parrot $rakudo $file";

