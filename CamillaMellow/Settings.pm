package Plugins::CamillaMellow::Settings;

use strict;
use base qw(Slim::Web::Settings);

sub name {
    return 'PLUGIN_CAMILLAMELLOW';
}

sub page {
    return 'plugins/CamillaMellow/settings.html';
}

1;
