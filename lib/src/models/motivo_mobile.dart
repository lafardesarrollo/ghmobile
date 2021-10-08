// To parse this JSON data, do
//
//     final motivoMobile = motivoMobileFromJson(jsonString);

import 'dart:convert';

class LMotivoMobile {
  List<MotivoMobile> items = [];
  LMotivoMobile();
  LMotivoMobile.fromJsonList(List<dynamic> jsonList) {
    // ignore: unnecessary_null_comparison
    if (jsonList == null) return;

    for (var item in jsonList) {
      final boleta = new MotivoMobile.fromJson(item);
      items.add(boleta);
    }
  }
}

MotivoMobile motivoMobileFromJson(String str) =>
    MotivoMobile.fromJson(json.decode(str));

String motivoMobileToJson(MotivoMobile data) => json.encode(data.toJson());

class MotivoMobile {
  MotivoMobile({
    this.value,
    this.label,
  });

  String? value;
  String? label;

  factory MotivoMobile.fromJson(Map<String, dynamic> json) => MotivoMobile(
        value: json["value"],
        label: json["label"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
      };
}
