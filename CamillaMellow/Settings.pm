package Plugins::CamillaMellow::Settings;

use strict;
use base qw(Slim::Web::Settings);
use Slim::Utils::Prefs;

my $prefs = preferences('plugin.camillamellow');

sub name {
    return 'PLUGIN_CAMILLAMELLOW';
}

sub page {
    return 'plugins/CamillaMellow/settings.html';
}

sub prefs {
    return ($prefs, qw(fir_left fir_right enabled));
}

1;
