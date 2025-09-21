package Plugins::CamillaMellow::Plugin;

use strict;
use base qw(Slim::Plugin::Base);
use Slim::Utils::Prefs;

my $prefs = preferences('plugin.camillamellow');

sub initPlugin {
    my $class = shift;
    
    # Registra settings per player
    Slim::Control::Request::addDispatch(
        ['camillamellow', 'status'], [0, 1, 1, \&status]);
    
    $class->SUPER::initPlugin(@_);
}

sub getDisplayName {
    return 'PLUGIN_CAMILLAMELLOW';
}

sub playerSettings {
    my ($class, $client, $params) = @_;
    
    return unless $client;
    
    my $firLeft = $prefs->client($client)->get('fir_left') || 'None';
    my $firRight = $prefs->client($client)->get('fir_right') || 'None';
    my $enabled = $prefs->client($client)->get('enabled') || 0;
    
    return {
        fir_left => $firLeft,
        fir_right => $firRight,
        enabled => $enabled,
    };
}

sub setPlayerSettings {
    my ($class, $client, $params) = @_;
    
    return unless $client;
    
    if (exists $params->{fir_left}) {
        $prefs->client($client)->set('fir_left', $params->{fir_left});
    }
    if (exists $params->{fir_right}) {
        $prefs->client($client)->set('fir_right', $params->{fir_right});
    }
    if (exists $params->{enabled}) {
        $prefs->client($client)->set('enabled', $params->{enabled});
    }
}

1;
