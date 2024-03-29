import '../../typedefs.dart';

abstract interface class Model {
  JsonMap toJson();
}

abstract interface class IdentifiableModel extends Model {
  int get id;

  DateTime get createDate;

  DateTime? get deleteDate;
}
