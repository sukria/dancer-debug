package Plack::Middleware::Debug::Dancer::Version;

# ABSTRACT: Show Dancer's version

use strict;
use warnings;
use parent qw(Plack::Middleware::Debug::Base);

sub run {
    my ( $self, $env, $panel ) = @_;

    return sub {
        $panel->title('Dancer::Version');
        $panel->nav_title('Dancer::Version');
        $panel->nav_subtitle($Dancer::VERSION);
    };
}

1;

=head1 SYNOPSIS

To activate this panel:

    plack_middlewares:
      Debug:
        - panels
        -
          - Dancer::Version
