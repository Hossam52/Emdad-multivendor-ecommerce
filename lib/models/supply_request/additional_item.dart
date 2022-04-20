import 'dart:convert';

class AdditionalItem {
  String description;
  double price;
  String id;
  AdditionalItem({
    required this.description,
    required this.price,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'price': price,
      '_id': id,
    };
  }

  factory AdditionalItem.fromMap(Map<String, dynamic> map) {
    return AdditionalItem(
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AdditionalItem.fromJson(String source) =>
      AdditionalItem.fromMap(json.decode(source));
}