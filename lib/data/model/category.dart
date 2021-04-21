class Category {
  final String id;
  final String name;
  final String? assetName;

  const Category._(this.id, this.name, [this.assetName]);

  static const byId = {
    'temple': Category._('temple', 'Храм'),
    'monument': Category._('monument', 'Памятник'),
    'park': Category._('park', 'Парк', 'Park'),
    'theatre': Category._('theatre', 'Театр'),
    'museum': Category._('museum', 'Музей', 'Museum'),
    'hotel': Category._('hotel', 'Отель', 'Hotel'),
    'restaurant': Category._('restaurant', 'Ресторан', 'Restourant'),
    'cafe': Category._('cafe', 'Кафе', 'Cafe'),
    'other': Category._('other', 'Особое место', 'Particular place'),
  };

  static Iterable<Category> get filterList =>
      byId.values.where((c) => c.assetName != null);

  static List<String> get allIds => byId.values.map((c) => c.id).toList();
}
