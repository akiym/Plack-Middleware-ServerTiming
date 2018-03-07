package Plack::ServerTiming;
use strict;
use warnings;

sub new {
    my ($class, $env) = @_;
    return bless {
        env => $env,
    } => $class;
}

sub record_timing {
    my ($self, $name, $field) = @_;
    $field ||= {};

    push @{ $self->{env}->{'psgix.server-timing'} } => [$name, $field];
}

1;
__END__

=pod

=encoding utf-8

=head1 NAME

Plack::ServerTiming - Frontend for Plack::Middleware::ServerTiming

=head1 SYNOPSIS

    use Plack::ServerTiming;

    builder {
        enable 'ServerTiming';
        sub {
            my $env = shift;
            my $t = Plack::ServerTiming->new($env);
            sleep 1;
            $t->record_timing('miss');
            $t->record_timing(sleep => {dur => 1000, desc => 'Sleep one second...'});
            [200, ['Content-Type','text/html'], ["OK"]];
        };
    };

=head1 DESCRIPTION

This module provides high level API for L<Plack::Middleware::ServerTiming>.

=head1 SEE ALSO

L<Plack::Middleware::ServerTiming>

=head1 LICENSE

Copyright (C) Takumi Akiyama.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Takumi Akiyama E<lt>t.akiym@gmail.comE<gt>

=cut
