import 'dart:async';
import 'dart:core';
import 'package:flutter/foundation.dart';

export 'ble_manager_utils.dart';

import 'package:flutter_blue/flutter_blue.dart';
export 'package:flutter_blue/flutter_blue.dart';

class BLEManager {

  /// BLEManager create singleton pattern and initialise an instance
  static final BLEManager _singleton = new BLEManager._internal();

  static BLEManager get instance => _singleton;

  factory BLEManager() {
    /// BLEManager Initiated
    return _singleton;
  }

  BLEManager._internal() {
    /// BLEManager._internal build logic
  }

  /// Checks if Bluetooth functionality is turned on
  Future<bool> isBLEOn() async {
    return FlutterBlue.instance.isOn;
  }

  /// Gets the current state of the Bluetooth module
  Stream<BluetoothState> checkBLEState() {
    return FlutterBlue.instance.state;
  }

  /// Starts a scan for Bluetooth Low Energy devices
  /// Timeout closes the stream after a specified [Duration]
  /// [ScanResult] is combination of [BluetoothDevice, AdvertisementData, rssi]
  ///
  Stream<List<ScanResult>> scanDeviceList(
      {ScanMode scanMode = ScanMode.lowLatency,
      List<Guid> withServices = const [],
      List<Guid> withDevices = const [],
      int durationInSec}) {
    FlutterBlue.instance.startScan(
        withServices: withServices,
        withDevices: withDevices,
        timeout: Duration(seconds: durationInSec));
    return FlutterBlue.instance.scanResults;
  }

  /// Check status weather Bluetooth Device scanning is in-progress
  Stream<bool> isScanning() {
    return FlutterBlue.instance.isScanning;
  }

  /// Stops a scan for Bluetooth Low Energy devices
  Future stopScan() async {
    return FlutterBlue.instance.stopScan();
  }

  /// The current connection state of the device
  Stream<BluetoothDeviceState> bleDeviceState(
      {@required BluetoothDevice bleDevice}) {
    return bleDevice.state;
  }

  /// Establishes a connection to the Bluetooth Device.
  Future<void> connectDevice({
    BluetoothDevice bleDevice,
    Duration timeout,
    bool autoConnect = true,
  }) async {
    bleDevice.connect(timeout: timeout, autoConnect: autoConnect);
  }

  /// Cancels connection to the Bluetooth Device
  Future disconnectDevice({BluetoothDevice bleDevice}) async {
    bleDevice.disconnect();
  }

  /// Get connected Bluetooth Device List
  Stream<List<BluetoothDevice>> connectedBLEDevices() {
    return Stream.fromFuture(FlutterBlue.instance.connectedDevices);
  }

  /// Returns a list of Bluetooth GATT services offered by the remote device
  /// This function requires that discoverServices has been completed for this device
  Stream<List<BluetoothService>> deviceServices(
      {@required BluetoothDevice bleDevice}) {
    bleDevice.discoverServices();
    return bleDevice.services;
  }

  /// Retrieves the value of the characteristic => OnCharacteristicChanged
  /// Retrieves the value of the characteristic => OnCharacteristicRead
  /// Retrieves the value of the characteristic => Sets notifications true for specified characteristic
  Stream<List<int>> characteristicValue(
      {@required BluetoothCharacteristic characteristic}) {
    return characteristic.value;
  }

  /// Retrieves the value of the characteristic
  Future<List<int>> read(
      {@required BluetoothCharacteristic characteristic}) async {
    return characteristic.read();
  }

  /// Writes the value of a characteristic.
  /// [CharacteristicWriteType.withoutResponse]: the write is not
  /// guaranteed and will return immediately with success.
  /// [CharacteristicWriteType.withResponse]: the method will return after the
  /// write operation has either passed or failed.
  Future<Null> write(
      {@required BluetoothCharacteristic characteristic,
      @required List<int> value,
      bool withoutResponse = false}) async {
    return characteristic.write(value, withoutResponse: withoutResponse);
  }

  /// Sets notifications or indications for the value of a specified characteristic
  Future<bool> setNotifyValue(
      {@required BluetoothCharacteristic characteristic,
      @required bool notify}) async {
    return characteristic.setNotifyValue(notify);
  }


}
