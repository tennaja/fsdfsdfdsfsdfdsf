class source {
  String? source_id;
  String? source_name;
  String? source_number;
  String? source_address;

  source({
    required this.source_id,
    required this.source_name,
    required this.source_number,
    required this.source_address,
  });

  factory source.fromJson(Map<String, dynamic> json) {
    return source(
      source_id: json['source_id'],
      source_name: json['source_name'],
      source_number: json['source_number'],
      source_address: json['source_address'],
    );
  }

  Map<String, dynamic> toJson() => {
        'source_id': source_id,
        'source_name': source_name,
        'source_number': source_number,
        'source_address': source_address,
      };
}
