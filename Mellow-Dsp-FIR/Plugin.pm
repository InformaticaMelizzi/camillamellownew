package Plugins::MellowDspFIR::Plugin;

use strict;
use warnings;

use Slim::Utils::Log;
use Slim::Utils::Prefs;
use Slim::Utils::Strings;

my $log = logger('plugin.mellowdspfir');
my $prefs = preferences('plugin.mellowdspfir');

sub initPlugin {
    my ($class) = @_;
    
    $log->info("Mellow-Dsp-FIR plugin v0.2.0 initialized");
    
    # Load settings modules
    Plugins::MellowDspFIR::Settings->new();
    Plugins::MellowDspFIR::PlayerSettings->new();
    
    # Subscribe to player events
    Slim::Control::Request::subscribe(\&playerChangeCallback, [['client'], ['new', 'reconnect', 'disconnect']]);
    
    return 1;
}

sub playerChangeCallback {
    my ($request) = @_;
    my $client = $request->client();
    
    return unless $client;
    
    my $enabled = $prefs->client($client)->get('enabled');
    
    if ($enabled) {
        $log->info("Mellow-Dsp-FIR enabled for player: " . $client->name());
        # Initialize CamillaDSP pipeline
        initCamillaDSP($client);
    }
}

sub initCamillaDSP {
    my ($client) = @_;
    my $output_format = $prefs->client($client)->get('output_format') || 'wav';
    
    $log->info("Initializing CamillaDSP with format: $output_format");
    
    # CamillaDSP initialization logic here
    # This will connect to camilladsp daemon
}

1;
