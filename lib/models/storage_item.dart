class StorageItem {
  final String name;
  final double price;
  final int quantity;
  final String description;
  final String condition;
  final String photo;

  StorageItem({
    required this.name,
    required this.price,
    required this.quantity,
    this.description = '', // Description facultative
    this.condition = 'Usé', // État par défaut
    this.photo = '', // URL ou chemin de la photo
  });

  // Méthode pour créer une instance depuis JSON
  factory StorageItem.fromJson(Map<String, dynamic> json) {
    return StorageItem(
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] as int,
      description: json['description'] ?? '',
      condition: json['condition'] ?? 'Usé',
      photo: json['photo'] ?? '',
    );
  }
}

class Storage {
  final String userId;
  final String storageName;
  final double storageCapacity;
  final List<StorageItem> storedObjects;

  Storage({
    this.userId = '',
    this.storageName = '',
    this.storageCapacity = 0,
    this.storedObjects = const [],
  });

  // Méthode pour créer une instance depuis JSON
  factory Storage.fromJson(Map<String, dynamic> json) {
    final List<dynamic> storedObjectsJson = json['storedObjects'] ?? [];
    final List<StorageItem> storedObjects =
    storedObjectsJson.map((e) => StorageItem.fromJson(e)).toList();

    return Storage(
      userId: json['userId'] ?? '',
      storageName: json['storageName'] ?? '',
      storageCapacity: (json['storageCapacity'] as num).toDouble(),
      storedObjects: storedObjects,
    );
  }
}