class Variant {
  String id;
  String name;
  String type_id;
  String value;
  int price_change;
  Variant(this.id, this.name, this.type_id, this.value, this.price_change);

  factory Variant.fromJson(Map<String, dynamic> jsonObject) {
    return Variant(
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['type_id'],
      jsonObject['value'],
      jsonObject['price_change'],
    );
  }
}
