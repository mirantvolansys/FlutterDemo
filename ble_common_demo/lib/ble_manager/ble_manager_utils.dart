import 'dart:core';
import 'package:flutter/foundation.dart';

//BytesOrder
enum BytesOrder {
  LH, //low byte to high byte // Descending //Little Endian
  HL  //high byte to low byte //Ascending //Big Endian //left-to-right
}

//BLE Characteristics ValueFormat
enum Format {
  SInt8,
  UInt8,
  SInt16,
  UInt16,
  SInt32,
  UInt32
}

class BLEManagerUtils {

  /**
   * These are used when a data type uses more than one byte.
   * The low byte is the byte that holds the least significant part of an integer.
   * If you think in terms of writing a bit pattern on paper, the low byte is the rightmost eight bits.
   * A short holds a 16-bit pattern such as:
      01001010 00001111
      The low order byte is 00001111
   * the bytes are written from high byte to low byte (or from left to right in the above pattern).
   */

  /**
   * BLE Characteristics Array Received in Bytes format
   * Also It's can divide on partition of Bytes in Array index
   * So here represent conversion logic for Bytes to respective decimal values
   * It's prepared based on BLE device (For Demo)
   * You can change accordingly your BLE device Characteristics value logic
   */

  /// Bytes to Binary String Conversion
  /// Bytes Array Order Must be High to Low
  static String bytesToBinary(List<int> bytesList) {
    var completeBinary = "";
    for(final byte in bytesList) {
      final binary = byte.toRadixString(2).padLeft(8, '0');
      completeBinary = completeBinary + binary;
    }
    return completeBinary;
  }

  /// Real Time Data Format Characteristic Value Conversion with Format
  /// [atIndex] Specific Value Starting Byte Index
  /// [valueList] Array Characteristic values
  /// [format] Defined format for store value
  /// [bytesOrder] High to Low or Low to High
  ///
  static int getCharacteristicValue({@required int atIndex, @required List<int> valueList,
    @required Format format, @required BytesOrder bytesOrder}) {
    switch (format) {
      case Format.SInt8:
        ///Contains one byte
        final byte = valueList[atIndex];
        final completeBinary = bytesToBinary([byte]);
        return int.parse(completeBinary, radix: 2).toSigned(8);
        break;
        ///
      case Format.UInt8:
        ///Contains one byte
        final byte = valueList[atIndex];
        final completeBinary = bytesToBinary([byte]);
        return int.parse(completeBinary, radix: 2).toUnsigned(8);
        break;
        ///
      case Format.SInt16:
        ///Contains two bytes
        var bytes = [valueList[atIndex], valueList[atIndex+1]];
        if(bytesOrder == BytesOrder.LH) { //Descending
          bytes = bytes.reversed.toList();
        }
        final completeBinary = bytesToBinary(bytes);
        return int.parse(completeBinary, radix: 2).toSigned(16);
        break;
        ///
      case Format.UInt16:
        ///Contains two bytes
        var bytes = [valueList[atIndex], valueList[atIndex+1]];
        if(bytesOrder == BytesOrder.LH) { //Descending
          bytes = bytes.reversed.toList();
        }
        final completeBinary = bytesToBinary(bytes);
        return int.parse(completeBinary, radix: 2).toUnsigned(16);
        break;
        ///
      case Format.SInt32:
        ///Contains four bytes
        var bytes = [valueList[atIndex], valueList[atIndex+1], valueList[atIndex+2], valueList[atIndex+3]];
        if(bytesOrder == BytesOrder.LH) { //Descending
          bytes = bytes.reversed.toList();
        }
        final completeBinary = bytesToBinary(bytes);
        return int.parse(completeBinary, radix: 2).toSigned(32);
        break;
        ///
      case Format.UInt32:
        ///Contains four bytes
        var bytes = [valueList[atIndex], valueList[atIndex+1], valueList[atIndex+2], valueList[atIndex+3]];
        if(bytesOrder == BytesOrder.LH) { //Descending
          bytes = bytes.reversed.toList();
        }
        final completeBinary = bytesToBinary(bytes);
        return int.parse(completeBinary, radix: 2).toUnsigned(32);
        break;
        ///
    }
    return null;
  }

