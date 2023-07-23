import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtils {
  static Future<bool> hasConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.mobile) {
    //   // I am connected to a mobile network.
    // } else if (connectivityResult == ConnectivityResult.wifi) {
    //   // I am connected to a wifi network.
    // } else if (connectivityResult == ConnectivityResult.ethernet) {
    //   // I am connected to a ethernet network.
    // } else if (connectivityResult == ConnectivityResult.vpn) {
    //   // I am connected to a vpn network.
    //   // Note for iOS and macOS:
    //   // There is no separate network interface type for [vpn].
    //   // It returns [other] on any device (also simulator)
    // } else if (connectivityResult == ConnectivityResult.bluetooth) {
    //   // I am connected to a bluetooth.
    // } else if (connectivityResult == ConnectivityResult.other) {
    //   // I am connected to a network which is not in the above mentioned networks.
    // } else if (connectivityResult == ConnectivityResult.none) {
    //   // I am not connected to any network.
    // }
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }
}
