unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,

  MQTT;

type
  TfMain = class(TForm)
    lblHeader: TLabel;
    lnlMQTTInfo: TLabel;
    lblMQTTUrl: TLabel;
    lblPrimarilyTested: TLabel;
    lblRSMBUrl: TLabel;
    lblLimits: TLabel;
    lblLimits2: TLabel;
    lblSynapse: TLabel;
    btnConnect: TButton;
    btnDisconnect: TButton;
    btnPublish: TButton;
    eTopic: TEdit;
    eMessage: TEdit;
    eIP: TEdit;
    ePort: TEdit;
    btnPing: TButton;
    btnSubscribe: TButton;
    eSubTopic: TEdit;
    mStatus: TMemo;
    procedure btnConnectClick(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure btnPingClick(Sender: TObject);
    procedure btnPublishClick(Sender: TObject);
    procedure btnSubscribeClick(Sender: TObject);
    procedure GotConnAck(Sender: TObject; ReturnCode: integer);
    procedure GotPingResp(Sender: TObject);
    procedure GotSubAck(Sender: TObject; MessageID: integer; GrantedQoS: Array of integer);
    procedure GotUnSubAck(Sender: TObject; MessageID: integer);
    procedure GotPub(Sender: TObject; topic, payload: Ansistring);
    procedure GotPubAck(Sender: TObject; MessageID: integer);
    procedure GotPubRec(Sender: TObject; MessageID: integer);
    procedure GotPubRel(Sender: TObject; MessageID: integer);
    procedure GotPubComp(Sender: TObject; MessageID: integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMain: TfMain;
  MQTT: TMQTT;

implementation

{$R *.dfm}

procedure TfMain.btnConnectClick(Sender: TObject);
begin
  MQTT := TMQTT.Create(eIP.Text, StrToInt(ePort.Text));
  MQTT.WillTopic := '/clients/will';
  MQTT.WillMsg := 'Broker died!';
  // Events
  MQTT.OnConnAck := GotConnAck;
  MQTT.OnPublish := GotPub;
  MQTT.OnPingResp := GotPingResp;
  MQTT.OnSubAck := GotSubAck;
  MQTT.OnUnSubAck := GotUnSubAck;
  MQTT.OnPubAck := GotPubAck;

  if MQTT.Connect then
    mStatus.Lines.Add('Connected to ' + eIP.Text + ' on ' + ePort.Text)
  else
    mStatus.Lines.Add('Failed to connect');
end;

procedure TfMain.btnDisconnectClick(Sender: TObject);
begin
  if (Assigned(MQTT)) then
    begin
      MQTT.Disconnect;
      mStatus.Lines.Add('Disconnected');
      FreeAndNil(MQTT);
    end;
end;

procedure TfMain.btnPingClick(Sender: TObject);
begin
  if (Assigned(MQTT)) then
    begin
      mStatus.Lines.Add('Ping');
      MQTT.PingReq;
    end;
end;

procedure TfMain.btnPublishClick(Sender: TObject);
begin
  if (Assigned(MQTT)) then
    begin
      MQTT.Publish(eTopic.Text, eMessage.Text);
      mStatus.Lines.Add('Published');
    end;
end;

procedure TfMain.btnSubscribeClick(Sender: TObject);
begin
  if (Assigned(MQTT)) then
    begin
      MQTT.Subscribe(eSubTopic.Text, 0);
      mStatus.Lines.Add('Subscribe');
    end;
end;

procedure TfMain.GotConnAck(Sender: TObject; ReturnCode: integer);
begin
  mStatus.Lines.Add('Connection Acknowledged: ' + IntToStr(ReturnCode));
end;

procedure TfMain.GotPingResp(Sender: TObject);
begin
  mStatus.Lines.Add('PONG!');
end;

procedure TfMain.GotPub(Sender: TObject; topic, payload: Ansistring);
begin
  mStatus.Lines.Add('Message Recieved on ' + topic + ' payload: ' + payload);
end;

procedure TfMain.GotPubAck(Sender: TObject; MessageID: integer);
begin
  mStatus.Lines.Add('Got PubAck ' + IntToStr(MessageID));
end;

procedure TfMain.GotPubComp(Sender: TObject; MessageID: integer);
begin
  mStatus.Lines.Add('Got PubComp ' + IntToStr(MessageID));
end;

procedure TfMain.GotPubRec(Sender: TObject; MessageID: integer);
begin
  mStatus.Lines.Add('Got PubRec ' + IntToStr(MessageID));
end;

procedure TfMain.GotPubRel(Sender: TObject; MessageID: integer);
begin
  mStatus.Lines.Add('Got PubRel ' + IntToStr(MessageID));
end;

procedure TfMain.GotSubAck(Sender: TObject; MessageID: integer;
  GrantedQoS: array of integer);
begin
  mStatus.Lines.Add('Got SubAck ' + IntToStr(MessageID));
end;

procedure TfMain.GotUnSubAck(Sender: TObject; MessageID: integer);
begin
  mStatus.Lines.Add('Got UnSubAck ' + IntToStr(MessageID));
end;

end.
