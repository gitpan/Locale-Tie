package Locale::Tie;

use 5.010001;
use strict;
use warnings;

use POSIX qw();

use Exporter qw(import);
our @EXPORT_OK = qw(
                       $LANG
               );

our $VERSION = '0.01'; # VERSION
our $DATE = '2014-05-13'; # DATE

our $LANG; tie $LANG, 'Locale::Tie::SCALAR' or die "Can't tie \$LANG";

{
    package Locale::Tie::SCALAR;
    use Carp;

    sub TIESCALAR {
        bless [], $_[0];
    }

    sub FETCH {
        POSIX::setlocale(0);
    }

    sub STORE {
        unless (POSIX::setlocale(&POSIX::LC_ALL, $_[1])) {
            carp "Can't setlocale to $_[1]";
        }
    }
}

1;
#ABSTRACT: Get/set locale via (localizeable) variables

__END__

=pod

=encoding UTF-8

=head1 NAME

Locale::Tie - Get/set locale via (localizeable) variables

=head1 VERSION

This document describes version 0.01 of Locale::Tie (from Perl distribution Locale-Tie), released on 2014-05-13.

=head1 SYNOPSIS

 use Locale::Tie qw($LANG);
 say "Current locale is ", $LANG; # -> en_US.UTF-8
 {
     local $LANG = 'id_ID';
     printf "%.2f\n", 12.34;  # -> 12,34
 }
 printf "%.2f\n", 12.34; # -> 12.34

=head1 DESCRIPTION

This module is inspired by L<File::chdir>, using a tied scalar variable to
get/set stuffs. One benefit of this is being able to use Perl's "local" with it,
effectively setting something locally.

=head1 EXPORTS

They are not exported by default, but exportable.

=head2 $LANG

=head1 TODO

Support $LC_ALL, $LC_COLLATE, $LC_NUMERIC, etc.

=head1 SEE ALSO

L<POSIX>

L<Locale::Scope>

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Locale-Tie>.

=head1 SOURCE

Source repository is at L<https://github.com/sharyanto/perl-Locale-Tie>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Locale-Tie>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
