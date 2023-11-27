class BankAccount {
  final String id;
  final String userId;
  final String iban;
  final String bankName;
  final String accountHolderName;
  final DateTime createdAt;

  BankAccount(
      {required this.id,
      required this.userId,
      required this.iban,
      required this.bankName,
      required this.accountHolderName,
      required this.createdAt});

  factory BankAccount.anonymous() {
    return BankAccount(
        id: '',
        userId: '',
        iban: '',
        bankName: '',
        accountHolderName: '',
        createdAt: DateTime.now());
  }

  factory BankAccount.fromJson(Map<String, dynamic> map) {
    return BankAccount(
        id: map['id'],
        userId: map['user_id'],
        iban: map['iban'],
        bankName: map['bank_name'],
        accountHolderName: map["account_holder_name"],
        createdAt: DateTime.parse(map['created_at']));
  }
  Map<String, dynamic> toJson({bool deleted = false}) {
    return {
      'user_id': userId,
      'iban': iban,
      'bank_name': bankName,
      'account_holder_name': accountHolderName,
      'deleted_at': deleted ? DateTime.now().toIso8601String() : null
    };
  }
}
