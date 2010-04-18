package Plack::Middleware::Debug::Dancer::Logger;
use 5.008;
use strict;
use warnings;
use parent qw(Plack::Middleware::Debug::Base);
use Dancer::Logger;
use Class::Method::Modifiers qw(install_modifier);

# XXX Not thread/Coro/AE safe. Should use $c->env or something
my $psgi_env;
install_modifier 'Dancer::Logger', 'around', 'warning' => sub {
    my $orig = shift;
    my $self = shift;
    $psgi_env->{'plack.middleware.dancer_log'} .= "[warning] $_[0]\n";
    $self->$orig(@_);
};

install_modifier 'Dancer::Logger', 'around', 'error' => sub {
    my $orig = shift;
    my $self = shift;
    $psgi_env->{'plack.middleware.dancer_log'} .= "[error] $_[0]\n";
    $self->$orig(@_);
};

install_modifier 'Dancer::Logger', 'around', 'debug' => sub {
    my $orig = shift;
    my $self = shift;
    $psgi_env->{'plack.middleware.dancer_log'} .= "[debug] $_[0]\n";
    $self->$orig(@_);
};

sub run {
    my($self, $env, $panel) = @_;
    $psgi_env = $env;

    return sub {
        my $res = shift;

        $panel->title('Dancer::Logger');
        $panel->nav_subtitle('Dancer::Logger');
        my $log = delete $env->{'plack.middleware.dancer_log'};
        if ($log) {
            $panel->content("<pre>$log</pre>");
        }
        $psgi_env = undef;
    };
}

1;
__END__
