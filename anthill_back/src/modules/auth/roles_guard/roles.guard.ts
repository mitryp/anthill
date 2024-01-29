import { Observable } from 'rxjs';
import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { Request } from 'express';
import { JwtPayloadDto } from '../data/dtos/jwt.payload.dto';
import { UserRole } from '../../users/data/entities/user.entity';

@Injectable()
export class RolesGuard implements CanActivate {
  private readonly requiredRoles: UserRole[];

  constructor(...requiredRoles: UserRole[]) {
    this.requiredRoles = requiredRoles;
  }

  canActivate(context: ExecutionContext): boolean | Promise<boolean> | Observable<boolean> {
    if (!this.requiredRoles) {
      return true;
    }

    const req = context.switchToHttp().getRequest<Request>();
    const user = req.user as JwtPayloadDto;

    return this.requiredRoles.includes(user.role);
  }
}
