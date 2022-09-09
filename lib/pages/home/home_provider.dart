import 'package:flutter/material.dart';
import 'package:web_socket_homework/services/socket_service.dart';

import '../orderBook/order_book_page.dart';
import '../trades/trades_page.dart';

class HomeProvider extends ChangeNotifier {

  HomeProvider() {
    connect();
  }

  void connect() {
    debugPrint('connect');
    SocketService.channel;
  }

  void disConnect() {
    SocketService.closeSocketChannel();
  }

  void openOrderBookPage(BuildContext context) {
    Navigator.pushNamed(context, OrderBookPage.id);
  }

  void openTradesPage(BuildContext context) {
    Navigator.pushNamed(context, TradesPage.id);
  }
}