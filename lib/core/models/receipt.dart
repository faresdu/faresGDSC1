import 'package:gdsc_app/core/models/bank_account.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';

class Receipt {
  final String? id;
  final String userId;
  final BankAccount bank;
  final String receiptNumber;
  final String content;
  final String priceNoVat;
  final String vatValue;
  final String price;
  final String receiptPicture;
  final DateTime date;
  final String notes;
  final DateTime createdAt;
  final bool? status;
  final String? rejectionReason;

  Receipt(
      {this.id,
      required this.userId,
      required this.createdAt,
      required this.price,
      required this.notes,
      required this.receiptNumber,
      required this.priceNoVat,
      required this.vatValue,
      required this.receiptPicture,
      required this.date,
      required this.content,
      required this.bank,
      this.status,
      this.rejectionReason});

  factory Receipt.fromJson(Map<String, dynamic> map) {
    return Receipt(
      id: map['id'],
      userId: map['user_id'],
      createdAt: map['created_at'],
      receiptNumber: map['receipt_number'],
      priceNoVat: map['price_no_vat'],
      vatValue: map['vat_value'],
      price: map['price'],
      receiptPicture: map['receipt_picture'],
      status: map['status'],
      date: map['date'],
      content: map['content'],
      notes: map['notes'],
      rejectionReason: map['rejection_reason'],
      bank: BankAccount.fromJson(
        map['bank'],
      ),
    );
  }

  Map<String, dynamic> toJson({String? bankId}) {
    return {
      'user_id': userId,
      'bank_id': bankId ?? bank.id,
      'receipt_number': receiptNumber,
      'content': content,
      'price_no_vat': priceNoVat,
      'vat_value': vatValue,
      'price': price,
      'receipt_picture': receiptPicture,
      'date': DateHelper.getDate(date, dash: true),
      'notes': notes,
      'status': status,
      'rejection_reason': rejectionReason
    };
  }
}
