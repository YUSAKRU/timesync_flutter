import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_model.freezed.dart';
part 'payment_model.g.dart';

/// Payment Status Enum
enum PaymentStatus {
  pending,    // Ödeme bekleniyor
  completed,  // Ödeme tamamlandı
  failed,     // Ödeme başarısız
  refunded,   // İade edildi
  cancelled,  // İptal edildi
}

extension PaymentStatusExt on PaymentStatus {
  String get label {
    switch (this) {
      case PaymentStatus.pending:
        return 'Bekleniyor';
      case PaymentStatus.completed:
        return 'Tamamlandı';
      case PaymentStatus.failed:
        return 'Başarısız';
      case PaymentStatus.refunded:
        return 'İade Edildi';
      case PaymentStatus.cancelled:
        return 'İptal Edildi';
    }
  }

  String get color {
    switch (this) {
      case PaymentStatus.pending:
        return '#FFA500'; // Orange
      case PaymentStatus.completed:
        return '#4CAF50'; // Green
      case PaymentStatus.failed:
        return '#F44336'; // Red
      case PaymentStatus.refunded:
        return '#2196F3'; // Blue
      case PaymentStatus.cancelled:
        return '#9E9E9E'; // Grey
    }
  }
}

/// Payment Method Enum
enum PaymentMethod {
  creditCard,
  debitCard,
  wallet,
  bankTransfer,
  installment,
}

extension PaymentMethodExt on PaymentMethod {
  String get label {
    switch (this) {
      case PaymentMethod.creditCard:
        return 'Kredi Kartı';
      case PaymentMethod.debitCard:
        return 'Banka Kartı';
      case PaymentMethod.wallet:
        return 'Cüzdan';
      case PaymentMethod.bankTransfer:
        return 'Banka Transferi';
      case PaymentMethod.installment:
        return 'Taksit';
    }
  }

  String get icon {
    switch (this) {
      case PaymentMethod.creditCard:
        return '💳';
      case PaymentMethod.debitCard:
        return '💳';
      case PaymentMethod.wallet:
        return '👝';
      case PaymentMethod.bankTransfer:
        return '🏦';
      case PaymentMethod.installment:
        return '📅';
    }
  }
}

/// Payment Model (Freezed)
@freezed
class PaymentModel with _$PaymentModel {
  const factory PaymentModel({
    required String id,
    required String appointmentId,
    required String customerId,
    required String businessId,
    required double amount,
    required String currency,
    required PaymentStatus status,
    required PaymentMethod method,
    required DateTime createdAt,
    required DateTime? completedAt,
    String? transactionId,
    String? description,
    Map<String, dynamic>? metadata,
    String? failureReason,
    int? installmentCount,
    double? installmentAmount,
  }) = _PaymentModel;

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
}

/// Payment Request Model
@freezed
class CreatePaymentRequest with _$CreatePaymentRequest {
  const factory CreatePaymentRequest({
    required String appointmentId,
    required double amount,
    required PaymentMethod method,
    String? description,
    int? installmentCount,
    Map<String, dynamic>? metadata,
  }) = _CreatePaymentRequest;

  factory CreatePaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentRequestFromJson(json);
}

/// Payment Response from Server
@freezed
class PaymentResponse with _$PaymentResponse {
  const factory PaymentResponse({
    required String paymentId,
    required PaymentStatus status,
    required DateTime processedAt,
    String? redirectUrl, // For 3D Secure
    String? message,
  }) = _PaymentResponse;

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseFromJson(json);
}

/// Payment History Response
@freezed
class PaymentHistoryResponse with _$PaymentHistoryResponse {
  const factory PaymentHistoryResponse({
    required List<PaymentModel> payments,
    required int totalCount,
    required bool hasMore,
    required int currentPage,
  }) = _PaymentHistoryResponse;

  factory PaymentHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentHistoryResponseFromJson(json);
}

/// Refund Request Model
@freezed
class RefundRequest with _$RefundRequest {
  const factory RefundRequest({
    required String paymentId,
    String? reason,
    double? amount, // Partial refund
  }) = _RefundRequest;

  factory RefundRequest.fromJson(Map<String, dynamic> json) =>
      _$RefundRequestFromJson(json);
}

/// Invoice Model
@freezed
class InvoiceModel with _$InvoiceModel {
  const factory InvoiceModel({
    required String id,
    required String paymentId,
    required String businessName,
    required String businessAddress,
    required String businessPhone,
    required String customerName,
    required String customerEmail,
    required double subtotal,
    required double taxAmount,
    required double totalAmount,
    required DateTime issuedAt,
    String? notes,
    List<InvoiceItem>? items,
  }) = _InvoiceModel;

  factory InvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceModelFromJson(json);
}

/// Invoice Item
@freezed
class InvoiceItem with _$InvoiceItem {
  const factory InvoiceItem({
    required String serviceName,
    required int quantity,
    required double unitPrice,
    double? discountAmount,
    required double totalPrice,
  }) = _InvoiceItem;

  factory InvoiceItem.fromJson(Map<String, dynamic> json) =>
      _$InvoiceItemFromJson(json);
}

/// Wallet Model
@freezed
class WalletModel with _$WalletModel {
  const factory WalletModel({
    required String customerId,
    required double balance,
    required List<WalletTransaction> transactions,
    required DateTime lastUpdated,
  }) = _WalletModel;

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);
}

/// Wallet Transaction
@freezed
class WalletTransaction with _$WalletTransaction {
  const factory WalletTransaction({
    required String id,
    required double amount,
    required String type, // 'credit', 'debit'
    required String description,
    required DateTime timestamp,
    String? relatedPaymentId,
  }) = _WalletTransaction;

  factory WalletTransaction.fromJson(Map<String, dynamic> json) =>
      _$WalletTransactionFromJson(json);
}
