import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'suggestions_dto.freezed.dart';

part 'suggestions_dto.g.dart';

@freezed
class SuggestionsDto with _$SuggestionsDto {
  const factory SuggestionsDto({
    @Default(ISetConst({})) ISet<String> suggestions,
  }) = _SuggestionsDto;

  factory SuggestionsDto.fromJson(Map<String, Object?> json) =>
      _$SuggestionsDtoFromJson(json);
}
