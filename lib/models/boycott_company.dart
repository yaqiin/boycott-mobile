class BoycottAlternative {
  final String name;
  final String link;
  final String countryCode;
  final String country;

  const BoycottAlternative({
    required this.name,
    required this.link,
    required this.countryCode,
    required this.country,
  });

  factory BoycottAlternative.fromJson(Map<String, dynamic> json) {
    return BoycottAlternative(
      name: json['name'] as String,
      link: json['link'] as String,
      countryCode: json['countryCode'] as String,
      country: json['country'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'link': link,
      'country_code': countryCode,
      'country': country,
    };
  }
}

class BoycottCompany {
  final String name;
  final String category;
  final String country;
  final String countryCode;
  final List<BoycottAlternative>? alternatives;

  const BoycottCompany({
    required this.name,
    required this.category,
    required this.country,
    required this.countryCode,
    this.alternatives,
  });

  factory BoycottCompany.fromJson(Map<String, dynamic> json) {
    final alternativesJson = json['alternatives'] as List<dynamic>?;

    return BoycottCompany(
      name: json['name'] as String,
      category: json['category'] ?? "",
      country: json['country'] as String,
      countryCode: json['countryCode'] as String,
      alternatives: alternativesJson
          ?.map(
            (altJson) =>
                BoycottAlternative.fromJson(altJson as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'country': country,
      'country_code': countryCode,
      'alternatives': alternatives?.map((alt) => alt.toJson()).toList(),
    };
  }
}
