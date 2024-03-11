import { AuthGuard } from '@nestjs/passport';
import { ExecutionContext } from '@nestjs/common';

export class LocalAuthGuard extends AuthGuard('local') {
  async canActivate(context: ExecutionContext): Promise<any> {
    const result = await super.canActivate(context);

    await super.logIn(context.switchToHttp().getRequest());

    return result;
  }
}
