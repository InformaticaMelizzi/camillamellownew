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
    
    $log->info("Mellow-Dsp-FIR plugin v0.2.0-WAV-NOFORMAT initialized");
    
    # Load settings modules
    eval {
        require Plugins::MellowDspFIR::Settings;
        require Plugins::MellowDspFIR::PlayerSettings;
        Plugins::MellowDspFIR::Settings->new();
        Plugins::MellowDspFIR::PlayerSettings->new();
    };
    
    if ($@) {
        $log->error("Failed to load settings modules: $@");
        return 0;
    }
    
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
        $log->info("Mellow-Dsp-FIR WAV processing enabled for player: " . $client->name());
        initCamillaDSP($client);
    }
}

sub initCamillaDSP {
    my ($client) = @_;
    
    $log->info("Initializing CamillaDSP for WAV PCM processing");
    $log->info("Target: 768kHz PCM, 32-bit processing → 24-bit output with E-weighted dithering");
    
    # Configure for WAV output (solo configurazione, niente registrazione formati)
    my $config = {
        enabled => 1,
        output_format => 'wav',
        sample_rate => 768000,
        bit_depth => 32,
        target_depth => 24,
        dither => 'e_weighted',
        buffer_size => 2048,
    };
    
    $log->info("CamillaDSP config: " . join(', ', map { "$_=>$config->{$_}" } keys %$config));
}

1;
