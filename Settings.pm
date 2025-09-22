package Plugins::MellowDspFIR::Settings;

use strict;
use warnings;

use Slim::Utils::Log;
use Slim::Utils::Prefs;
use Slim::Web::Pages;

my $log = logger('plugin.mellowdspfir');
my $prefs = preferences('plugin.mellowdspfir');

sub new {
    my ($class) = @_;
    
    $log->info("Loading MellowDspFIR Settings");
    
    # Add web page
    eval {
        Slim::Web::Pages->addPageFunction(
            'plugins/Mellow-Dsp-FIR/settings/basic.html',
            \&basicSettings
        );
    };
    
    if ($@) {
        $log->error("Failed to add web page: $@");
    }
    
    return $class;
}

sub basicSettings {
    my ($client, $params, $callback, @args) = @_;
    
    if ($params->{saveSettings}) {
        $prefs->set('enabled', $params->{enabled} ? 1 : 0);
        $prefs->set('pcm_sample_rate', $params->{pcm_sample_rate} || '768000');
    }
    
    $params->{enabled} = $prefs->get('enabled');
    $params->{pcm_sample_rate} = $prefs->get('pcm_sample_rate');
    
    return Slim::Web::HTTP::filltemplatefile(
        'plugins/Mellow-Dsp-FIR/settings/basic.html',
        $params
    );
}

1;
