import 'package:timesync_flutter/data/models/payment_model.dart';

/// Payment Service - Handles payment processing
/// 
/// Development: Uses mock payment processing
/// Production: Integrates with real payment gateway (Stripe, PayPal, etc.)
class PaymentService {
  static final PaymentService _instance = PaymentService._internal();

  factory PaymentService() {
    return _instance;
  }

  PaymentService._internal();

  /// Process payment
  Future<PaymentResponse> processPayment(CreatePaymentRequest request) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 1500));

      // Mock: 90% success rate
      final isSuccess = DateTime.now().millisecond % 10 != 0;

      if (isSuccess) {
        return PaymentResponse(
          paymentId: 'PAY_${DateTime.now().millisecondsSinceEpoch}',
          status: PaymentStatus.completed,
          processedAt: DateTime.now(),
          message: 'Ödeme başarıyla tamamlandı',
        );
      } else {
        // Simulate payment failure
        throw PaymentException(
          message: 'Kart reddedildi. Lütfen başka bir kart deneyin.',
          code: 'CARD_DECLINED',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Validate payment method
  Future<bool> validatePaymentMethod(
    PaymentMethod method, {
    String? cardNumber,
    String? cardExpiry,
    String? cardCvc,
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 300));

      // Basic validation
      if (method == PaymentMethod.creditCard ||
          method == PaymentMethod.debitCard) {
        if (cardNumber == null || cardNumber.isEmpty) {
          throw PaymentException(
            message: 'Kart numarası gerekli',
            code: 'INVALID_CARD_NUMBER',
          );
        }

        // Mock: Validate card format (simple)
        if (cardNumber.length < 13 || cardNumber.length > 19) {
          throw PaymentException(
            message: 'Kart numarası geçersiz',
            code: 'INVALID_CARD_NUMBER',
          );
        }
      }

      return true;
    } catch (e) {
      rethrow;
    }
  }

  /// Get payment by ID
  Future<PaymentModel> getPayment(String paymentId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock: Return sample payment
      return PaymentModel(
        id: paymentId,
        appointmentId: 'APT_001',
        customerId: 'CUST_001',
        businessId: 'BUS_001',
        amount: 250.0,
        currency: 'TRY',
        status: PaymentStatus.completed,
        method: PaymentMethod.creditCard,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        completedAt: DateTime.now().subtract(const Duration(hours: 1)),
        transactionId: 'TXN_${paymentId}_001',
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Get payment history for customer
  Future<PaymentHistoryResponse> getPaymentHistory(
    String customerId, {
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      // Mock: Return sample payments
      final payments = List.generate(
        pageSize,
        (index) => PaymentModel(
          id: 'PAY_${(page - 1) * pageSize + index + 1}',
          appointmentId: 'APT_${index + 1}',
          customerId: customerId,
          businessId: 'BUS_${index + 1}',
          amount: (150 + index * 10).toDouble(),
          currency: 'TRY',
          status: _getRandomStatus(),
          method: _getRandomMethod(),
          createdAt:
              DateTime.now().subtract(Duration(days: index)),
          completedAt: index % 2 == 0
              ? DateTime.now().subtract(Duration(days: index))
              : null,
          transactionId: 'TXN_${index + 1}',
        ),
      );

      return PaymentHistoryResponse(
        payments: payments,
        totalCount: 45,
        hasMore: page < 5,
        currentPage: page,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Refund payment
  Future<PaymentResponse> refundPayment(RefundRequest request) async {
    try {
      await Future.delayed(const Duration(milliseconds: 1200));

      return PaymentResponse(
        paymentId: request.paymentId,
        status: PaymentStatus.refunded,
        processedAt: DateTime.now(),
        message: 'İade işlemi başarıyla tamamlandı',
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Get wallet balance
  Future<WalletModel> getWallet(String customerId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock: Return sample wallet
      return WalletModel(
        customerId: customerId,
        balance: 1250.50,
        transactions: [
          WalletTransaction(
            id: 'TXN_001',
            amount: 500.0,
            type: 'credit',
            description: 'Bonus puanları yükseltme',
            timestamp: DateTime.now().subtract(const Duration(days: 10)),
          ),
          WalletTransaction(
            id: 'TXN_002',
            amount: -150.0,
            type: 'debit',
            description: 'Randevu ödeme',
            timestamp: DateTime.now().subtract(const Duration(days: 5)),
            relatedPaymentId: 'PAY_001',
          ),
        ],
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Add funds to wallet
  Future<WalletTransaction> addFundsToWallet(
    String customerId,
    double amount,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 1000));

      return WalletTransaction(
        id: 'TXN_${DateTime.now().millisecondsSinceEpoch}',
        amount: amount,
        type: 'credit',
        description: 'Cüzdan yükleme',
        timestamp: DateTime.now(),
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Get invoice
  Future<InvoiceModel> getInvoice(String paymentId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 600));

      return InvoiceModel(
        id: 'INV_${paymentId}',
        paymentId: paymentId,
        businessName: 'Premium Saç Tasarımı',
        businessAddress: 'İstanbul, Türkiye',
        businessPhone: '+90 212 123 45 67',
        customerName: 'Ahmet Yılmaz',
        customerEmail: 'ahmet@example.com',
        subtotal: 250.0,
        taxAmount: 50.0,
        totalAmount: 300.0,
        issuedAt: DateTime.now(),
        notes: 'Teşekkür ederiz!',
        items: [
          InvoiceItem(
            serviceName: 'Saç Kesimi',
            quantity: 1,
            unitPrice: 200.0,
            discountAmount: 0,
            totalPrice: 200.0,
          ),
          InvoiceItem(
            serviceName: 'Tıraş',
            quantity: 1,
            unitPrice: 50.0,
            discountAmount: 0,
            totalPrice: 50.0,
          ),
        ],
      );
    } catch (e) {
      rethrow;
    }
  }

  // Helper methods

  PaymentStatus _getRandomStatus() {
    final statuses = PaymentStatus.values;
    final index = DateTime.now().millisecond % statuses.length;
    return statuses[index];
  }

  PaymentMethod _getRandomMethod() {
    final methods = PaymentMethod.values;
    final index = DateTime.now().microsecond % methods.length;
    return methods[index];
  }
}

/// Custom Payment Exception
class PaymentException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  PaymentException({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() => 'PaymentException: $message (Code: $code)';
}
