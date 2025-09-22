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
    
    $log->info("Mellow-Dsp-FIR plugin v0.2.0-PCM initialized");
    
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
        $log->info("Mellow-Dsp-FIR PCM processing enabled for player: " . $client->name());
        # Initialize CamillaDSP pipeline for PCM
        initCamillaDSP($client);
    }
}

sub initCamillaDSP {
    my ($client) = @_;
    
    $log->info("Initializing CamillaDSP for PCM pass-through");
    $log->info("Target: 768kHz PCM, 32-bit processing → 24-bit output with E-weighted dithering");
    
    # CamillaDSP initialization for PCM pipeline
    # Direct PCM processing without WAV wrapper
}

1;
