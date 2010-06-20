package Plack::Middleware::Debug::Dancer::Session;

# ABSTRACT: Session panel for your Dancer's application

use strict;
use warnings;
use parent qw(Plack::Middleware::Debug::Base);
use Dancer::Session;

sub run {
    my ( $self, $env, $panel ) = @_;

    return sub {
        my $session = Dancer::Session->get();
        my @settings = map { $_ => $session->{$_}} keys %$session;
        $panel->title('Dancer::Session');
        $panel->nav_subtitle("Dancer::Session");
        $panel->content( sub { $self->render_list_pairs( \@settings ) } );
    };
}

1;
