package Plugins::CamillaMellow::Plugin;

use strict;
use base qw(Slim::Plugin::Base);
use Slim::Utils::Prefs;
use Slim::Web::HTTP;

my $prefs = preferences('plugin.camillamellow');

sub initPlugin {
    my $class = shift;
    
    # Registra route per settings
    Slim::Web::HTTP::addPageFunction({
        'plugins/CamillaMellow/settings.html' => \&settingsPage,
    });
    
    $class->SUPER::initPlugin(@_);
}

sub settingsPage {
    my ($client, $params, $callback, $httpClient, $response) = @_;
    
    # Contenuto semplice per upload FIR
    my $content = '
    <html>
    <head><title>CamillaMellow Settings</title></head>
    <body>
        <h1>CamillaMellow DSP Settings</h1>
        <h2>Upload FIR Files</h2>
        <form method="POST" enctype="multipart/form-data">
            <p>Left FIR: <input type="file" name="fir_left" accept=".wav"></p>
            <p>Right FIR: <input type="file" name="fir_right" accept=".wav"></p>
            <p><input type="submit" value="Upload FIR Files"></p>
        </form>
    </body>
    </html>';
    
    $callback->($client, $params, $content, $response);
}

1;
