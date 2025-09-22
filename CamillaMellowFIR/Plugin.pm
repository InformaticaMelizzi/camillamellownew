package Plugins::CamillaMellowFIRFIR::Plugin;

use strict;
use warnings;

use Slim::Utils::Log;

my $log = logger('plugin.camillamellowfirfir');

sub initPlugin {
    my $class = shift;
    
    $log->info("CamillaMellowFIRFIR DSP Plugin initialized successfully");
    
    # COPIA ESATTA metodo C-3PO
    require Plugins::CamillaMellowFIRFIR::PlayerSettings;
    Plugins::CamillaMellowFIRFIR::PlayerSettings->new($class);
    
    return 1;
}

sub getDisplayName {
    return 'PLUGIN_CAMILLAMELLOW';
}

sub shutdownPlugin {
    $log->info("CamillaMellowFIRFIR DSP Plugin shutdown");
}

1;
