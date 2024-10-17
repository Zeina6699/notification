import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:notification/constants/constants.dart';
import 'package:notification/screen/second_page.dart';
import 'package:notification/utils/notification_service.dart';

import 'dart:async';
class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  final Connectivity _connectivity = Connectivity();
  final NotificationService _notificationService = NotificationService();
  String _connectionStatus = 'Unknown';
  StreamSubscription<List<ConnectivityResult>>? _subscription;
String imagePath='';
  @override
  void initState() {
    super.initState();
    _subscription = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
      _updateConnectionStatus(result);
    });

    _checkConnection();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _checkConnection() async {
    List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity() as List<ConnectivityResult>;
    } catch (e) {
      result = [ConnectivityResult.none];
    }

    _updateConnectionStatus(result);

  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    String status = 'Unknown';

    // Determine connection status based on the first available result
    for (var res in result) {
      switch (res) {
        case ConnectivityResult.wifi:
          status = 'Connected to Wi-Fi ❤❤💚🐍';
imagePath=ImagesPath.wifiImage;
          break;
        case ConnectivityResult.mobile:
          status = 'Connected to Mobile Data 💚🐍';
          imagePath=ImagesPath.mobileData;


          break;
        case ConnectivityResult.none:
          status = 'No internet connection 💚🐍';
          imagePath=ImagesPath.noInternet;


          break;
        case ConnectivityResult.vpn:
          status ="Vpn connection";
          imagePath=ImagesPath.vpn;

          break;
        default:
          status = 'Unknown connection';
          break;
      }

    }

    if (_connectionStatus != status) {
      _connectionStatus = status;
      debugPrint(status);
      Future.delayed(Duration(seconds: 4),()=>  _notificationService.showNotification("Connection Status", _connectionStatus));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page One'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center ,
          children: [

            if(imagePath.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                    height: 250,
                    imagePath),
              ) ,
            Text('Connection Status:$_connectionStatus'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageTwo()),
                );
              },
              child: Text('Go to Page Two'),
            ),
          ],
        ),
      ),
    );
  }
}
