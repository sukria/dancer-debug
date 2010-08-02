package Plack::Middleware::Debug::Dancer::Settings;

# ABSTRACT: Settings panel of your Dancer's application

use strict;
use warnings;
use parent qw(Plack::Middleware::Debug::Base);
use Class::Method::Modifiers qw/install_modifier/;
use Dancer::Config;

sub run {
    my ( $self, $env, $panel ) = @_;

    return sub {
        my $res = shift;
        my $settings = Dancer::Config->settings();
        $panel->title('Dancer::Settings');
        $panel->nav_subtitle('Dancer::Settings');
        my @settings = map { $_ => $settings->{$_}} keys %$settings;
        $panel->content( sub { $self->render_list_pairs( \@settings ) } );
    };
}

1;

=head1 SYNOPSIS

To activate this panel:

    plack_middlewares:
      Debug:
        - panels
        -
          - Dancer::Settings
