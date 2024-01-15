library shared_http;

export 'application/http/collection_controller_mixin.dart' show CollectionControllerMixin;
export 'application/http/dio_error_interceptor.dart' show interceptDioError, isDioError;
export 'application/http/http_service.dart' show HttpService, HttpWriteMixin;
export 'application/providers/http_client_provider.dart' show httpClientProvider;
export 'application/providers/paginate_config_provider.dart' show paginateConfigProvider;
export 'domain/dtos/server_error_dto.dart' show ServerErrorDto;
export 'domain/exceptions/no_resource_error.dart' show NoResourceError;
export 'domain/interfaces/model.dart' show Model, IdentifiableModel;
export 'presentation/utils/can_control_collection.dart' show CanControlCollection;
export 'utils/model_from_router_state.dart' show modelFromRouterState;
