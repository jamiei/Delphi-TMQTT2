program TMQTTLibTests;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Forms,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  TestMQTTHeaders in 'TestMQTTHeaders.pas',
  MQTTHeaders in '..\TMQTT\MQTTHeaders.pas',
  TestMQTTReadThread in 'TestMQTTReadThread.pas',
  MQTTReadThread in '..\TMQTT\MQTTReadThread.pas',
  MQTT in '..\TMQTT\MQTT.pas',
  TestMQTT in 'TestMQTT.pas';

{$R *.RES}

begin
  Application.Initialize;
  if IsConsole then
    TextTestRunner.RunRegisteredTests
  else
    GUITestRunner.RunRegisteredTests;
end.

