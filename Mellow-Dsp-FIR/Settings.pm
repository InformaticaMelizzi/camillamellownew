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
        $prefs->set('output_format', $params->{output_format} || 'wav');
        $prefs->set('sample_rate', $params->{sample_rate} || '768000');
        $prefs->set('bit_depth', $params->{bit_depth} || '32');
    }
    
    $params->{enabled} = $prefs->get('enabled');
    $params->{output_format} = $prefs->get('output_format');
    $params->{sample_rate} = $prefs->get('sample_rate');
    $params->{bit_depth} = $prefs->get('bit_depth');
    
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
    }
    
    $params->{fir_enabled} = $prefs->get('fir_enabled');
    $params->{fir_file_left} = $prefs->get('fir_file_left');
    $params->{fir_file_right} = $prefs->get('fir_file_right');
    $params->{fir_gain} = $prefs->get('fir_gain');
    
    return Slim::Web::HTTP::filltemplatefile(
        'plugins/Mellow-Dsp-FIR/settings/fir.html',
        $params
    );
}

sub advancedSettings {
    my ($client, $params, $callback, @args) = @_;
    
    if ($params->{saveSettings}) {
        $prefs->set('camilla_config', $params->{camilla_config} || '');
        $prefs->set('buffer_size', $params->{buffer_size} || '2048');
        $prefs->set('enable_dither', $params->{enable_dither} ? 1 : 0);
    }
    
    $params->{camilla_config} = $prefs->get('camilla_config');
    $params->{buffer_size} = $prefs->get('buffer_size');
    $params->{enable_dither} = $prefs->get('enable_dither');
    
    return Slim::Web::HTTP::filltemplatefile(
        'plugins/Mellow-Dsp-FIR/settings/advanced.html',
        $params
    );
}

1;
