package Plugins::MellowDspFIR::Plugin;

use strict;
use warnings;

sub initPlugin {
    my ($class) = @_;
    
    # Log semplice
    warn "Mellow-Dsp-FIR plugin v0.2.0-PCM-MINI initialized";
    
    return 1;
}

1;