  /// Real Time Data to Bytes Format Characteristic Value Conversion
  /// [updateValue] Updated Decimal value for Specific Index
  /// [atIndex] Specific Value Starting Byte Index
  /// [currentValueList] Array current Characteristic values
  /// [format] Defined format for store value
  /// [bytesOrder] High to Low or Low to High
  ///
  static List<int> setCharacteristicValue({int updateValue, @required int atIndex,
    List<int> currentValueList, @required Format format, @required BytesOrder bytesOrder}) {
    List<int> updatedValueList = currentValueList;
    switch (format) {
      case Format.SInt8:
        ///Contains one byte
        final byteValue = updateValue & 0xff;
        updatedValueList[atIndex] = byteValue;
        break;
        ///
      case Format.UInt8:
        ///Contains one byte
        final byteValue = updateValue & 0xff;
        updatedValueList[atIndex] = byteValue;
        break;
        ///
        break;
      case Format.SInt16:
        ///Contains two byte
        final hByteValue  = (updateValue >> 8) & 0xff; ///MostSignificantByte
        final lByteValue = updateValue & 0xff; ///LeastSignificantByte
        if(bytesOrder == BytesOrder.LH) { //Descending
          updatedValueList[atIndex] = lByteValue;
          updatedValueList[atIndex + 1] = hByteValue;
        } else {
          updatedValueList[atIndex] = hByteValue;
          updatedValueList[atIndex + 1] = lByteValue;
        }
        ///
        break;
      case Format.UInt16:
        ///Contains two byte
        final hByteValue  = (updateValue >> 8) & 0xff; ///MostSignificantByte
        final lByteValue = updateValue & 0xff; ///LeastSignificantByte
        if(bytesOrder == BytesOrder.LH) { //Descending
          updatedValueList[atIndex] = lByteValue;
          updatedValueList[atIndex + 1] = hByteValue;
        } else {
          updatedValueList[atIndex] = hByteValue;
          updatedValueList[atIndex + 1] = lByteValue;
        }
        ///
        break;
      case Format.SInt32:
        ///Contains four byte
        final aByteValue  = (updateValue >> 24) & 0xff; ///MostSignificantByte // High
        final bByteValue = (updateValue >> 16) & 0xff;
        final cByteValue  = (updateValue >> 8) & 0xff;
        final dByteValue = updateValue & 0xff; ///LeastSignificantByte // Low
        if(bytesOrder == BytesOrder.LH) { //Descending
          updatedValueList[atIndex] = dByteValue;
          updatedValueList[atIndex + 1] = cByteValue;
          updatedValueList[atIndex + 2] = bByteValue;
          updatedValueList[atIndex + 3] = aByteValue;
        } else {
          updatedValueList[atIndex] = aByteValue;
          updatedValueList[atIndex + 1] = bByteValue;
          updatedValueList[atIndex + 2] = cByteValue;
          updatedValueList[atIndex + 3] = dByteValue;
        }
        ///
        break;
      case Format.UInt32:
      ///Contains four byte
        final aByteValue  = (updateValue >> 24) & 0xff; ///MostSignificantByte // High
        final bByteValue = (updateValue >> 16) & 0xff;
        final cByteValue  = (updateValue >> 8) & 0xff;
        final dByteValue = updateValue & 0xff; ///LeastSignificantByte // Low
        if(bytesOrder == BytesOrder.LH) { //Descending
          updatedValueList[atIndex] = dByteValue;
          updatedValueList[atIndex + 1] = cByteValue;
          updatedValueList[atIndex + 2] = bByteValue;
          updatedValueList[atIndex + 3] = aByteValue;
        } else {
          updatedValueList[atIndex] = aByteValue;
          updatedValueList[atIndex + 1] = bByteValue;
          updatedValueList[atIndex + 2] = cByteValue;
          updatedValueList[atIndex + 3] = dByteValue;
        }
        ///
        break;
    }
    return updatedValueList;
  }


}


