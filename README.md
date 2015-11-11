# TMQTT 2 (ALPHA) for Delphi by Jamie I

## Introduction

**WARNING: This is still considered ALPHA quality, and is NOT considered ready for *any real* use yet. All contributions and bug fix pull requests are appreciated.**


TMQTT is a non-visual Delphi Client Library for the IBM Websphere MQ Transport Telemetry protocol ( http://mqtt.org ). It allows you to connect to a Message Broker that uses MQTT such as the [Really Small Message Broker](http://alphaworks.ibm.com/tech/rsmb) which is freely available for evaluation purposes on IBM Alphaworks. Mosquitto is an open source MQTT 3.1 broker ( http://mosquitto.org/ ).

TMQTT is a complete re-write of the original TMQTTClient that I wrote and it is sufficiently different enough to release in parallel.

MQTT is an IoT protocol, further information can be found here: http://mqtt.org/
 

## Points of Note
* There may be a few bugs.
* It is not currently FPC compatible [Planned]
* There are some improvements related to socket error handling which I have yet to make inspired by ZiCog's contributions to the original TMQTTClient.
Note: You should be aware that it uses part of the Synapse Internet Communications Library for its Socket support so you’ll need to ensure that this is available on your search path.


## Usage
There is a sample VCL project included in the download but usage is relatively simple. This is a non-visual component so all you need to do is to put the TMQTT directory into your compiler paths and then put MQTT in your uses.

```delphi
uses MQTT;
var
	MQTTClient: TMQTT;
begin
  MQTT := TMQTT.Create('localhost', 1883);
  try
    // Events
    MQTT.OnConnAck := GotConnAck;
    MQTT.OnPublish := GotPub;
    MQTT.OnPingResp := GotPingResp;
    MQTT.OnSubAck := GotSubAck;
    MQTT.OnUnSubAck := GotUnSubAck;
    MQTT.OnPubAck := GotPubAck;

    if MQTT.Connect then
    begin
      WriteLn('Connected!');
      MQTT.Subscribe('/dev/test', 0);
      MQTT.Publish('/dev/test', 'This is a test message');
    end
    else
      WriteLn('Failed to connect');
  finally
    MQTT.Free;
  end;
end;

procedure GotPub(Sender: TObject; topic, payload: Ansistring);
begin
 WriteLn('Message Recieved on ' + topic + ' payload: ' + payload);
end;
```

Special thanks for this re-write got to [ZiCog](https://github.com/ZiCog) for his help and improvements to the TMQTTClient library, which helped enormously.

If you are using my TMQTT then I would to love hear about how you’re using it, if you do appreciate it, please let me know!
