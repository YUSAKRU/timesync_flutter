import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timesync_flutter/data/models/payment_model.dart';
import 'package:timesync_flutter/core/services/payment_service.dart';

// Payment Service Provider
final paymentServiceProvider = Provider<PaymentService>((ref) {
  return PaymentService();
});

// Process Payment Provider (FutureProvider)
final processPaymentProvider =
    FutureProvider.family<PaymentResponse, CreatePaymentRequest>((ref, request) async {
  final service = ref.watch(paymentServiceProvider);
  return service.processPayment(request);
});

// Get Payment Provider
final getPaymentProvider = FutureProvider.family<PaymentModel, String>((ref, paymentId) async {
  final service = ref.watch(paymentServiceProvider);
  return service.getPayment(paymentId);
});

// Payment History Provider (Paginated)
final paymentHistoryProvider = FutureProvider.family<
    PaymentHistoryResponse,
    ({String customerId, int page, int pageSize})>((ref, params) async {
  final service = ref.watch(paymentServiceProvider);
  return service.getPaymentHistory(
    params.customerId,
    page: params.page,
    pageSize: params.pageSize,
  );
});

// Get Wallet Provider
final getWalletProvider = FutureProvider.family<WalletModel, String>((ref, customerId) async {
  final service = ref.watch(paymentServiceProvider);
  return service.getWallet(customerId);
});

// Add Funds to Wallet Provider
final addFundsToWalletProvider = FutureProvider.family<
    WalletTransaction,
    ({String customerId, double amount})>((ref, params) async {
  final service = ref.watch(paymentServiceProvider);
  return service.addFundsToWallet(params.customerId, params.amount);
});

// Get Invoice Provider
final getInvoiceProvider = FutureProvider.family<InvoiceModel, String>((ref, paymentId) async {
  final service = ref.watch(paymentServiceProvider);
  return service.getInvoice(paymentId);
});

// Refund Payment Provider
final refundPaymentProvider =
    FutureProvider.family<PaymentResponse, RefundRequest>((ref, request) async {
  final service = ref.watch(paymentServiceProvider);
  return service.refundPayment(request);
});

// Validate Payment Method Provider
final validatePaymentMethodProvider = FutureProvider.family<
    bool,
    ({
      PaymentMethod method,
      String? cardNumber,
      String? cardExpiry,
      String? cardCvc
    })>((ref, params) async {
  final service = ref.watch(paymentServiceProvider);
  return service.validatePaymentMethod(
    params.method,
    cardNumber: params.cardNumber,
    cardExpiry: params.cardExpiry,
    cardCvc: params.cardCvc,
  );
});

// Payment Methods available for business
final availablePaymentMethodsProvider = Provider<List<PaymentMethod>>((ref) {
  // Can be customized per business
  return [
    PaymentMethod.creditCard,
    PaymentMethod.debitCard,
    PaymentMethod.wallet,
    PaymentMethod.bankTransfer,
  ];
});

// Payment Method State Notifier
class PaymentMethodNotifier extends StateNotifier<PaymentMethod?> {
  PaymentMethodNotifier() : super(null);

  void setPaymentMethod(PaymentMethod method) {
    state = method;
  }

  void clear() {
    state = null;
  }
}

final selectedPaymentMethodProvider =
    StateNotifierProvider<PaymentMethodNotifier, PaymentMethod?>((ref) {
  return PaymentMethodNotifier();
});

// Payment Amount State Notifier
class PaymentAmountNotifier extends StateNotifier<double> {
  PaymentAmountNotifier() : super(0.0);

  void setAmount(double amount) {
    state = amount;
  }

  void addAmount(double amount) {
    state += amount;
  }

  void clear() {
    state = 0.0;
  }
}

final paymentAmountProvider =
    StateNotifierProvider<PaymentAmountNotifier, double>((ref) {
  return PaymentAmountNotifier();
});

// Payment Installment State Notifier
class PaymentInstallmentNotifier extends StateNotifier<int?> {
  PaymentInstallmentNotifier() : super(null);

  void setInstallment(int count) {
    if (count > 1) {
      state = count;
    } else {
      state = null;
    }
  }

  void clear() {
    state = null;
  }

  double? getInstallmentAmount(double totalAmount) {
    if (state == null || state! <= 1) return null;
    return totalAmount / state!;
  }
}

final paymentInstallmentProvider =
    StateNotifierProvider<PaymentInstallmentNotifier, int?>((ref) {
  return PaymentInstallmentNotifier();
});

// Computed provider for installment details
final installmentDetailsProvider = Provider.family<
    ({int count, double amount})?
    ,
    double>((ref, totalAmount) {
  final installmentCount = ref.watch(paymentInstallmentProvider);
  
  if (installmentCount == null || installmentCount <= 1) {
    return null;
  }

  return (count: installmentCount, amount: totalAmount / installmentCount);
});
