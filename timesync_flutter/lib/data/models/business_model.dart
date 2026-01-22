import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_model.freezed.dart';
part 'business_model.g.dart';

@freezed
class BusinessModel with _$BusinessModel {
  const factory BusinessModel({
    required String id,
    required String name,
    required String category,
    required String location,
    required String address,
    required String phone,
    required String email,
    required double rating,
    required int reviewCount,
    required String imageUrl,
    String? description,
    List<String>? gallery,
    Map<String, String>? workingHours,
    bool? isActive,
  }) = _BusinessModel;

  factory BusinessModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessModelFromJson(json);
}
