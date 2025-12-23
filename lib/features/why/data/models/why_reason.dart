class WhyReason {
  const WhyReason({
    required this.icon,
    required this.title,
    required this.description,
  });

  final String icon;
  final String title;
  final String description;

  factory WhyReason.fromJson(Map<String, dynamic> json) {
    return WhyReason(
      icon: json['icon'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}
