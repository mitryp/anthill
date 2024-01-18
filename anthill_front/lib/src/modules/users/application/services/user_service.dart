import '../../../../shared/http.dart';
import '../../domain/dtos/user_create_dto.dart';
import '../../domain/dtos/user_read_dto.dart';

const usersResourceName = 'users';

class UserService extends HttpService<UserReadDto>
    with HttpWriteMixin<UserReadDto, UserCreateDto, UserCreateDto> {
  const UserService({required super.client})
      : super(decoder: UserReadDto.fromJson, apiPrefix: usersResourceName);
}