/*
/// Decimal To Binary
  static List<int> decimalToSplitByteDecimal({@required int decimalValue}) {

    print("decimalValue = $decimalValue");

    /*var completeBinary = "";
    final binaryValue = decimalValue.toSigned(16).toRadixString(2).padLeft(16, '0');
    completeBinary = binaryValue;
    print("completeBinary = $completeBinary");

    final hByteBinary = completeBinary.substring(0, 8);
    final lByteBinary = completeBinary.substring(8, 16);
    print("hByteBinary = $hByteBinary");
    print("lByteBinary = $lByteBinary");

    final hByteValue = int.parse(hByteBinary, radix: 2);
    final lByteValue = int.parse(lByteBinary, radix: 2);
    print("hByteValue = $hByteValue");
    print("lByteValue = $lByteValue");*/

    //tempThresholdLowerValueMostSignificantByte
    final hByteValue  = (decimalValue >> 8) & 0xff;
    print("tempThresholdLowerValueMostSignificantByte = $hByteValue");

    //tempThresholdLowerValueLeastSignificantByte
    final lByteValue = decimalValue & 0xff;
    print("tempThresholdLowerValueLeastSignificantByte = $lByteValue");

    //For example, in the binary number 1000, the MSB is 1,
    //and in the binary number 0111, the MSB is 0.
    //and Bytes binary order is High to low lft to right

    return [lByteValue, hByteValue];
  }

  static List<int> setCharacteristicValue1({int updateValue, @required int atIndex,
    List<int> currentValueList, @required Format format, @required BytesOrder bytesOrder}) {
    print("currentValueList = $currentValueList");
    var updatedValueList = currentValueList;
    final updatedSplitByteDecimal = decimalToSplitByteDecimal(decimalValue: updateValue);
    updatedValueList[atIndex] = updatedSplitByteDecimal[0];
    updatedValueList[atIndex + 1] = updatedSplitByteDecimal[1];
    print("updatedValueList = $updatedValueList");
    return updatedValueList;
  }
 */


/*
/// Byte to binary conversion
  static String completeBinary({@required int hByteValue, int lByteValue}) {
    var completeBinary = "";
    if (lByteValue != null) {
      final hByte = hByteValue.toRadixString(2).padLeft(8, '0');
      final lByte = lByteValue.toRadixString(2).padLeft(8, '0');
      completeBinary = hByte + lByte;
    } else {
      final hByte = hByteValue.toRadixString(2).padLeft(16, '0');
      completeBinary = hByte;
    }
    return completeBinary;
  }

/// Bytes to SInt8 conversion
  static int bytesToSInt8({@required int byteValue}) {
    final binaryMerged = completeBinary(hByteValue: byteValue);
    final binaryToSInt8 = int.parse(binaryMerged, radix: 2).toSigned(8);
    return binaryToSInt8;
  }

  /// Bytes to UInt8 conversion
  static int bytesToUInt8({@required int byteValue}) {
    final binaryMerged = completeBinary(hByteValue: byteValue);
    final binaryToUInt8 = int.parse(binaryMerged, radix: 2).toUnsigned(8);
    return binaryToUInt8;
  }

  /// Bytes to SInt16 conversion
  static int bytesToSInt16({@required int hByteValue, int lByteValue}) {
    final binaryMerged = completeBinary(hByteValue: hByteValue, lByteValue: lByteValue);
    final binaryToSInt16 = int.parse(binaryMerged, radix: 2).toSigned(16);
    return binaryToSInt16;
  }

  /// Bytes to UInt16 conversion
  static int bytesToUInt16({@required int hByteValue, int lByteValue}) {
    final binaryMerged = completeBinary(hByteValue: hByteValue, lByteValue: lByteValue);
    final binaryToUInt16 = int.parse(binaryMerged, radix: 2).toUnsigned(16);
    return binaryToUInt16;
  }
*/
