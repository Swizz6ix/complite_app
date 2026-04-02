import 'dart:async';
import 'dart:io';

import 'package:complite/providers/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod/riverpod.dart';

class NetworkProvider implements NetworkInfo {
  final Connectivity _connectivity;

  NetworkProvider(this._connectivity);

  @override
  Future<bool> get isConnected async {
    final connectivity = await _connectivity.checkConnectivity();

    // no network at all (airplane mode, no data, no wifi)
    if (connectivity == ConnectivityResult.none) {
      print("connectivity type: $connectivity");
      return false;
    }
    print("connect $connectivity");

    // Try HTTP check with retry
    if (await _httpCheck()) {
      return true;
    }

    // Fallback TCP ping
    if (await _tcpCheck()) {
      return true;
    }

    print("Network detected, but no internet access");
    return false;
  }

  /// HTTP check to Google generate_204
  Future<bool> _httpCheck({int retries = 2}) async {
    const url = 'http://client3.google.com/generate_204';
      
    for (int i = 0; i <= retries; i++) {
      try {
        final request = await HttpClient()
          .getUrl(Uri.parse(url))
          .timeout(const Duration(seconds: 5));

        final response = await request.close().timeout(const Duration(seconds: 5));
        print("HTTP status code: ${response.statusCode}");

        if (response.statusCode == 204) return true;
      } on TimeoutException {
        print("HTTP check timed out (attempt ${i + 1})");
      } on SocketException catch (e) {
        print("HTTP SocketException (attempt ${i + 1}): $e");
      } catch (e) {
        print("HTTP unexpected error (attempt ${i + 1}): $e");
      }
      await Future.delayed(const Duration(milliseconds: 200));
    }
    return false;
  }

  /// TCP fallback check (ping Google DNS)
  Future<bool> _tcpCheck({int retries = 1}) async {
    for (int i = 0; i <= retries; i++) {
      try {
        final socket = await Socket.connect(
          '8.8.8.8', 
          53, 
          timeout: Duration(seconds: 5)
        );
        socket.destroy();
        print("TCP check succeeded");
        return true;
      } catch (e) {
        print("TCP check failed (attempt ${i + 1}): $e");
      }
      await Future.delayed(const Duration(milliseconds: 200));
    }
    return false;
  }
}

final networkProvider = Provider<NetworkInfo>((ref) => NetworkProvider(Connectivity()));