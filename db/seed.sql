-- MySQL Script generated by MySQL Workbench
-- Sat Feb 18 22:31:44 2017
-- Model: Interactive Conversation Archive    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

-- -----------------------------------------------------
-- Schema ica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ica` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `ica` ;

-- -----------------------------------------------------
-- Table `ica`.`accounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ica`.`accounts` ;

CREATE TABLE IF NOT EXISTS `ica`.`accounts` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `identifier` VARCHAR(100) NOT NULL,
  `lastmodified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ica`.`contents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ica`.`contents` ;

CREATE TABLE IF NOT EXISTS `ica`.`contents` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `author_id` INT UNSIGNED NOT NULL,
  `authored` TIMESTAMP NOT NULL DEFAULT '1970-01-01 00:00:00',
  `lastmodified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_contents_accounts1_idx` (`author_id` ASC),
  CONSTRAINT `fk_contents_accounts1`
    FOREIGN KEY (`author_id`)
    REFERENCES `ica`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ica`.`jointsources`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ica`.`jointsources` ;

CREATE TABLE IF NOT EXISTS `ica`.`jointsources` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_id` INT UNSIGNED NOT NULL,
  `author_id` INT UNSIGNED NOT NULL,
  `authored` TIMESTAMP NOT NULL DEFAULT '1970-01-01 00:00:00',
  `lastmodified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_jointsources_accounts1_idx` (`author_id` ASC),
  INDEX `fk_jointsources_contents1_idx` (`content_id` ASC),
  CONSTRAINT `fk_jointsources_accounts1`
    FOREIGN KEY (`author_id`)
    REFERENCES `ica`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jointsources_contents1`
    FOREIGN KEY (`content_id`)
    REFERENCES `ica`.`contents` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ica`.`states`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ica`.`states` ;

CREATE TABLE IF NOT EXISTS `ica`.`states` (
  `state` TINYINT UNSIGNED NOT NULL,
  `name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`state`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ica`.`jointsources_states`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ica`.`jointsources_states` ;

CREATE TABLE IF NOT EXISTS `ica`.`jointsources_states` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `jointsource_id` INT UNSIGNED NOT NULL,
  `author_id` INT UNSIGNED NOT NULL,
  `state` TINYINT UNSIGNED NOT NULL,
  `authored` TIMESTAMP NOT NULL DEFAULT '1970-01-01 00:00:00',
  `lastmodified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `fk_jointsources_states_jointsources1_idx` (`jointsource_id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_jointsources_states_accounts1_idx` (`author_id` ASC),
  INDEX `fk_jointsources_states_states1_idx` (`state` ASC),
  CONSTRAINT `fk_jointsources_states_jointsources1`
    FOREIGN KEY (`jointsource_id`)
    REFERENCES `ica`.`jointsources` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jointsources_states_accounts1`
    FOREIGN KEY (`author_id`)
    REFERENCES `ica`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jointsources_states_states1`
    FOREIGN KEY (`state`)
    REFERENCES `ica`.`states` (`state`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ica`.`types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ica`.`types` ;

