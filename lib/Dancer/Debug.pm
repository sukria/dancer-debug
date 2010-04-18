package Dancer::Debug;

use strict;
use warnings;
our $VERSION = '0.01';

1;
__END__

=head1 NAME

Dancer::Debug - Extension for Dancer specific panel to L<Plack::Middleware::Debug>

=head1 SYNOPSIS

    my $handler = sub {
        my $env     = shift;
        my $request = Dancer::Request->new($env);
        Dancer->dance($request);
    };

    $handler = builder {
        enable "Debug",
            panels => [qw/Dancer::Settings Dancer::Logger Parameters Dancer::Version/];
        $handler;
    };

=head1 DESCRIPTION

Dancer::Debug is

=head1 AUTHOR

franck cuny E<lt>franck@lumberjaph.netE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
