import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quiz_app/domain/field/field.dart';

part 'category_form_entity.freezed.dart';

@freezed
class CategoryFormEntity with _$CategoryFormEntity {
  const CategoryFormEntity._();
  const factory CategoryFormEntity({
    required Field id,
    required Field name,
    required Field description,
    String? imagePath,
  }) = _CategoryFormEntity;

  factory CategoryFormEntity.empty() => const CategoryFormEntity(
        id: Field(value: ""),
        name: Field(value: ""),
        description: Field(value: ""),
      );
  bool get isValid => true;
}
