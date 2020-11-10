import 'package:uni_miskolc_datashare/core/user_serial_number/user_serial_number.dart';

class UserSerialNumberImplementation implements UserSerialNumber {
  int serialNumberStore = 0;

  @override
  Null addNumber(int serialNumber) {
    serialNumberStore = serialNumber;
  }

  @override
  Null removeNumber() {
    serialNumberStore = 0;
  }

  @override
  int getNumber() {
    return serialNumberStore;
  }
}
