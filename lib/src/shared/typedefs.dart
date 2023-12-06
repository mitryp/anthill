typedef JsonMap = Map<String, Object?>;

typedef QueryParams = JsonMap;

typedef FromJsonDecoder<M> = M Function(JsonMap json);
