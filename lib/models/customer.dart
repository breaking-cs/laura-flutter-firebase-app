class Customer {
  final DateTime createdAt;
  final String id; // document id
  final String name;
  bool isVip;

  Customer({
    required this.createdAt,
    required this.name,
    this.isVip = false,
    required this.id,
  });

  Customer.fromJson(Map<String, dynamic> parsedJSON, this.id)
      : name = parsedJSON['name'],
        createdAt = parsedJSON['createdAt'].toDate(),
        isVip = false;
}
