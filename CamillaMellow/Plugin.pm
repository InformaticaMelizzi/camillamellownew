package Plugins::CamillaMellow::Plugin;

use strict;
use warnings;

use Slim::Utils::Log;

my $log = logger('plugin.camillamellow');

sub initPlugin {
    my $class = shift;
    
    $log->info("CamillaMellow DSP Plugin initialized successfully");
    
    # COPIA ESATTA metodo C-3PO
    require Plugins::CamillaMellow::PlayerSettings;
    Plugins::CamillaMellow::PlayerSettings->new($class);
    
    return 1;
}

sub getDisplayName {
    return 'PLUGIN_CAMILLAMELLOW';
}

sub shutdownPlugin {
    $log->info("CamillaMellow DSP Plugin shutdown");
}

1;
