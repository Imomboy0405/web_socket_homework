import 'package:flutter/material.dart';

import 'pages/trades/trades_page.dart';
import 'pages/home/home_page.dart';
import 'pages/orderBook/order_book_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web Socket',
      home: const HomePage(),
      routes: {
        HomePage.id: (context) => const HomePage(),
        OrderBookPage.id: (context) => const OrderBookPage(),
        TradesPage.id: (context) => const TradesPage(),
      },
    );
  }
}
