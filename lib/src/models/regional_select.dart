// To parse this JSON data, do
//
//     final regionalSelect = regionalSelectFromJson(jsonString);

import 'dart:convert';

class LRegionalSelect {
  List<RegionalSelect> items = [];
  LRegionalSelect();
  LRegionalSelect.fromJsonList(List<dynamic> jsonList) {
    // ignore: unnecessary_null_comparison
    if (jsonList == null) return;

    for (var item in jsonList) {
      final boleta = new RegionalSelect.fromJson(item);
      items.add(boleta);
    }
  }
}

RegionalSelect regionalSelectFromJson(String str) =>
    RegionalSelect.fromJson(json.decode(str));

String regionalSelectToJson(RegionalSelect data) => json.encode(data.toJson());

class RegionalSelect {
  RegionalSelect({
    this.value,
    this.label,
    this.icon,
  });

  int? value;
  String? label;
  String? icon;

  factory RegionalSelect.fromJson(Map<String, dynamic> json) => RegionalSelect(
        value: json["value"],
        label: json["label"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "label": label,
        "icon": icon,
      };
}
