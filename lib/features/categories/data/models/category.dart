class Category {
  const Category({required this.id, required this.name});

  final String id;
  final String name;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'].toString(), name: json['name'] as String);
  }
}
