import 'package:ble_common_demo/usage_demo_screens/check_ble_connection.dart';
import 'package:ble_common_demo/usage_demo_screens/connected_devices.dart';
import 'package:ble_common_demo/usage_demo_screens/scan_ble_devices.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Builder(
          builder: (context) =>
              Container(
                  child: ListView(
                    padding: EdgeInsets.all(16.0),
                    children: <Widget>[
                      CustomRaisedButton(
                          title: "Check BLE Connection",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CheckBLEConnection()));
                          }),
                      CustomRaisedButton(
                        title: "Scan Devices",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ScanDevicesScreen()));
                        },
                      ),
                      CustomRaisedButton(
                        title: "Connected Devices",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ConnectedDevices()));
                        },
                      ),
                    ],
                  ))),
      backgroundColor: Colors.grey,
    );
  }
}

class CustomRaisedButton extends StatelessWidget {

  final String title;
  final GestureTapCallback onPressed;

  CustomRaisedButton({@required this.title, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title),
          Icon(Icons.navigate_next),
        ],
      ),
    );
  }

}
