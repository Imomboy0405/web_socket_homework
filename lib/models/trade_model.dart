import 'dart:convert';
Trade tradeFromJson(String str) => Trade.fromJson(json.decode(str));
String tradeToJson(Trade data) => json.encode(data.toJson());

class Trade {
  Trade({
      this.topic, 
      this.action, 
      this.symbol, 
      this.data, 
      this.time,});

  Trade.fromJson(dynamic json) {
    topic = json['topic'];
    action = json['action'];
    symbol = json['symbol'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    time = json['time'];
  }
  String? topic;
  String? action;
  String? symbol;
  List<Data>? data;
  num? time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['topic'] = topic;
    map['action'] = action;
    map['symbol'] = symbol;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['time'] = time;
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      this.size, 
      this.price, 
      this.side, 
      this.timestamp,});

  Data.fromJson(dynamic json) {
    size = json['size'];
    price = json['price'];
    side = json['side'];
    timestamp = json['timestamp'];
  }
  num? size;
  num? price;
  String? side;
  String? timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['size'] = size;
    map['price'] = price;
    map['side'] = side;
    map['timestamp'] = timestamp;
    return map;
  }

}