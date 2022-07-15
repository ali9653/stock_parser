import 'dart:convert';

List<StockModel> stockModelFromJson(String str) => List<StockModel>.from(json.decode(str).map((x) => StockModel.fromJson(x)));

class StockModel {
  StockModel({
    this.id,
    this.name,
    this.tag,
    this.color,
    this.criteria,
  });

  int? id;
  String? name;
  String? tag;
  String? color;
  List<Criteria>? criteria;

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
        id: json["id"],
        name: json["name"],
        tag: json["tag"],
        color: json["color"],
        criteria: List<Criteria>.from(json["criteria"].map((x) => Criteria.fromJson(x))),
      );
}

class Criteria {
  Criteria({
    this.type,
    this.text,
    this.variable,
  });

  String? type;
  String? text;
  dynamic variable;

  factory Criteria.fromJson(Map<String, dynamic> json) =>
      Criteria(type: json["type"], text: json["text"], variable: json["variable"] ?? "");
}

class Variable {
  Variable({
    this.commonKey,
  });

  VariableKey? commonKey;

  factory Variable.fromJson(Map<String, dynamic> json) => Variable(
        commonKey: json["\u00241"] == null ? null : VariableKey.fromJson(json["\u00241"]),
      );
}

class VariableKey {
  VariableKey({
    this.type,
    this.values,
    this.studyType,
    this.parameterName,
    this.minValue,
    this.maxValue,
    this.defaultValue,
  });

  String? type;
  List<String>? values;
  String? studyType;
  String? parameterName;
  int? minValue;
  int? maxValue;
  int? defaultValue;

  factory VariableKey.fromJson(Map<String, dynamic> json) => VariableKey(
        type: json["type"],
        values: json["values"] == null ? [] : List<String>.from(json["values"].map((x) => x.toString())),
        studyType: json["study_type"] ?? "",
        parameterName: json["parameter_name"] ?? "",
        minValue: json["min_value"] ?? 0,
        maxValue: json["max_value"] ?? 0,
        defaultValue: json["default_value"] ?? 0,
      );
}
