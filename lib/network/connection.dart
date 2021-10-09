import 'dart:io';

class Connection {
  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      print(result.isNotEmpty && result[0].rawAddress.isNotEmpty);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      print("false");
      return false;
    }
  }
}
