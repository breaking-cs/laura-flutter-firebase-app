class Transaction {
  final String id; // transaction id
  final String customerId;
  final int amount;
  final DateTime date;
  String memo;
  String imgUrl;

  Transaction({
    required this.id,
    required this.customerId,
    required this.amount,
    required this.date,
    this.memo = "",
    this.imgUrl = "",
  });
}
