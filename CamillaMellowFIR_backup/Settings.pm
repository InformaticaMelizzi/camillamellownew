package Plugins::CamillaMellow::Settings;

use strict;
use base qw(Slim::Web::Settings);

use Slim::Utils::Log;
use Slim::Utils::Prefs;

my $log = logger('plugin.camillamellow');
my $prefs = preferences('plugin.camillamellow');

sub name {
    return 'PLUGIN_CAMILLAMELLOW';
}

sub page {
    return 'plugins/CamillaMellow/settings/basic.html';
}

sub prefs {
    return ($prefs, qw(enabled fir_file_left fir_file_right));
}

sub handler {
    my ($class, $client, $paramRef) = @_;
    
    if ($paramRef->{'saveSettings'}) {
        $log->info("Saving CamillaMellow settings");
        
        # Salva preferenze
        $prefs->client($client)->set('enabled', $paramRef->{'enabled'} ? 1 : 0);
        $prefs->client($client)->set('fir_file_left', $paramRef->{'fir_file_left'} || '');
        $prefs->client($client)->set('fir_file_right', $paramRef->{'fir_file_right'} || '');
        
        $log->info("CamillaMellow settings saved successfully");
    }
    
    # Popola i valori per il form
    $paramRef->{'enabled'} = $prefs->client($client)->get('enabled', 1);
    $paramRef->{'fir_file_left'} = $prefs->client($client)->get('fir_file_left', '');
    $paramRef->{'fir_file_right'} = $prefs->client($client)->get('fir_file_right', '');
    
    return $class->SUPER::handler($client, $paramRef);
}

1;
