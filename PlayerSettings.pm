package Plugins::MellowDspFIR::PlayerSettings;

use strict;
use warnings;

use Slim::Utils::Log;
use Slim::Utils::Prefs;

my $log = logger('plugin.mellowdspfir');
my $prefs = preferences('plugin.mellowdspfir');

sub new {
    my ($class) = @_;
    
    $log->info("Loading MellowDspFIR PlayerSettings");
    
    return $class;
}

1;
