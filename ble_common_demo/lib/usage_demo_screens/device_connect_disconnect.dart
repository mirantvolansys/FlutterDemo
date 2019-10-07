import 'package:flutter/material.dart';
import 'package:ble_common_demo/ble_manager/ble_manager.dart';

class DeviceConnectDisconnect extends StatefulWidget {
  const DeviceConnectDisconnect({Key key, this.device}) : super(key: key);
  final BluetoothDevice device;
  @override
  _DeviceConnectDisconnectState createState() => _DeviceConnectDisconnectState();
}

class _DeviceConnectDisconnectState extends State<DeviceConnectDisconnect> {

  BluetoothDeviceState bleDeviceState = BluetoothDeviceState.disconnected;

  @override
  void initState() {
    super.initState();

    BLEManager.instance.bleDeviceState(bleDevice: widget.device).listen((data) {
      if(mounted) {
        setState(() {
          bleDeviceState = data;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name),
        actions: <Widget>[
          actionButton(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            listTile(),
          ],
        ),
      ),
    );
  }

  Widget actionButton() {
    VoidCallback onPressed;
    String text;
    switch (bleDeviceState) {
      case BluetoothDeviceState.connected:
        onPressed = () => BLEManager.instance.disconnectDevice(bleDevice: widget.device);
        text = 'DISCONNECT';
        break;
      case BluetoothDeviceState.disconnected:
        onPressed = () => BLEManager.instance.connectDevice(bleDevice: widget.device);
        text = 'CONNECT';
        break;
      default:
        onPressed = null;
        text = bleDeviceState.toString().substring(21).toUpperCase();
        break;
    }
    return FlatButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context)
              .primaryTextTheme
              .button
              .copyWith(color: Colors.white),
        ));
  }

  Widget listTile() {
    return ListTile(
      leading: (bleDeviceState == BluetoothDeviceState.connected)
          ? Icon(Icons.bluetooth_connected)
          : Icon(Icons.bluetooth_disabled),
      title: Text(
          'Device is ${bleDeviceState.toString().split('.')[1]}.'),
      subtitle: Text('${widget.device.id}'),
    );
  }
}


/*class DeviceConnectDisconnect extends StatelessWidget {

  const DeviceConnectDisconnect({Key key, this.device}) : super(key: key);
  final BluetoothDevice device;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => device.disconnect();
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => device.connect();
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return FlatButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .button
                        .copyWith(color: Colors.white),
                  ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? Icon(Icons.bluetooth_connected)
                    : Icon(Icons.bluetooth_disabled),
                title: Text(
                    'Device is ${snapshot.data.toString().split('.')[1]}.'),
                subtitle: Text('${device.id}'),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
*/