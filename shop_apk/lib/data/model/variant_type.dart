class VariantType {
  String id;
  String name;
  String title;
  VariantTypeEnum type;

  VariantType(this.id, this.name, this.title, this.type);

  factory VariantType.fromJson(Map<String, dynamic> jsonObject) {
    return VariantType(
      jsonObject['id'],
      jsonObject['name'],
      jsonObject['title'],
      _getVariantTypeEnum(
        jsonObject['type'],
      ),
    );
  }
}

VariantTypeEnum _getVariantTypeEnum(String type) {
  switch (type) {
    case 'Color':
      return VariantTypeEnum.Color;
    case 'Storage':
      return VariantTypeEnum.Storage;
    case 'Voltage':
      return VariantTypeEnum.Voltage;

    default:
      return VariantTypeEnum.Color;
  }
}

enum VariantTypeEnum {
  Color,
  Storage,
  Voltage,
}
