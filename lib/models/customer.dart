class Customer {
  final String id; // customer id
  final String name;
  bool isVip;

  Customer({
    required this.id,
    required this.name,
    this.isVip = false,
  });
}
