class Transaction {
  final int id; // transaction id
  final int customerId;
  final int amount;
  final DateTime date;
  final String memo;
  final String imgUrl;

  Transaction({
    required this.id,
    required this.customerId,
    required this.amount,
    required this.date,
    this.memo = "",
    this.imgUrl = "",
  });
}
