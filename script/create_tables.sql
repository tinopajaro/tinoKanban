
-- BEGIN et COMMIT englobe ce qu'on appelle une transaction
-- en cas d'erreur dans une transaction, tout ce qui a été fait est annulé
BEGIN;

DROP TABLE IF EXISTS "list","card","tag","card_has_tag";

CREATE TABLE "list"(
    "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    "name" TEXT NOT NULL DEFAULT 'Liste vide',
    "position" INT NOT NULL,
    -- Sequelize, par défaut, utilise deux colonnes pour gérer la date de création et les mises à jour 
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    "updated_at" TIMESTAMPTZ
);

CREATE TABLE "card"(
    "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    "name" TEXT NOT NULL DEFAULT 'Carte vide',
    "position" INT NOT NULL,
    "color" TEXT NOT NULL DEFAULT '#FFF',
    -- le ON DELETE CASCADE permet d'indiquer à notre système que lorsqu'une List est supprimée, on supprime les cartes associées. S'il n'est pas présent, nous aurons une erreur à la suppression de la liste
    "list_id" INT NOT NULL REFERENCES list("id") ON DELETE CASCADE,
    -- Sequelize, par défaut, utilise deux colonnes pour gérer la date de création et les mises à jour 
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    "updated_at" TIMESTAMPTZ
);

CREATE TABLE "tag"(
    "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    "name" TEXT NOT NULL DEFAULT 'Carte vide',
    "color" TEXT NOT NULL DEFAULT '#FFF',
    -- Sequelize, par défaut, utilise deux colonnes pour gérer la date de création et les mises à jour 
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    "updated_at" TIMESTAMPTZ
);

CREATE TABLE "card_has_tag"(
    -- si je supprime une carte, je ne veux pas supprimer le tag
    -- si je supprime un tag, je ne veux pas supprimer une carte
    -- on ne va supprimer au final que l'association entre les deux
    "card_id" INT NOT NULL REFERENCES card("id") ON DELETE CASCADE,
    "tag_id" INT NOT NULL REFERENCES tag("id") ON DELETE CASCADE,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);



COMMIT;