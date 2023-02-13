-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema maks_mvcprojets
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema maks_mvcprojets
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `maks_mvcprojets` DEFAULT CHARACTER SET utf8 ;
USE `maks_mvcprojets` ;

-- -----------------------------------------------------
-- Table `maks_mvcprojets`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `maks_mvcprojets`.`user` ;

CREATE TABLE IF NOT EXISTS `maks_mvcprojets`.`user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `usermail` VARCHAR(200) NOT NULL,
  `userpwd` VARCHAR(255) NOT NULL,
  `userscreen` VARCHAR(400) NOT NULL,
  `useruniqid` VARCHAR(45) NULL COMMENT '\'ident uniq\'',
  `actif` TINYINT UNSIGNED NULL DEFAULT 0 COMMENT '0 => inactif\n1 => actif\n2 => banni',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  UNIQUE INDEX `usermail_UNIQUE` (`usermail` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maks_mvcprojets`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `maks_mvcprojets`.`post` ;

CREATE TABLE IF NOT EXISTS `maks_mvcprojets`.`post` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `content` TEXT NOT NULL,
  `datecreate` DATETIME NULL DEFAULT now(),
  `visible` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_article_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_article_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `maks_mvcprojets`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maks_mvcprojets`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `maks_mvcprojets`.`category` ;

CREATE TABLE IF NOT EXISTS `maks_mvcprojets`.`category` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NOT NULL,
  `content` VARCHAR(800) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maks_mvcprojets`.`category_has_post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `maks_mvcprojets`.`category_has_post` ;

CREATE TABLE IF NOT EXISTS `maks_mvcprojets`.`category_has_post` (
  `category_id` INT UNSIGNED NOT NULL,
  `post_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`category_id`, `post_id`),
  INDEX `fk_category_has_post_post1_idx` (`post_id` ASC) VISIBLE,
  INDEX `fk_category_has_post_category1_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_category_has_post_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `maks_mvcprojets`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_category_has_post_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `maks_mvcprojets`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;