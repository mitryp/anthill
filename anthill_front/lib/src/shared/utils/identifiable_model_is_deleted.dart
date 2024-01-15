import '../domain/interfaces/model.dart';

extension IdentifiableModelIsDeleted on IdentifiableModel {
  bool get isDeleted => deleteDate != null;
}
