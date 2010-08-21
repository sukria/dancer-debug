package Plack::Middleware::Debug::Dancer::Routes;

# ABSTRACT: Show available and matched routes for your application

use strict;
use warnings;
use parent qw(Plack::Middleware::Debug::Base);

sub run {
    my ( $self, $env, $panel ) = @_;

    return sub {
        my $hash_routes = {};
        foreach my $app ( Dancer::App->applications ) {
            my $routes = $app->{registry}->{routes};
            foreach my $method (keys %$routes) {
                foreach (@{$routes->{$method}}) {
                    $hash_routes->{$method}->{$_->{_compiled_regexp}} = $_->{_params};
                }
            }
                # map {
                #     my $name = $_->{method} . ' ' . $_->{route};
                #     $hash_routes->{$name} = {
                #         method  => $_->{method},
                #         options => $_->{options},
                #         params  => $_->{params},
                #         route   => $_->{route}
                #     };
                # } @{ $routes->{$method} };
        }

        $panel->title('Dancer::Route');
        $panel->nav_subtitle(
            "Dancer::Route (" . ( keys %$hash_routes ) . ")" );
        $panel->content(
            sub { $self->render_hash( $hash_routes, [keys %$hash_routes] ) }
        );
    };
}

1;

=head1 SYNOPSIS

To activate this panel:

    plack_middlewares:
      Debug:
        - panels
        -
          - Dancer::Routes
