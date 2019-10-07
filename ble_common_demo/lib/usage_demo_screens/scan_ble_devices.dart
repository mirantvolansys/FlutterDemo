import 'package:flutter/material.dart';
import 'package:ble_common_demo/ble_manager/ble_manager.dart';
import 'package:ble_common_demo/usage_demo_screens/device_connect_disconnect.dart';

class ScanDevicesScreen extends StatefulWidget {
  @override
  _ScanDevicesScreenState createState() => _ScanDevicesScreenState();
}

class _ScanDevicesScreenState extends State<ScanDevicesScreen> {

  List<ScanResult> scanResultList = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BLEManager.instance.scanDeviceList(durationInSec: 5).listen((data) {
      if(mounted) { /// While Widget is Exists and Not Disposed
        setState(() {
          final List<ScanResult> deviceList = data;
          scanResultList = deviceList;
          print("deviceList.length = ${deviceList.length}");
        });
      }
    });

    BLEManager.instance.isScanning().listen((data) {
      print("isScanningGoingOn = $data");
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find BLE Devices'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: scanResultList.map((scanResult) {
            return ScanResultTile(
              result: scanResult,
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return DeviceConnectDisconnect(device: scanResult.device);
                  })
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ScanResultTile extends StatelessWidget {

  const ScanResultTile({Key key, this.result, this.onTap}) : super(key: key);
  final ScanResult result;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: _buildTitle(context),
      leading: Text(result.rssi.toString()),
      trailing: RaisedButton(
        child: Text('CONNECT'),
        color: Colors.black,
        textColor: Colors.white,
        onPressed: (result.advertisementData.connectable) ? onTap : null,
      ),
      children: <Widget>[
        _buildAdvRow(context, 'Complete Local Name',
            result.advertisementData.localName
        ),
        _buildAdvRow(context, 'Tx Power Level',
            '${result.advertisementData.txPowerLevel ?? 'N/A'}'
        ),
        _buildAdvRow(
            context,
            'Manufacturer Data',
            getNiceManufacturerData(
                    result.advertisementData.manufacturerData) ??
                'N/A'),
        _buildAdvRow(
            context,
            'Service UUIDs',
            (result.advertisementData.serviceUuids.isNotEmpty)
                ? result.advertisementData.serviceUuids.join(', ').toUpperCase()
                : 'N/A'),
        _buildAdvRow(context, 'Service Data',
            getNiceServiceData(result.advertisementData.serviceData) ?? 'N/A'),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    if (result.device.name.length > 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            result.device.name,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            result.device.id.toString(),
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
    } else {
      return Text(result.device.id.toString());
    }
  }

  Widget _buildAdvRow(BuildContext context, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.caption),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .apply(color: Colors.black),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  String getNiceHexArray(List<int> bytes) {
    print("getNiceHexArray = $bytes");
    return '[${bytes.map((i) => i.toRadixString(16).padLeft(2, '0')).join(', ')}]'
        .toUpperCase();
  }

  String getNiceManufacturerData(Map<int, List<int>> data) {
    print("getNiceManufacturerData = $data");
    if (data.isEmpty) {
      return null;
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add('${id.toRadixString(16).toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

  String getNiceServiceData(Map<String, List<int>> data) {
    print("getNiceServiceData = $data");
    if (data.isEmpty) {
      return null;
    }
    List<String> res = [];
    data.forEach((id, bytes) {
      res.add('${id.toUpperCase()}: ${getNiceHexArray(bytes)}');
    });
    return res.join(', ');
  }

}

/*class ScanDevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    BLEManager.instance.isScanning().listen((data) {
      print("isScanningGoingOn = $data");
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Find BLE Devices'),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<ScanResult>>(
          stream: FlutterBlue.instance.scanResults,
          initialData: [],
          builder: ((c, snapshot) {
            print(" Lenght = ${snapshot.data.length}");
            return Column(
              children: snapshot.data
                  .map(
                    (r) => ScanResultTile(
                  result: r,
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        //r.device.connect();
                        return DeviceConnectDisconnect(device: r.device);
                      })),
                ),
              )
                  .toList(),
            );
          }),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => FlutterBlue.instance.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () => FlutterBlue.instance
                    .startScan(timeout: Duration(seconds: 10)));
          }
        },
      ),
    );
  }
}*/