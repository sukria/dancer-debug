package Dancer::Debug;

# ABSTRACT: Extend Plack::Middleware::Debug with some specific panels for Dancer

use strict;
use warnings;
our $VERSION = '0.01';

1;

=head1 SYNOPSIS

You can activate the panels in your development configuration file:

    plack_middlewares:
      Debug:
        - panels
        -
          - Parameters
          - Dancer::Version
          - Dancer::Settings
          - Dancer::Logger

or in your app.psgi:

    $handler = builder {
        enable "Debug",
            panels => [qw/Dancer::Settings Dancer::Logger Parameters Dancer::Version/];
        $handler;
    };

=head1 DESCRIPTION

Dancer::Debug extends L<Plack::Middleware::Debug> with some specific panels for Dancer.
