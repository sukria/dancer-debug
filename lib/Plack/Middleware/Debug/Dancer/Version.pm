package Plack::Middleware::Debug::Dancer::Version;
use 5.008;
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
