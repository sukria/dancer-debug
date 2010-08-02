package Plack::Middleware::Debug::Dancer::Logger;

# ABSTRACT: Log message from you Dancer's application

use strict;
use warnings;
use parent qw(Plack::Middleware::Debug::Base);
use Dancer::Logger;
use Class::Method::Modifiers qw(install_modifier);

# # XXX Not thread/Coro/AE safe. Should use $c->env or something
my $psgi_env;
install_modifier 'Dancer::Logger', 'before', 'error' => sub {
    _add_log( 'error', @_ );
};

install_modifier 'Dancer::Logger', 'before', 'warning' => sub {
    _add_log( 'warning', @_ );
};

install_modifier 'Dancer::Logger', 'before', 'debug' => sub {
    _add_log( 'debug', @_ );
};

sub _add_log {
    my ( $level, $msg ) = @_;
    push @{ $psgi_env->{'plack.middleware.dancer_log'} }, $level, $msg;
}

sub run {
    my ( $self, $env, $panel ) = @_;
    $psgi_env = $env;

    return sub {
        my $res = shift;
        $panel->title('Dancer::Logger');
        $panel->nav_subtitle('Dancer::Logger');
        my $logs = delete $env->{'plack.middleware.dancer_log'}
          if $env->{'plack.middleware.dancer_log'};
        $panel->content( sub { $self->render_list_pairs($logs) } ) if $logs;
        $psgi_env = undef;
    };
}


1;

=head1 SYNOPSIS

To activate this panel:

    plack_middlewares:
      Debug:
        - panels
        -
          - Dancer::Logger
