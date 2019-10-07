import 'package:flutter/material.dart';
import 'package:ble_common_demo/ble_manager/ble_manager.dart';
import 'package:ble_common_demo/usage_demo_screens/device_services.dart';

class ConnectedDevices extends StatefulWidget {
  @override
  _ConnectedDevicesState createState() => _ConnectedDevicesState();
}

class _ConnectedDevicesState extends State<ConnectedDevices> {

  List<BluetoothDevice> deviceList = List();

  @override
  void initState() {
    super.initState();

    BLEManager.instance.connectedBLEDevices().listen((data) {
      if(mounted) {
        setState(() {
          deviceList = data;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connected Devices"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: deviceList.map((d) {
            return ListTile(
              title: Text(d.name),
              subtitle: Text(d.id.toString()),
              trailing: RaisedButton(
                child: Text('OPEN'),
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) => DeviceServices(device: d)
                    )
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}


/*class ConnectedDevices1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connected Devices"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<BluetoothDevice>>(
          stream: Stream.fromFuture(FlutterBlue.instance.connectedDevices),
          initialData: [],
          builder: (c, snapshot) => Column(
            children: snapshot.data
                .map((d) => ListTile(
                      title: Text(d.name),
                      subtitle: Text(d.id.toString()),
                      trailing: StreamBuilder<BluetoothDeviceState>(
                        stream: d.state,
                        initialData: BluetoothDeviceState.disconnected,
                        builder: (c, snapshot) {
                          if (snapshot.data == BluetoothDeviceState.connected) {
                            return RaisedButton(
                              child: Text('OPEN'),
                              onPressed: () =>
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DeviceServices(device: d))),
                            );
                          }
                          return Text(snapshot.data.toString());
                        },
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}*/