CREATE TABLE IF NOT EXISTS `ica`.`types` (
  `type` TINYINT UNSIGNED NOT NULL,
  `name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ica`.`sources`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ica`.`sources` ;

CREATE TABLE IF NOT EXISTS `ica`.`sources` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `jointsource_id` INT UNSIGNED NOT NULL,
  `content_id` INT UNSIGNED NOT NULL,
  `author_id` INT UNSIGNED NOT NULL,
  `type` TINYINT UNSIGNED NOT NULL,
  `authored` TIMESTAMP NOT NULL DEFAULT '1970-01-01 00:00:00',
  `lastmodified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_sources_accounts1_idx` (`author_id` ASC),
  INDEX `fk_sources_consts_sourcetypes1_idx` (`type` ASC),
  INDEX `fk_sources_jointsources1_idx` (`jointsource_id` ASC),
  INDEX `fk_sources_contents1_idx` (`content_id` ASC),
  CONSTRAINT `fk_sources_accounts1`
    FOREIGN KEY (`author_id`)
    REFERENCES `ica`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sources_consts_sourcetypes1`
    FOREIGN KEY (`type`)
    REFERENCES `ica`.`types` (`type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sources_jointsources1`
    FOREIGN KEY (`jointsource_id`)
    REFERENCES `ica`.`jointsources` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sources_contents1`
    FOREIGN KEY (`content_id`)
    REFERENCES `ica`.`contents` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ica`.`sources_states`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ica`.`sources_states` ;

CREATE TABLE IF NOT EXISTS `ica`.`sources_states` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `author_id` INT UNSIGNED NOT NULL,
  `source_id` INT UNSIGNED NOT NULL,
  `state` TINYINT UNSIGNED NOT NULL,
  `authored` TIMESTAMP NOT NULL DEFAULT '1970-01-01 00:00:00',
  `lastmodified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_sources_states_accounts1_idx` (`author_id` ASC),
  INDEX `fk_sources_states_states1_idx` (`state` ASC),
  INDEX `fk_sources_states_sources1_idx` (`source_id` ASC),
  CONSTRAINT `fk_sources_states_accounts1`
    FOREIGN KEY (`author_id`)
    REFERENCES `ica`.`accounts` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sources_states_states1`
    FOREIGN KEY (`state`)
    REFERENCES `ica`.`states` (`state`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sources_states_sources1`
    FOREIGN KEY (`source_id`)
    REFERENCES `ica`.`sources` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ica`.`langs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ica`.`langs` ;

CREATE TABLE IF NOT EXISTS `ica`.`langs` (
  `lang` INT UNSIGNED NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`lang`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ica`.`files`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ica`.`files` ;

CREATE TABLE IF NOT EXISTS `ica`.`files` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uploader_id` INT UNSIGNED NOT NULL,
  `path` VARCHAR(30) NOT NULL,
  `mime` VARCHAR(20) NOT NULL,
  `size` INT UNSIGNED NOT NULL,
  `lastmodified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_files_accounts1_idx` (`uploader_id` ASC),
  CONSTRAINT `fk_files_accounts1`
    FOREIGN KEY (`uploader_id`)
    REFERENCES `ica`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ica`.`contents_langs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ica`.`contents_langs` ;

CREATE TABLE IF NOT EXISTS `ica`.`contents_langs` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_id` INT UNSIGNED NOT NULL,
  `author_id` INT UNSIGNED NOT NULL,
  `lang` INT UNSIGNED NOT NULL,
  `authored` TIMESTAMP NOT NULL DEFAULT '1970-01-01 00:00:00',
  `lastmodified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_contents_langs_accounts1_idx` (`author_id` ASC),
  INDEX `fk_contents_langs_langs1_idx` (`lang` ASC),
  INDEX `fk_contents_langs_contents1_idx` (`content_id` ASC),
  CONSTRAINT `fk_contents_langs_accounts1`
    FOREIGN KEY (`author_id`)
    REFERENCES `ica`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contents_langs_langs1`
    FOREIGN KEY (`lang`)
    REFERENCES `ica`.`langs` (`lang`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contents_langs_contents1`
    FOREIGN KEY (`content_id`)
    REFERENCES `ica`.`contents` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ica`.`contents_langs_revs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ica`.`contents_langs_revs` ;

CREATE TABLE IF NOT EXISTS `ica`.`contents_langs_revs` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `lang_id` INT UNSIGNED NOT NULL,
  `author_id` INT UNSIGNED NOT NULL,
  `content` TEXT NOT NULL,
  `authored` TIMESTAMP NOT NULL DEFAULT '1970-01-01 00:00:00',
  `lastmodified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_contents_langs_revs_accounts1_idx` (`author_id` ASC),
  INDEX `fk_contents_langs_revs_langs1_idx` (`lang_id` ASC),
  CONSTRAINT `fk_contents_langs_revs_accounts1`
    FOREIGN KEY (`author_id`)
    REFERENCES `ica`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contents_langs_revs_langs1`
    FOREIGN KEY (`lang_id`)
    REFERENCES `ica`.`contents_langs` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ica`.`contents_langs_states`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ica`.`contents_langs_states` ;

CREATE TABLE IF NOT EXISTS `ica`.`contents_langs_states` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `lang_id` INT UNSIGNED NOT NULL,
  `author_id` INT UNSIGNED NOT NULL,
  `state` TINYINT UNSIGNED NOT NULL,
  `authored` TIMESTAMP NOT NULL DEFAULT '1970-01-01 00:00:00',
  `lastmodified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_contents_langs_states_accounts1_idx` (`author_id` ASC),
  INDEX `fk_contents_langs_states_states1_idx` (`state` ASC),
  INDEX `fk_contents_langs_states_langs1_idx` (`lang_id` ASC),
  CONSTRAINT `fk_contents_langs_states_accounts1`
    FOREIGN KEY (`author_id`)
    REFERENCES `ica`.`accounts` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contents_langs_states_states1`
    FOREIGN KEY (`state`)
    REFERENCES `ica`.`states` (`state`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contents_langs_states_langs1`
    FOREIGN KEY (`lang_id`)
    REFERENCES `ica`.`contents_langs` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `ica` ;

-- -----------------------------------------------------
-- Placeholder table for view `ica`.`jointsources_state_latest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ica`.`jointsources_state_latest` (`jointsource_id` INT, `state_id` INT, `state` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ica`.`jointsources_summary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ica`.`jointsources_summary` (`jointsource_id` INT, `jointsource_state` INT, `content_id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ica`.`sources_state_latest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ica`.`sources_state_latest` (`source_id` INT, `state_id` INT, `state` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ica`.`sources_summary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ica`.`sources_summary` (`source_id` INT, `jointsource_id` INT, `source_type` INT, `source_state` INT, `content_id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ica`.`contents_langs_summary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ica`.`contents_langs_summary` (`content_id` INT, `lang_id` INT, `lang` INT, `state_id` INT, `state` INT, `rev_id` INT, `rev_content` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ica`.`contents_langs_rev_latest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ica`.`contents_langs_rev_latest` (`lang_id` INT, `rev_id` INT, `rev_content` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ica`.`contents_langs_state_latest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ica`.`contents_langs_state_latest` (`lang_id` INT, `state_id` INT, `state` INT);

-- -----------------------------------------------------
-- Placeholder table for view `ica`.`jointsources_summary_extended`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ica`.`jointsources_summary_extended` (`jointsource_id` INT, `jointsource_state` INT);

-- -----------------------------------------------------
-- View `ica`.`jointsources_state_latest`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ica`.`jointsources_state_latest` ;
DROP TABLE IF EXISTS `ica`.`jointsources_state_latest`;
USE `ica`;
CREATE  OR REPLACE VIEW `jointsources_state_latest` AS
SELECT
	tbl_jointsource.id AS jointsource_id,
	tbl_state.id AS state_id,
    tbl_state.state AS state
FROM
	`jointsources` AS tbl_jointsource
LEFT JOIN `jointsources_states` AS tbl_state
	ON tbl_jointsource.id = tbl_state.jointsource_id
GROUP BY jointsource_id;

-- -----------------------------------------------------
-- View `ica`.`jointsources_summary`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ica`.`jointsources_summary` ;
DROP TABLE IF EXISTS `ica`.`jointsources_summary`;
USE `ica`;
CREATE  OR REPLACE VIEW `jointsources_summary` AS
SELECT
	tbl_jointsource.id AS jointsource_id,
    tbl_jointsource_state.state AS jointsource_state,
	tbl_jointsource.content_id AS content_id
FROM `jointsources` AS tbl_jointsource
LEFT JOIN `jointsources_state_latest` AS tbl_jointsource_state
	ON tbl_jointsource_state.jointsource_id = tbl_jointsource.id;

-- -----------------------------------------------------
-- View `ica`.`sources_state_latest`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ica`.`sources_state_latest` ;
DROP TABLE IF EXISTS `ica`.`sources_state_latest`;
USE `ica`;
CREATE  OR REPLACE VIEW `sources_state_latest` AS
SELECT
	tbl_source.id AS source_id,
	tbl_state.id AS state_id,
    tbl_state.state AS state
FROM
	`sources` AS tbl_source
LEFT JOIN `sources_states` AS tbl_state
	ON tbl_source.id = tbl_state.source_id
GROUP BY source_id;

-- -----------------------------------------------------
-- View `ica`.`sources_summary`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ica`.`sources_summary` ;
DROP TABLE IF EXISTS `ica`.`sources_summary`;
USE `ica`;
CREATE  OR REPLACE VIEW `sources_summary` AS
SELECT
	tbl_source.id AS source_id,
    tbl_source.jointsource_id AS jointsource_id,
    tbl_source.type AS source_type,
    tbl_source_state.state AS source_state,
    tbl_source.content_id AS content_id
FROM `sources` AS tbl_source
LEFT JOIN `sources_state_latest` AS tbl_source_state
ON tbl_source_state.source_id = tbl_source.id;

-- -----------------------------------------------------
-- View `ica`.`contents_langs_summary`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ica`.`contents_langs_summary` ;
DROP TABLE IF EXISTS `ica`.`contents_langs_summary`;
USE `ica`;
CREATE  OR REPLACE VIEW `contents_langs_summary` AS
SELECT
	tbl_lang.content_id AS content_id,
    tbl_lang.id AS lang_id,
    tbl_lang.lang AS lang,
    tbl_state.state_id AS state_id,
    tbl_state.state AS state,
    tbl_rev.rev_id AS rev_id,
    tbl_rev.rev_content AS rev_content
FROM `contents_langs` AS tbl_lang
LEFT JOIN `contents_langs_state_latest` AS tbl_state
ON tbl_state.lang_id = tbl_lang.id
LEFT JOIN `contents_langs_rev_latest` AS tbl_rev
ON tbl_rev.lang_id = tbl_lang.id;

-- -----------------------------------------------------
-- View `ica`.`contents_langs_rev_latest`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ica`.`contents_langs_rev_latest` ;
DROP TABLE IF EXISTS `ica`.`contents_langs_rev_latest`;
USE `ica`;
CREATE  OR REPLACE VIEW `contents_langs_rev_latest` AS
SELECT
	tbl_lang.id AS lang_id,
    tbl_rev.id AS rev_id,
    tbl_rev.content AS rev_content
FROM `contents_langs` AS tbl_lang
LEFT JOIN `contents_langs_revs` AS tbl_rev
	ON tbl_lang.id = tbl_rev.lang_id;


-- -----------------------------------------------------
-- View `ica`.`contents_langs_state_latest`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ica`.`contents_langs_state_latest` ;
DROP TABLE IF EXISTS `ica`.`contents_langs_state_latest`;
USE `ica`;
CREATE  OR REPLACE VIEW `contents_langs_state_latest` AS
SELECT
	tbl_lang.id AS lang_id,
    tbl_state.id AS state_id,
    tbl_state.state AS state
FROM `contents_langs` AS tbl_lang
LEFT JOIN `contents_langs_states` AS tbl_state
	ON tbl_lang.id = tbl_state.lang_id;


-- -----------------------------------------------------
-- View `ica`.`jointsources_summary_extended`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ica`.`jointsources_summary_extended` ;
DROP TABLE IF EXISTS `ica`.`jointsources_summary_extended`;
USE `ica`;
CREATE  OR REPLACE VIEW `jointsources_summary_extended` AS
SELECT
	tbl_jointsource.jointsource_id,
    tbl_jointsource.jointsource_state,
	tbl_lang.*
FROM `jointsources_summary` AS tbl_jointsource
LEFT JOIN `contents_langs_summary` AS tbl_lang
ON tbl_lang.content_id = tbl_jointsource.content_id;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `ica`.`states`
-- -----------------------------------------------------
START TRANSACTION;
USE `ica`;
INSERT INTO `ica`.`states` (`state`, `name`) VALUES (1, 'published');
INSERT INTO `ica`.`states` (`state`, `name`) VALUES (2, 'unpublished');
INSERT INTO `ica`.`states` (`state`, `name`) VALUES (0, 'undefined');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ica`.`types`
-- -----------------------------------------------------
START TRANSACTION;
USE `ica`;
INSERT INTO `ica`.`types` (`type`, `name`) VALUES (1, 'text');
INSERT INTO `ica`.`types` (`type`, `name`) VALUES (2, 'audio');
INSERT INTO `ica`.`types` (`type`, `name`) VALUES (3, 'image');
INSERT INTO `ica`.`types` (`type`, `name`) VALUES (4, 'video');
INSERT INTO `ica`.`types` (`type`, `name`) VALUES (0, 'undefined');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ica`.`langs`
-- -----------------------------------------------------
START TRANSACTION;
USE `ica`;
INSERT INTO `ica`.`langs` (`lang`, `name`) VALUES (0, 'undefined');

COMMIT;

