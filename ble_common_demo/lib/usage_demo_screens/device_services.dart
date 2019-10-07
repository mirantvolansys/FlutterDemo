import 'package:flutter/material.dart';
import 'package:ble_common_demo/ble_manager/ble_manager.dart';
import 'package:ble_common_demo/usage_demo_screens/service_characteristics.dart';

class DeviceServices extends StatefulWidget {
  final BluetoothDevice device;
  const DeviceServices({Key key, this.device}) : super(key: key);
  @override
  _DeviceServicesState createState() => _DeviceServicesState();
}

class _DeviceServicesState extends State<DeviceServices> {

  List<BluetoothService> servicesList = List();

  @override
  void initState() {
    super.initState();

    BLEManager.instance.deviceServices(bleDevice: widget.device).listen((data) {
      if(mounted) {
        setState(() {
          servicesList = data;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Device Services"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _buildServiceTiles(servicesList),
        ),
      ),
    );
  }

  List<Widget> _buildServiceTiles(List<BluetoothService> services) {
    return services
        .map(
          (s) => ServiceTile(
                    service: s,
                  ),
        ).toList();
  }

}

class ServiceTile extends StatelessWidget {

  const ServiceTile({Key key, this.service}) : super(key: key);
  final BluetoothService service;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Service'),
      subtitle:
      Text('0x${service.uuid.toString().toUpperCase().substring(4, 8)}'),
      trailing: Icon(
        Icons.navigate_next,
      ),
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) =>
                  ServiceCharacteristics(service: service))),
    );
  }
}

/*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Device Services"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<BluetoothService>>(
          stream: widget.device.services,
          initialData: [],
          builder: (c, snapshot) {
            return Column(
              children: _buildServiceTiles(snapshot.data),
            );
          },
        ),
      ),
    );
  }*/

