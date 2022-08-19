class OneDayCoinHistoryResponseModel {
  List<Data>? data;
  int? timestamp;

  OneDayCoinHistoryResponseModel({this.data, this.timestamp});

  OneDayCoinHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = timestamp;
    return data;
  }
}

class Data {
  String? priceUsd;
  int? time;
  String? date;

  Data({this.priceUsd, this.time, this.date});

  Data.fromJson(Map<String, dynamic> json) {
    priceUsd = json['priceUsd'];
    time = json['time'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['priceUsd'] = priceUsd;
    data['time'] = time;
    data['date'] = date;
    return data;
  }
}
