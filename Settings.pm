package Plugins::MellowDspFIR::Settings;

use strict;
use warnings;

use Slim::Utils::Log;
use Slim::Utils::Prefs;

my $log = logger('plugin.mellowdspfir');
my $prefs = preferences('plugin.mellowdspfir');

sub new {
    my ($class) = @_;
    
    # Add web pages
    Slim::Web::Pages->addPageFunction(
        'plugins/Mellow-Dsp-FIR/settings/basic.html',
        \&basicSettings
    );
    
    Slim::Web::Pages->addPageFunction(
        'plugins/Mellow-Dsp-FIR/settings/fir.html',
        \&firSettings
    );
    
    Slim::Web::Pages->addPageFunction(
        'plugins/Mellow-Dsp-FIR/settings/advanced.html',
        \&advancedSettings
    );
    
    return $class;
}

sub basicSettings {
    my ($client, $params, $callback, @args) = @_;
    
    if ($params->{saveSettings}) {
        $prefs->set('enabled', $params->{enabled} ? 1 : 0);
        $prefs->set('pcm_sample_rate', $params->{pcm_sample_rate} || '768000');
        $prefs->set('pcm_bit_depth', $params->{pcm_bit_depth} || '32');
        $prefs->set('pcm_dither', $params->{pcm_dither} || 'e_weighted');
    }
    
    $params->{enabled} = $prefs->get('enabled');
    $params->{pcm_sample_rate} = $prefs->get('pcm_sample_rate');
    $params->{pcm_bit_depth} = $prefs->get('pcm_bit_depth');
    $params->{pcm_dither} = $prefs->get('pcm_dither');
    
    return Slim::Web::HTTP::filltemplatefile(
        'plugins/Mellow-Dsp-FIR/settings/basic.html',
        $params
    );
}

sub firSettings {
    my ($client, $params, $callback, @args) = @_;
    
    if ($params->{saveSettings}) {
        $prefs->set('fir_enabled', $params->{fir_enabled} ? 1 : 0);
        $prefs->set('fir_file_left', $params->{fir_file_left} || '');
        $prefs->set('fir_file_right', $params->{fir_file_right} || '');
        $prefs->set('fir_gain', $params->{fir_gain} || '0');
        $prefs->set('pcm_upsampling', $params->{pcm_upsampling} || '16x');
    }
    
    $params->{fir_enabled} = $prefs->get('fir_enabled');
    $params->{fir_file_left} = $prefs->get('fir_file_left');
    $params->{fir_file_right} = $prefs->get('fir_file_right');
    $params->{fir_gain} = $prefs->get('fir_gain');
    $params->{pcm_upsampling} = $prefs->get('pcm_upsampling');
    
    return Slim::Web::HTTP::filltemplatefile(
        'plugins/Mellow-Dsp-FIR/settings/fir.html',
        $params
    );
}

sub advancedSettings {
    my ($client, $params, $callback, @args) = @_;
    
    if ($params->{saveSettings}) {
        $prefs->set('camilla_pcm_config', $params->{camilla_pcm_config} || '');
        $prefs->set('pcm_buffer_size', $params->{pcm_buffer_size} || '2048');
        $prefs->set('pcm_phase_response', $params->{pcm_phase_response} || 'linear');
        $prefs->set('pcm_target_depth', $params->{pcm_target_depth} || '24');
    }
    
    $params->{camilla_pcm_config} = $prefs->get('camilla_pcm_config');
    $params->{pcm_buffer_size} = $prefs->get('pcm_buffer_size');
    $params->{pcm_phase_response} = $prefs->get('pcm_phase_response');
    $params->{pcm_target_depth} = $prefs->get('pcm_target_depth');
    
    return Slim::Web::HTTP::filltemplatefile(
        'plugins/Mellow-Dsp-FIR/settings/advanced.html',
        $params
    );
}

1;
