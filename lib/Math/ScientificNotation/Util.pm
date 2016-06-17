package Math::ScientificNotation::Util;

# DATE
# VERSION

use Exporter qw(import);
our @EXPORT_OK = qw(sci2dec);

sub sci2dec {
    my $num = shift;
    if ($num =~ /\A(?:[+-]?)(?:\d+\.|\d*\.(\d+))[eE]([+-]?\d+)\z/) {
        my $num_digs_after_dec = length($1 || "") - $2;
        $num_digs_after_dec = 0 if $num_digs_after_dec < 0;
        return sprintf("%.${num_digs_after_dec}f", $num);
    } elsif ($num =~ /\A[+-]?(?:\d+\.|\d*\.\d+)\z/) {
        # already in decimal notation
        return $num;
    } else {
        die "Not a decimal number";
    }
}

1;
# ABSTRACT: Utilities related to scientific notation

=head1 SYNOPSIS

 use Math::ScientificNotation::Util qw(sci2dec);

 say sci2dec("1.2e-6"); # => 0.0000012


=head1 DESCRIPTION


=head1 FUNCTIONS

None exported by default, but they are exportable.

=head2 sci2dec($sci) => $dec

Convert scientific notation number to decimal number.

Note that if you are sure that your number is not too large or small, you can
just let Perl convert it for you:

 "1.2e-4"+0    # 0.00012
 1*"1.2e8"     # 120000000

but:

 "1.2e-5"+0    # => 1.2e-5
 1*"1.2e20"    # 1.2e+20


=head1 FAQ

=head2 Where is dec2sci?

To convert to scientific notation, you can use C<sprintf()> with the C<%e>,
C<%E>, C<%g>, or C<%G> format, for example:

 sprintf("%.2e", 1234)   # => 1.23e+03

=cut
