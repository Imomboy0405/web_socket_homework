import 'package:flutter/material.dart';

import '../../services/socket_service.dart';

class TradesProvider extends ChangeNotifier {

  TradesProvider() {
    connect();
  }

  void connect() {
    debugPrint('connect trades');
    SocketService.connectSocketChannelTrades();
  }

  void disConnect() {
    SocketService.closeSocketChannel();
    SocketService.channel;
  }
}