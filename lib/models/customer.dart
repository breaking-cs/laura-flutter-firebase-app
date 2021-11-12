class Customer {
  final DateTime createdAt;
  final String id; // document id
  final String name;
  final String phoneNumber;
  bool isVip;

  Customer({
    required this.createdAt,
    required this.name,
    required this.phoneNumber,
    this.isVip = false,
    required this.id,
  });

  Customer.fromJson(Map<String, dynamic> parsedJSON, this.id)
      : name = parsedJSON['name'],
        phoneNumber = parsedJSON['phoneNumber'],
        createdAt = parsedJSON['createdAt'].toDate(),
        isVip = false;
}
