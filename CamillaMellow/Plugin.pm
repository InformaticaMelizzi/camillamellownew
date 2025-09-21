package Plugins::CamillaMellow::Plugin;

use strict;
use base qw(Slim::Plugin::Base);
use Slim::Utils::Prefs;

my $prefs = preferences('plugin.camillamellow');

sub initPlugin {
    my $class = shift;
    
    # Registra settings
    Slim::Web::Pages->addPageFunction(
        'plugins/CamillaMellow/settings.html',
        \&settingsPage
    );
    
    $class->SUPER::initPlugin(@_);
}

sub settingsPage {
    my ($client, $params, $callback, $httpClient, $response) = @_;
    
    # Gestisci upload FIR
    if ($params->{fir_left} || $params->{fir_right}) {
        # Salva file FIR
        if ($params->{fir_left}) {
            my $left = $params->{fir_left};
            # Salva in /media/hdd/system/fir_left.wav
        }
        if ($params->{fir_right}) {
            my $right = $params->{fir_right};
            # Salva in /media/hdd/system/fir_right.wav
        }
    }
    
    # Mostra form upload
    my $content = '
    <h2>CamillaMellow DSP Settings</h2>
    <form method="POST" enctype="multipart/form-data">
        <p>Upload FIR Left: <input type="file" name="fir_left" accept=".wav"></p>
        <p>Upload FIR Right: <input type="file" name="fir_right" accept=".wav"></p>
        <p><input type="submit" value="Upload FIR Files"></p>
    </form>';
    
    $callback->($client, $params, $content, $response);
}

1;
