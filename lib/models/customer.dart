class Customer {
  final DateTime createdAt;
  final String name;
  bool isVip;

  Customer({
    required this.createdAt,
    required this.name,
    this.isVip = false,
  });

  Customer.fromJson(Map<String, dynamic> parsedJSON)
      : name = parsedJSON['name'],
        createdAt = parsedJSON['createdAt'].toDate(),
        isVip = false;
}
