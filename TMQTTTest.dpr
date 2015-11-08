program TMQTTTest;

uses
  Forms,
  uMain in 'uMain.pas' {fMain},
  MQTT in 'TMQTT\MQTT.pas',
  MQTTHeaders in 'TMQTT\MQTTHeaders.pas',
  MQTTReadThread in 'TMQTT\MQTTReadThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
