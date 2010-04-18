package Plack::Middleware::Debug::Dancer::Settings;
use 5.008;
use strict;
use warnings;
use parent qw(Plack::Middleware::Debug::Base);
use Class::Method::Modifiers qw/install_modifier/;
use Dancer::Config;

#my $psgi_env;
# install_modifier 'Dancer', 'around', 'start' => sub {
#     my $orig = shift;
#     my $self = shift;
#     $psgi_env->{'plack.middleware.dancer_settings'} = $self->config;
#     $self->$orig(@_);
# };

sub run {
    my ( $self, $env, $panel ) = @_;
#    $psgi_env = $env;

    return sub {
        my $res = shift;
        my $settings = Dancer::Config->settings();
#        my $settings = $env->{'plack.middleware.dancer_settings'};
        my @settings = map { $_ => $settings->{$_}} keys %$settings;
        $panel->content( sub { $self->render_list_pairs( \@settings ) } );
    };
}

1;
