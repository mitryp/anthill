import { MigrationInterface, QueryRunner } from "typeorm";

export class HumanitarianAidAccounting1724151709150 implements MigrationInterface {
    name = 'HumanitarianAidAccounting1724151709150'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`CREATE TABLE "sent_aid" ("id" SERIAL NOT NULL, "createDate" TIMESTAMP NOT NULL DEFAULT now(), "deleteDate" TIMESTAMP, "purpose" character varying NOT NULL, "quantity" integer NOT NULL, "note" character varying NOT NULL DEFAULT '', "shipmentMethod" character varying NOT NULL, "reportProvided" boolean NOT NULL, "userId" integer NOT NULL, CONSTRAINT "PK_3a8a9916057df85fc74ebef5fc0" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE INDEX "IDX_1aa4b13798600d4897d6eb22bc" ON "sent_aid" ("purpose") `);
        await queryRunner.query(`CREATE INDEX "IDX_a60cd89fd1478e62714cb335b9" ON "sent_aid" ("shipmentMethod") `);
        await queryRunner.query(`CREATE TABLE "received_aid" ("id" SERIAL NOT NULL, "createDate" TIMESTAMP NOT NULL DEFAULT now(), "deleteDate" TIMESTAMP, "source" character varying NOT NULL, "quantity" integer NOT NULL, "note" character varying NOT NULL DEFAULT '', "userId" integer NOT NULL, CONSTRAINT "PK_b40701967bbd6fe300b8f7d90bb" PRIMARY KEY ("id"))`);
        await queryRunner.query(`CREATE INDEX "IDX_56a088b8f31868a37e38f1f05a" ON "received_aid" ("source") `);
        await queryRunner.query(`ALTER TABLE "sent_aid" ADD CONSTRAINT "FK_0c075d939621b8a8abf03743c79" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE`);
        await queryRunner.query(`ALTER TABLE "received_aid" ADD CONSTRAINT "FK_0c97c6f21047db00a920be6972e" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "received_aid" DROP CONSTRAINT "FK_0c97c6f21047db00a920be6972e"`);
        await queryRunner.query(`ALTER TABLE "sent_aid" DROP CONSTRAINT "FK_0c075d939621b8a8abf03743c79"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_56a088b8f31868a37e38f1f05a"`);
        await queryRunner.query(`DROP TABLE "received_aid"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_a60cd89fd1478e62714cb335b9"`);
        await queryRunner.query(`DROP INDEX "public"."IDX_1aa4b13798600d4897d6eb22bc"`);
        await queryRunner.query(`DROP TABLE "sent_aid"`);
    }

}
