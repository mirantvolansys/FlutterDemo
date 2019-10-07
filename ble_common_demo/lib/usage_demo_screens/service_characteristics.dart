import 'package:flutter/material.dart';
import 'package:ble_common_demo/ble_manager/ble_manager.dart';
import 'package:ble_common_demo/usage_demo_screens/characteristic_detail.dart';

class ServiceCharacteristics extends StatefulWidget {

  final BluetoothService service;
  const ServiceCharacteristics({Key key, this.service}) : super(key : key);

  @override
  _ServiceCharacteristicsState createState() => _ServiceCharacteristicsState();

}

class _ServiceCharacteristicsState extends State<ServiceCharacteristics> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Device Characteristics"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _buildCharacteristicTiles(widget.service.characteristics),
        ),
      ),
    );
  }

  List<Widget> _buildCharacteristicTiles(List<BluetoothCharacteristic> characteristics) {
    return characteristics
        .map(
            (c) => CharacteristicTile(
          service: widget.service,
          characteristic: c,
        )
    ).toList();
  }
}

class CharacteristicTile extends StatelessWidget {

  final BluetoothService service;
  final BluetoothCharacteristic characteristic;

  const CharacteristicTile({
    Key key,
    this.service,
    this.characteristic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Characteristic'),
      subtitle:
      Text('0x${characteristic.uuid.toString().toUpperCase().substring(4, 8)}'),
      trailing: Icon(
        Icons.navigate_next,
      ),
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) =>
                  CharacteristicDetail(characteristic : characteristic))),
    );
  }

}