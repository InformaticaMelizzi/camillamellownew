package Plugins::MellowDspFIR::PlayerSettings;

use strict;
use warnings;

use Slim::Utils::Log;
use Slim::Utils::Prefs;

my $log = logger('plugin.mellowdspfir');
my $prefs = preferences('plugin.mellowdspfir');

sub new {
    my ($class) = @_;
    
    # Register player-specific settings
    Slim::Control::Request::addDispatch(
        ['mellowdspfir', 'enabled'],
        [1, 1, 1, \&setEnabled]
    );
    
    Slim::Control::Request::addDispatch(
        ['mellowdspfir', 'status'],
        [0, 1, 1, \&getStatus]
    );
    
    return $class;
}

sub setEnabled {
    my ($request) = @_;
    my $client = $request->client();
    
    return unless $client;
    
    my $enabled = $request->getParam('_enabled');
    $prefs->client($client)->set('enabled', $enabled ? 1 : 0);
    
    $log->info("Mellow-Dsp-FIR " . ($enabled ? "enabled" : "disabled") . " for " . $client->name());
    
    $request->setStatusDone();
}

sub getStatus {
    my ($request) = @_;
    my $client = $request->client();
    
    return unless $client;
    
    my $enabled = $prefs->client($client)->get('enabled');
    my $output_format = $prefs->client($client)->get('output_format');
    my $sample_rate = $prefs->client($client)->get('sample_rate');
    
    $request->addResult('enabled', $enabled);
    $request->addResult('output_format', $output_format);
    $request->addResult('sample_rate', $sample_rate);
    $request->setStatusDone();
}

1;
