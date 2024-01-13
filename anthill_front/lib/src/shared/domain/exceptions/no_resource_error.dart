class NoResourceError extends Error {
  final String resourceName;
  final Object? id;

  NoResourceError(this.resourceName, {Object? withId}) : id = withId;

  @override
  String toString() {
    final id = this.id;

    return 'NoResourceError<$resourceName>${id == null ? '' : ' with id $id'}';
  }
}
