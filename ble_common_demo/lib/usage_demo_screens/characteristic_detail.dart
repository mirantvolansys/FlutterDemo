import 'package:ble_common_demo/ble_manager/ble_manager.dart';
import 'package:ble_common_demo/usage_demo_screens/utilis_and_constant.dart';
import 'package:flutter/material.dart';

class CharacteristicDetail extends StatefulWidget {
  final BluetoothCharacteristic characteristic;
  const CharacteristicDetail({this.characteristic, Key key}) : super(key: key);
  @override
  _CharacteristicDetailState createState() => _CharacteristicDetailState();
}

class _CharacteristicDetailState extends State<CharacteristicDetail> {

  bool isNotify = false;
  String charUDID = "";
  List<int> charValueList = List();
  String detailDescription = "";

  @override
  void initState() {
    super.initState();

    charUDID =
    '0x${widget.characteristic.uuid.toString().toUpperCase().substring(4, 8)}';

    setState(() {
      isNotify = widget.characteristic.isNotifying;
    });

    fetchValueOnChange();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Device Characteristics"),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            'Characteristic',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                              '0x${widget.characteristic.uuid.toString()
                                  .toUpperCase()
                                  .substring(4, 8)}',
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Read"),
                          textColor: Colors.white,
                          color: Colors.blue,
                          onPressed: read,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Write"),
                          textColor: Colors.white,
                          color: Colors.green,
                          onPressed: write,
                        ),
                        RaisedButton(
                          padding: EdgeInsets.all(8.0),
                          child:
                          isNotify ? Text("Remove Notify") : Text("Set Notify"),
                          textColor: Colors.white,
                          color: Colors.red,
                          onPressed: setNotify,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "${charValueList.toString()} \n $detailDescription",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          )),
    );
  }

  //Listener for auto fire based on characteristic notify, read
  void fetchValueOnChange() {
    BLEManager.instance
        .characteristicValue(characteristic: widget.characteristic)
        .listen((value) {
      print(" fetchValueOnChange value: $value");
    });
  }

  /// Reads Characteristic
  void read() {
    BLEManager.instance
        .read(characteristic: widget.characteristic)
        .then((value) {
      print("read value: $value");
      if (mounted) {
        setState(() {
          charValueList = value;
          detailDescription = prepareDetailDescription(charUDID, charValueList);
        });
      }
    });
  }

  /// Write Characteristic
  void write() {
    if (charUDID == Constants.CHAR_SET_TEMPERATURE_UUID) {

      /// You must have current characteristics All values array first
      if(charValueList.length == 0) {
        Utils.showAlert(context, "BLE Characteristic",
            "Current Value Array Empty. Please get curretn value by read characteristic.");
        return;
      }

      //Event Enable/Disable 0/1
      var charUpdatedValueList = BLEManagerUtils.setCharacteristicValue(updateValue: 0, atIndex: 0, currentValueList: charValueList, format: Format.UInt8, bytesOrder: BytesOrder.LH);

      //Temperature Simple threshold [upper limit]
    charUpdatedValueList = BLEManagerUtils.setCharacteristicValue(updateValue: 4800, atIndex: 9, currentValueList: charValueList, format: Format.SInt16, bytesOrder: BytesOrder.LH);

      //Temperature Simple threshold [lower limit]
      charUpdatedValueList = BLEManagerUtils.setCharacteristicValue(updateValue: -600, atIndex: 11, currentValueList: charValueList, format: Format.SInt16, bytesOrder: BytesOrder.LH);

      print("charUpdatedValueList = $charUpdatedValueList");

      BLEManager.instance
          .write(
          characteristic: widget.characteristic,
          value: charUpdatedValueList,
          withoutResponse: false)
          .then((value) {
        print("write value return block: $value");
      });
    }

  }

  /// Set Notify Characteristic
  void setNotify() {
    BLEManager.instance
        .setNotifyValue(
        characteristic: widget.characteristic,
        notify: isNotify ? false : true)
        .then((value) {
      if (mounted) {
        setState(() {
          isNotify = !isNotify;
        });
      }
    });
  }

  /// It's just for demonstration purpose
  /// Currently It's based on OMRON Environment sensor device
  /// It's Different based on device
  /// For the same follow BLE Device guidelines document
  String prepareDetailDescription(String characteristicUUID,
      List<int> arrDecimalChara) {
    
    var charDescription = "";
    if (characteristicUUID == Constants.CHAR_LATEST_DATA_UUID ||
        characteristicUUID == Constants.CHAR_LATEST_RESPONSE_UUID) {
      if (arrDecimalChara.length == 19) {
        charDescription = characteristicMapping(arrDecimalChara);
      }
    }

    if (characteristicUUID == Constants.CHAR_SET_TEMPERATURE_UUID) {
      if (arrDecimalChara.length == 15) {
        charDescription = temperatureSettingCharaMapping(arrDecimalChara);
      }
    }

    return charDescription;
  }

  ///BLE Device Characteristics Conversion process in respective Bytes slots to value types
  ///Unit conversion with default to display in appropriate value types
  String characteristicMapping(List<int> arrBytes) {

    final rowValue1 = BLEManagerUtils.getCharacteristicValue(atIndex: 0, valueList: arrBytes, format: Format.UInt8, bytesOrder: BytesOrder.LH);
    print("rowValue1 = ${rowValue1 * 1}");

    //"TEMPERATURE"
    final tmpValue = BLEManagerUtils.getCharacteristicValue(atIndex: 1, valueList: arrBytes, format: Format.SInt16, bytesOrder: BytesOrder.LH);
    final temperature = tmpValue * 0.01;
    print("Temperature = $temperature degC");

    //"Relative Humidity"
    final rhValue = BLEManagerUtils.getCharacteristicValue(atIndex: 3, valueList: arrBytes, format: Format.SInt16, bytesOrder: BytesOrder.LH);
    final relativeHumidity = rhValue * 0.01;
    print("Relative Humidity = $relativeHumidity %RH");

    //"Light"
    final lightValue = BLEManagerUtils.getCharacteristicValue(atIndex: 5, valueList: arrBytes, format: Format.SInt16, bytesOrder: BytesOrder.LH);
    final light = lightValue * 1;
    print("Light = $light lx");

    //"UV Index"
    final uviValue = BLEManagerUtils.getCharacteristicValue(atIndex: 7, valueList: arrBytes, format: Format.SInt16, bytesOrder: BytesOrder.LH);
    final uvIndex = uviValue * 0.01;
    print("UV Index = $uvIndex");

    //"Barometric Pressure"
    final bpValue = BLEManagerUtils.getCharacteristicValue(atIndex: 9, valueList: arrBytes, format: Format.SInt16, bytesOrder: BytesOrder.LH);
    final barometricPressure = bpValue * 0.1;
    print("Barometric Pressure = $barometricPressure hPa");

    //"Sound noise"
    final snValue = BLEManagerUtils.getCharacteristicValue(atIndex: 11, valueList: arrBytes, format: Format.SInt16, bytesOrder: BytesOrder.LH);
    final soundNoise = snValue * 0.01;
    print("Sound noise = $soundNoise dB");

    //"Discomfort Index *2"
    final dfValue = BLEManagerUtils.getCharacteristicValue(atIndex: 13, valueList: arrBytes, format: Format.SInt16, bytesOrder: BytesOrder.LH);
    final discomfortIndex2 = dfValue * 0.01;
    print("Discomfort Index *2 = $discomfortIndex2");

    //"Heatstroke risk factor *2"
    final hRf2Value = BLEManagerUtils.getCharacteristicValue(atIndex: 15, valueList: arrBytes, format: Format.SInt16, bytesOrder: BytesOrder.LH);
    final heatstrokeRiskFactor2 = hRf2Value * 0.01;
    print("Heatstroke risk factor *2 = $heatstrokeRiskFactor2 degC");

    //"Supply voltage"
    final svValue = BLEManagerUtils.getCharacteristicValue(atIndex: 17, valueList: arrBytes, format: Format.SInt16, bytesOrder: BytesOrder.LH);
    final supplyVoltage = svValue * 1;
    print("Supply voltage = $supplyVoltage mV");

    // String combine for display in UI
    final allCharacteristicWithValues = "\nTemperature = $temperature degC\n\n"
        "Relative Humidity = $relativeHumidity %RH\n\n"
        "Light = $light lx\n\n"
        "UV Index = $uvIndex\n\n"
        "Barometric Pressure = $barometricPressure hPa\n\n"
        "Sound noise = $soundNoise dB\n\n"
        "Discomfort Index *2 = $discomfortIndex2\n\n"
        "Heatstroke risk factor *2 = $heatstrokeRiskFactor2 degC\n\n"
        "Supply voltage = $supplyVoltage mV\n\n";
    print("allCharacteristicWithValues = $allCharacteristicWithValues");
    return allCharacteristicWithValues;
  }

  /// Sample Set Characteristic Values demonstration after updated one
  String temperatureSettingCharaMapping(List<int> arrBytes) {

    //"TEMPERATURE Simple threshold [upper]
    final tmpUpperValue = BLEManagerUtils.getCharacteristicValue(atIndex: 9, valueList: arrBytes, format: Format.SInt16, bytesOrder: BytesOrder.LH);
    final temperatureUpper = tmpUpperValue * 0.01;
    print("TEMPERATURE Simple threshold [upper] = $temperatureUpper degC");

    //"TEMPERATURE Simple threshold [lower]"
    final tmpLowerValue =BLEManagerUtils.getCharacteristicValue(atIndex: 11, valueList: arrBytes, format: Format.SInt16, bytesOrder: BytesOrder.LH);
    final temperatureLower = tmpLowerValue * 0.01;
    print("TEMPERATURE Simple threshold [lower] = $temperatureLower degC");

    //Combine String for display
    final allCharacteristicWithValues =
        "\nTEMPERATURE Simple threshold [upper] = $temperatureUpper degC\n\n"
        "TEMPERATURE Simple threshold [lower] = $temperatureLower degC\n\n";

    print("allCharacteristicWithValues = $allCharacteristicWithValues");
    return allCharacteristicWithValues;
  }

}
