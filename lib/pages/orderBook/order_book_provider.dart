import 'package:flutter/material.dart';

import '../../services/socket_service.dart';

class OrderBookProvider extends ChangeNotifier {

  OrderBookProvider() {
    connect();
  }

  void connect() {
    debugPrint('connect orderbook');
    SocketService.connectSocketChannelOrderBook();
  }

  void disConnect() {
    SocketService.closeSocketChannel();
    SocketService.channel;
  }
}