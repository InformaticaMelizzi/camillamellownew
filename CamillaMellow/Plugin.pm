package Plugins::CamillaMellow::Plugin;

use strict;
use base qw(Slim::Plugin::Base);

sub initPlugin {
    my $class = shift;
    $class->SUPER::initPlugin(@_);
    return 1;
}

1;
