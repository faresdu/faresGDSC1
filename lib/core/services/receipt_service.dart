import 'package:flutter/foundation.dart';
import 'package:gdsc_app/core/enums/tables.dart';
import 'package:gdsc_app/core/models/bank_account.dart';
import 'package:gdsc_app/core/models/receipt.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase/supabase.dart';

import '../app/app.locator.dart';

class ReceiptService {
  final _supabaseService = locator<SupabaseService>();

  Future<Receipt> sendReceipt(Receipt receipt, String bankId) async {
    final PostgrestResponse<dynamic> res = await _supabaseService.supabaseClient
        .from(GDSCTables.receipts)
        .insert(receipt.toJson(bankId: bankId));

    return Receipt.fromJson(res.data.first);
  }

  Future<void> updateReceipt(String id, bool status) async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCTables.receipts)
          .update({'status': status}).match({'id': id});
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<List<Receipt>> fetchAllReceipts() async {
    try {
      final List<Map<String, dynamic>> res = await _supabaseService
          .supabaseClient
          .from(GDSCTables.receipts)
          .select('*');
      return res.map((e) => Receipt.fromJson(e)).toList();
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }

  Future<BankAccount> createBankAccount(BankAccount bankAccount) async {
    final PostgrestResponse<dynamic> res = await _supabaseService.supabaseClient
        .from(GDSCTables.bankAccounts)
        .insert(bankAccount.toJson());
    return BankAccount.fromJson(res.data.first);
  }

  Future<List<BankAccount>> fetchBankAccounts(String userId) async {
    try {
      final List<Map<String, dynamic>> res = await _supabaseService
          .supabaseClient
          .from(GDSCTables.bankAccounts)
          .select('*')
          .eq('user_id', userId);
      // .eq('deleted_at', null)
      return res.map((e) => BankAccount.fromJson(e)).toList();
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
