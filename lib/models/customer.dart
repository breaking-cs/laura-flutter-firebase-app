class Customer {
  final DateTime createdAt;
  final String name;
  bool isVip;

  Customer({
    required this.createdAt,
    required this.name,
    this.isVip = false,
  });
}
