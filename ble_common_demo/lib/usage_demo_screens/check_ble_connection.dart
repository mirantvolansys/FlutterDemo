import 'package:flutter/material.dart';
import 'package:ble_common_demo/ble_manager/ble_manager.dart';

class CheckBLEConnection extends StatefulWidget {
  @override
  _CheckBLEConnectionState createState() => _CheckBLEConnectionState();
}

class _CheckBLEConnectionState extends State<CheckBLEConnection> {

  BluetoothState _bluetoothState = BluetoothState.unknown;

  @override
  void initState() {
    super.initState();

    //Temperature Simple threshold [upper limit]
    final charUpdatedValueList = BLEManagerUtils.setCharacteristicValue(updateValue: 2145483647, atIndex: 9, currentValueList: [0,1,2,3], format: Format.SInt32, bytesOrder: BytesOrder.LH);


    BLEManager.instance.checkBLEState().listen((data) {
      if (mounted) { /// While Widget is Exists and Not Disposed
        setState(() {
          _bluetoothState = data;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Check BLE Connection"),
        ),
        body: BluetoothOnOffScreen(state: _bluetoothState),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class BluetoothOnOffScreen extends StatelessWidget {

  const BluetoothOnOffScreen({Key key, this.state}) : super(key: key);

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: state == BluetoothState.on ? Colors.green : Colors.red,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              state == BluetoothState.on ? Icons.bluetooth_connected : Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            Text(
              'Bluetooth Adapter is ${state.toString().substring(15)}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .subhead
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

/*class CheckBLEConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check BLE Connection"),
      ),
      body: StreamBuilder<BluetoothState> (
        stream: FlutterBlue.instance.state,
        initialData: BluetoothState.unknown,
        builder: (c, snapshot) {
          final state = snapshot.data;
          return BluetoothOnOffScreen(state: state);
        }
      )
    );
  }
}*/