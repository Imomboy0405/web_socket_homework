import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class SocketService {
  static String SERVER = 'wss://api.hollaex.com/stream';

  static WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(SERVER));

  static void connectSocketChannelOrderBook() {
    channel = WebSocketChannel.connect(Uri.parse(SERVER));
    channel.sink.add(
      jsonEncode(
        {
          "op": "subscribe",
          "args": ['orderbook'],
        },
      ),
    );
  }

  static void connectSocketChannelTrades() {
    channel = WebSocketChannel.connect(Uri.parse(SERVER));
    channel.sink.add(
      jsonEncode(
        {
          "op": "subscribe",
          "args": ['trade'],
        },
      ),
    );
  }

  static void closeSocketChannel() {
    channel.sink.close();
  }
}