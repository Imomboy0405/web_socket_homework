import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_homework/pages/orderBook/order_book_provider.dart';

import '../../models/order_book_model.dart';
import '../../services/socket_service.dart';

class OrderBookPage extends StatelessWidget {
  static const id = '/order_book_page';

  const OrderBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => OrderBookProvider(),
      builder: (context, widget) {
        var orderBookProvider = Provider.of<OrderBookProvider>(context, listen: false);
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.grey.shade900,
            centerTitle: true,
            title: const Text('Order Book'),
          ),
          body: WillPopScope(
            onWillPop: () async {
              orderBookProvider.disConnect();
              return true;
            },
              child: Padding(
              padding: const EdgeInsets.all(5),
              child: Consumer<OrderBookProvider>(
                builder: (context, provider, widget) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          title('№', 1),
                          title('Bids', 4),
                          title('№', 1),
                          title('Asks', 4),
                        ],
                      ),

                      Expanded(
                        child: StreamBuilder(
                          stream: SocketService.channel.stream,
                          builder: (context, snapshot) {
                            OrderBook orderBook = OrderBook();
                            if(snapshot.hasData) {
                              orderBook = orderBookFromJson(snapshot.data.toString());
                            }
                            return orderBook.data != null ? Column(
                              children: [
                                Container(
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade900,
                                    border: Border.all(color: Colors.white, width: 0.2),
                                  ),
                                  child: Text(
                                    'Day: ${orderBook.data!.timestamp!.substring(0,10)}   Time: ${orderBook.data!.timestamp!.substring(11,19)}',
                                    style: const TextStyle(color: Colors.yellow, fontSize: 18),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      asksOrBids(orderBook.data!.bids!, orderBook.data!.timestamp!),
                                      asksOrBids(orderBook.data!.asks!, orderBook.data!.timestamp!),
                                    ],
                                  ),
                                ),
                              ],
                            ): const Center(child: Text('Waiting for Network...', style: TextStyle(color: Colors.redAccent, fontSize: 20),));
                          },
                        ),
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
        );
      },
    );
  }

  Expanded asksOrBids(List list, String time) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              tableItem((index + 1).toString(), 1, Colors.lightBlueAccent),
              tableItem('${list[index][0]},   ${list[index][1]}', 4, Colors.green),
            ],
          );
        },
      ),
    );
  }

  Expanded tableItem(String text, int flex, Color color) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 1),
        padding: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
            color: Colors.grey.shade900,
            border: Border.all(color: Colors.white, width: 0.2)),
        child: Text(
          text,
          style: TextStyle(color: color),
        ),
      ),
    );
  }

  Expanded title(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white10,
          border: Border.all(width: 0.5, color: Colors.white),
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 18,
              color: Colors.lightBlueAccent,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
