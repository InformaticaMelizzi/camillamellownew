package Plugins::CamillaMellow::PlayerSettings;

use strict;
use warnings;

use Slim::Utils::Prefs;
use Slim::Utils::Log;

my $log = logger('plugin.camillamellow');
my $prefs = preferences('plugin.camillamellow');

sub new {
    my ($class) = @_;
    
    # Registra le impostazioni del player - COPIA ESATTA C-3PO
    Slim::Web::Pages->addPageFunction(
        'plugins/CamillaMellow/settings/basic.html',
        \&settingsPage
    );
    
    return $class;
}

sub settingsPage {
    my ($client, $params, $callback, @args) = @_;
    
    if ($params->{saveSettings}) {
        $prefs->client($client)->set('enabled', $params->{enabled} ? 1 : 0);
        $prefs->client($client)->set('fir_file_left', $params->{fir_file_left} || '');
        $prefs->client($client)->set('fir_file_right', $params->{fir_file_right} || '');
    }
    
    $params->{enabled} = $prefs->client($client)->get('enabled');
    $params->{fir_file_left} = $prefs->client($client)->get('fir_file_left');
    $params->{fir_file_right} = $prefs->client($client)->get('fir_file_right');
    $params->{player} = $client->id();
    
    return Slim::Web::HTTP::filltemplatefile(
        'plugins/CamillaMellow/settings/basic.html',
        $params
    );
}

1;
