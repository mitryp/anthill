import { UserRole } from '../../users/data/entities/user.entity';
import { Reflector } from '@nestjs/core';

export const RequireRoles = Reflector.createDecorator<UserRole[]>();
