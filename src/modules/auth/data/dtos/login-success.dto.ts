import { UserReadDto } from '../../../users/data/dtos/user.read.dto';

export class LoginSuccessDto {
  accessToken: string;
  user: UserReadDto;
}
