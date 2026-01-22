// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentModelImpl _$$PaymentModelImplFromJson(Map<String, dynamic> json) =>
    _$PaymentModelImpl(
      id: json['id'] as String,
      appointmentId: json['appointmentId'] as String,
      customerId: json['customerId'] as String,
      businessId: json['businessId'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: $enumDecode(_$PaymentStatusEnumMap, json['status']),
      method: $enumDecode(_$PaymentMethodEnumMap, json['method']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      transactionId: json['transactionId'] as String?,
      description: json['description'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      failureReason: json['failureReason'] as String?,
      installmentCount: (json['installmentCount'] as num?)?.toInt(),
      installmentAmount: (json['installmentAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$PaymentModelImplToJson(_$PaymentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appointmentId': instance.appointmentId,
      'customerId': instance.customerId,
      'businessId': instance.businessId,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': _$PaymentStatusEnumMap[instance.status]!,
      'method': _$PaymentMethodEnumMap[instance.method]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'transactionId': instance.transactionId,
      'description': instance.description,
      'metadata': instance.metadata,
      'failureReason': instance.failureReason,
      'installmentCount': instance.installmentCount,
      'installmentAmount': instance.installmentAmount,
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.completed: 'completed',
  PaymentStatus.failed: 'failed',
  PaymentStatus.refunded: 'refunded',
  PaymentStatus.cancelled: 'cancelled',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.creditCard: 'creditCard',
  PaymentMethod.debitCard: 'debitCard',
  PaymentMethod.wallet: 'wallet',
  PaymentMethod.bankTransfer: 'bankTransfer',
  PaymentMethod.installment: 'installment',
};

_$CreatePaymentRequestImpl _$$CreatePaymentRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreatePaymentRequestImpl(
      appointmentId: json['appointmentId'] as String,
      amount: (json['amount'] as num).toDouble(),
      method: $enumDecode(_$PaymentMethodEnumMap, json['method']),
      description: json['description'] as String?,
      installmentCount: (json['installmentCount'] as num?)?.toInt(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$CreatePaymentRequestImplToJson(
        _$CreatePaymentRequestImpl instance) =>
    <String, dynamic>{
      'appointmentId': instance.appointmentId,
      'amount': instance.amount,
      'method': _$PaymentMethodEnumMap[instance.method]!,
      'description': instance.description,
      'installmentCount': instance.installmentCount,
      'metadata': instance.metadata,
    };

_$PaymentResponseImpl _$$PaymentResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentResponseImpl(
      paymentId: json['paymentId'] as String,
      status: $enumDecode(_$PaymentStatusEnumMap, json['status']),
      processedAt: DateTime.parse(json['processedAt'] as String),
      redirectUrl: json['redirectUrl'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$PaymentResponseImplToJson(
        _$PaymentResponseImpl instance) =>
    <String, dynamic>{
      'paymentId': instance.paymentId,
      'status': _$PaymentStatusEnumMap[instance.status]!,
      'processedAt': instance.processedAt.toIso8601String(),
      'redirectUrl': instance.redirectUrl,
      'message': instance.message,
    };

_$PaymentHistoryResponseImpl _$$PaymentHistoryResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentHistoryResponseImpl(
      payments: (json['payments'] as List<dynamic>)
          .map((e) => PaymentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num).toInt(),
      hasMore: json['hasMore'] as bool,
      currentPage: (json['currentPage'] as num).toInt(),
    );

Map<String, dynamic> _$$PaymentHistoryResponseImplToJson(
        _$PaymentHistoryResponseImpl instance) =>
    <String, dynamic>{
      'payments': instance.payments,
      'totalCount': instance.totalCount,
      'hasMore': instance.hasMore,
      'currentPage': instance.currentPage,
    };

_$RefundRequestImpl _$$RefundRequestImplFromJson(Map<String, dynamic> json) =>
    _$RefundRequestImpl(
      paymentId: json['paymentId'] as String,
      reason: json['reason'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$RefundRequestImplToJson(_$RefundRequestImpl instance) =>
    <String, dynamic>{
      'paymentId': instance.paymentId,
      'reason': instance.reason,
      'amount': instance.amount,
    };

_$InvoiceModelImpl _$$InvoiceModelImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceModelImpl(
      id: json['id'] as String,
      paymentId: json['paymentId'] as String,
      businessName: json['businessName'] as String,
      businessAddress: json['businessAddress'] as String,
      businessPhone: json['businessPhone'] as String,
      customerName: json['customerName'] as String,
      customerEmail: json['customerEmail'] as String,
      subtotal: (json['subtotal'] as num).toDouble(),
      taxAmount: (json['taxAmount'] as num).toDouble(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      issuedAt: DateTime.parse(json['issuedAt'] as String),
      notes: json['notes'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => InvoiceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$InvoiceModelImplToJson(_$InvoiceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paymentId': instance.paymentId,
      'businessName': instance.businessName,
      'businessAddress': instance.businessAddress,
      'businessPhone': instance.businessPhone,
      'customerName': instance.customerName,
      'customerEmail': instance.customerEmail,
      'subtotal': instance.subtotal,
      'taxAmount': instance.taxAmount,
      'totalAmount': instance.totalAmount,
      'issuedAt': instance.issuedAt.toIso8601String(),
      'notes': instance.notes,
      'items': instance.items,
    };

_$InvoiceItemImpl _$$InvoiceItemImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceItemImpl(
      serviceName: json['serviceName'] as String,
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: (json['unitPrice'] as num).toDouble(),
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$$InvoiceItemImplToJson(_$InvoiceItemImpl instance) =>
    <String, dynamic>{
      'serviceName': instance.serviceName,
      'quantity': instance.quantity,
      'unitPrice': instance.unitPrice,
      'discountAmount': instance.discountAmount,
      'totalPrice': instance.totalPrice,
    };

_$WalletModelImpl _$$WalletModelImplFromJson(Map<String, dynamic> json) =>
    _$WalletModelImpl(
      customerId: json['customerId'] as String,
      balance: (json['balance'] as num).toDouble(),
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => WalletTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$WalletModelImplToJson(_$WalletModelImpl instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'balance': instance.balance,
      'transactions': instance.transactions,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };

_$WalletTransactionImpl _$$WalletTransactionImplFromJson(
        Map<String, dynamic> json) =>
    _$WalletTransactionImpl(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      relatedPaymentId: json['relatedPaymentId'] as String?,
    );

Map<String, dynamic> _$$WalletTransactionImplToJson(
        _$WalletTransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'type': instance.type,
      'description': instance.description,
      'timestamp': instance.timestamp.toIso8601String(),
      'relatedPaymentId': instance.relatedPaymentId,
    };
