import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_homework/models/trade_model.dart';
import 'package:web_socket_homework/pages/trades/trades_provider.dart';

import '../../services/socket_service.dart';

class TradesPage extends StatelessWidget {
  static const id = '/trades_page';

  const TradesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TradesProvider(),
      builder: (context, widget) {
        var tradeProvider = Provider.of<TradesProvider>(context, listen: false);

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.grey.shade900,
            centerTitle: true,
            title: const Text('Trades'),
          ),
          body: WillPopScope(
            onWillPop: () async {
              tradeProvider.disConnect();
              return true;
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Consumer<TradesProvider>(
                builder: (context, provider, widget) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          title('№:', 1),
                          title('Size:', 2),
                          title('Price:', 2),
                          title('Side:', 2),
                          title('Day:', 2),
                          title('Time:', 2),
                        ],
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: SocketService.channel.stream,
                          builder: (context, snapshot) {
                            Trade trade = Trade();
                            if(snapshot.hasData) {
                              trade = tradeFromJson(snapshot.data.toString());
                            }

                            return trade.data != null ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: trade.data!.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    tableItem((index + 1).toString(), 1, Colors.lightBlueAccent),
                                    tableItem('${trade.data![index].size}', 2, Colors.green),
                                    tableItem('${trade.data![index].price}', 2, Colors.green),
                                    tableItem('${trade.data![index].side}', 2, ('${trade.data![index].side}' == 'buy' ? Colors.greenAccent : Colors.orange)),
                                    tableItem(trade.data![index].timestamp!.substring(5,10), 2, Colors.green),
                                    tableItem(trade.data![index].timestamp!.substring(11,19), 2, Colors.green),
                                  ]
                                );
                              },
                            ) : const Center(child: Text('Waiting for Network...', style: TextStyle(color: Colors.redAccent, fontSize: 20)));
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
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
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white10,
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
