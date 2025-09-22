package Plugins::MellowDspFIR::Plugin;

use strict;
use warnings;

use Slim::Utils::Log;
use Slim::Utils::Prefs;
use Slim::Utils::Strings;
use Slim::Control::Request;

my $log = logger('plugin.mellowdspfir');
my $prefs = preferences('plugin.mellowdspfir');

sub initPlugin {
    my ($class) = @_;
    
    $log->info("Mellow-Dsp-FIR plugin v0.2.0-PCM initialized");
    
    # Load settings modules
    eval {
        require Plugins::MellowDspFIR::Settings;
        Plugins::MellowDspFIR::Settings->new();
    };
    
    if ($@) {
        $log->error("Failed to load settings: $@");
        return 0;
    }
    
    return 1;
}

1;
