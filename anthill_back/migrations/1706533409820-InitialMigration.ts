import { MigrationInterface, QueryRunner } from "typeorm";

export class InitialMigration1706533409820 implements MigrationInterface {
    name = 'InitialMigration1706533409820'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TYPE "public"."users_role_enum" AS ENUM('accountant', 'volunteer', 'admin')`);
        await queryRunner.query(`CREATE TABLE "users" ("id" SERIAL NOT NULL, "createDate" TIMESTAMP NOT NULL DEFAULT now(), "deleteDate" TIMESTAMP, "name" character varying NOT NULL, "email" character varying NOT NULL, "role" "public"."users_role_enum" NOT NULL DEFAULT 'volunteer', "passwordHash" character varying NOT NULL, CONSTRAINT "UQ_97672ac88f789774dd47f7c8be3" UNIQUE ("email"), CONSTRAINT "PK_a3ffb1c0c8416b9fc6f907b7433" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "log_entries" ("id" SERIAL NOT NULL, "createDate" TIMESTAMP NOT NULL DEFAULT now(), "deleteDate" TIMESTAMP, "action" character varying NOT NULL, "moduleName" character varying NOT NULL, "resourceAffected" character varying, "targetEntityId" integer, "jsonPayload" jsonb, "userId" integer NOT NULL, CONSTRAINT "PK_b226cc4051321f12106771581e0" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE TABLE "transactions" ("id" SERIAL NOT NULL, "createDate" TIMESTAMP NOT NULL DEFAULT now(), "deleteDate" TIMESTAMP, "amount" numeric(10,2) NOT NULL, "isIncome" boolean NOT NULL, "sourceOrPurpose" character varying NOT NULL, "note" character varying NOT NULL DEFAULT '', "userId" integer NOT NULL, CONSTRAINT "PK_a219afd8dd77ed80f5a862f1db9" PRIMARY KEY ("id"))`);
        await queryRunner.query(`ALTER TABLE "log_entries" ADD CONSTRAINT "FK_6dfb67abaab46cdd5ab9f35e32e" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE`);
        await queryRunner.query(`ALTER TABLE "transactions" ADD CONSTRAINT "FK_6bb58f2b6e30cb51a6504599f41" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE`);

        // the default admin credentials must be changed as soon as possible
        await queryRunner.query(`INSERT INTO users VALUES (1, CURRENT_TIMESTAMP, null, 'admin', 'admin', 'admin', '$2b$10$giu25FlGLZXtHxwAzR5kpuAiTghC0HN1BUvO/ds9b.j1Q6aOsPd.W')`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "transactions" DROP CONSTRAINT "FK_6bb58f2b6e30cb51a6504599f41"`);
        await queryRunner.query(`ALTER TABLE "log_entries" DROP CONSTRAINT "FK_6dfb67abaab46cdd5ab9f35e32e"`);
        await queryRunner.query(`DROP TABLE "transactions"`);
        await queryRunner.query(`DROP TABLE "log_entries"`);
        await queryRunner.query(`DROP TABLE "users"`);
        await queryRunner.query(`DROP TYPE "public"."users_role_enum"`);
    }

}
