import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sibzamini/core/data_staes.dart';
import 'package:sibzamini/core/error_code.dart';

enum ConnectivityStatus { connected, disconnected }

class InternetConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Future<DataState<bool>> isInterNetEnabled() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      return DataFailState(NO_INTERNET_CONNECTION);
    } else if (result == ConnectivityResult.vpn) {
      return DataFailState(VPN_CONNCETION_DETECTED);
    }
    return DataSuccesState(true);
  }

  Stream<ConnectivityStatus> connectivityResultStream() async* {
    yield* _connectivity.onConnectivityChanged.map((event) {
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi ||
          event == ConnectivityResult.ethernet ||
          event == ConnectivityResult.bluetooth) {
        return ConnectivityStatus.connected;
      }
      return ConnectivityStatus.disconnected;
    });
  }
}
