import { MigrationInterface, QueryRunner } from "typeorm";

export class SourcePurposeIndex1723915912753 implements MigrationInterface {
    name = 'SourcePurposeIndex1723915912753'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE INDEX "IDX_4000fb56b460ba851e895dcf3f" ON "transactions" ("sourceOrPurpose") `);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`DROP INDEX "public"."IDX_4000fb56b460ba851e895dcf3f"`);
    }

}
