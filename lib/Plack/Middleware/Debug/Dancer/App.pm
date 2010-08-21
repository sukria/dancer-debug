package Plack::Middleware::Debug::Dancer::App;

use strict;
use warnings;

use parent qw/Plack::Middleware::Debug::Base/;
use Dancer::App;

sub run {
    my ( $self, $env, $panel ) = @_;

    return sub {
        my $applications;

        foreach my $app ( Dancer::App->applications ) {
            $applications->{ $app->{name} } = $app->{settings};
        }

        $panel->title('Applications');
        $panel->nav_title('Applications');
        $panel->content(
            sub { $self->render_hash( $applications, [ keys %$applications ] ) }
        );
    };
}

1;
