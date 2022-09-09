import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_provider.dart';

class HomePage extends StatelessWidget {
  static const id = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeProvider(),
      builder: (context, widget) {
        var homeProvider = Provider.of<HomeProvider>(context, listen: false);

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.grey.shade900,
            centerTitle: true,
            title: const Text('Web Socket'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () => homeProvider.openOrderBookPage(context),
                color: Colors.grey.shade900,
                height: 60,
                minWidth: double.infinity,
                child: const Text(
                  'Order Book',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              MaterialButton(
                onPressed: () => homeProvider.openTradesPage(context),
                color: Colors.grey.shade900,
                height: 60,
                minWidth: double.infinity,
                child: const Text(
                  'Trades',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
