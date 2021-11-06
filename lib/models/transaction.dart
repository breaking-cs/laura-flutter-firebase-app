class Transaction {
  final DateTime createdAt;
  final String id; // transaction document id
  final int amount;
  final String memo;
  final String imgUrl;

  Transaction({
    required this.id,
    required this.amount,
    required this.createdAt,
    this.memo = "",
    this.imgUrl = "",
  });

  Transaction.fromJson(Map<String, dynamic> parsedJSON, this.id)
      : createdAt = parsedJSON['createdAt'].toDate(),
        amount = parsedJSON['amount'],
        memo = parsedJSON['memo'],
        imgUrl = parsedJSON['imgUrl'];
}
