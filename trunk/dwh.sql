SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

-- DROP SCHEMA IF EXISTS `carddb` ;
-- CREATE SCHEMA IF NOT EXISTS `carddb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
-- USE `carddb` ;

-- -----------------------------------------------------
-- Table `ProductType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProductType` ;

CREATE  TABLE IF NOT EXISTS `ProductType` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL ,
  `description` TEXT NULL ,
  `abreviation` VARCHAR(10) NULL ,
  `issue_date_from` DATE NULL ,
  `issue_date_to` DATE NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
COMMENT = 'Tabulka typov kariet';


-- -----------------------------------------------------
-- Table `FacilityType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FacilityType` ;

CREATE  TABLE IF NOT EXISTS `FacilityType` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL ,
  `description` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
COMMENT = 'Tabulka typov zariadeni';


-- -----------------------------------------------------
-- Table `Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Address` ;

CREATE  TABLE IF NOT EXISTS `Address` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `address_city` VARCHAR(45) NULL ,
  `address_street` VARCHAR(45) NULL ,
  `address_state` VARCHAR(45) NULL ,
  `address_zip` VARCHAR(45) NULL ,
  `address_region` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Facility`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Facility` ;

CREATE  TABLE IF NOT EXISTS `Facility` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL ,
  `description` TEXT NULL ,
  `FacilityType_id` INT NULL ,
  `Address_id` INT NULL ,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'Jednotlive zariadenia jedalen,kniznica a pod';


-- -----------------------------------------------------
-- Table `OwnerRole`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OwnerRole` ;

CREATE  TABLE IF NOT EXISTS `OwnerRole` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL ,
  `description` TEXT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
COMMENT = 'Tabukla roli drzitela klienta';


-- -----------------------------------------------------
-- Table `CardOwner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CardOwner` ;

CREATE  TABLE IF NOT EXISTS `CardOwner` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `first_name` VARCHAR(45) NULL ,
  `last_name` VARCHAR(45) NULL ,
  `title_before_name` VARCHAR(45) NULL ,
  `title_after_name` VARCHAR(45) NULL ,
  `date_of_birth` DATE NULL ,
  `sex` INT NULL COMMENT 'ciselnik' ,
  `birth_place` VARCHAR(45) NULL ,
  `birth_number` VARCHAR(45) NULL ,
  `id_card_number` VARCHAR(45) NULL ,
  `id_card_type` INT NULL ,
  `photo` VARCHAR(45) NULL ,
  `note` VARCHAR(255) NULL ,
  `OwnerRole_id` INT NULL ,
  `Address_id` INT NULL ,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'Tabulka drzitelov kariet';


-- -----------------------------------------------------
-- Table `Organization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Organization` ;

CREATE  TABLE IF NOT EXISTS `Organization` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL ,
  `description` TEXT NULL ,
  `Address_id` INT NULL ,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'Tabulka organizacii (fakulta,dekanat  a pod.)';


-- -----------------------------------------------------
-- Table `Card`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Card` ;

CREATE  TABLE IF NOT EXISTS `Card` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `card_number` VARCHAR(20) NULL ,
  `serial_number` VARCHAR(45) NULL ,
  `validity_date_from` DATE NULL ,
  `validity_date_to` DATE NULL ,
  `sale_date` DATE NULL ,
  `void_date` DATE NULL ,
  `Facility_id` INT NULL ,
  `CardOwner_id` INT NULL ,
  `ProductType_id` INT NULL ,
  `Organization_id` INT NULL ,
  `cantine_credit` FLOAT NULL ,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'Tabulka kariet';


-- -----------------------------------------------------
-- Table `ProlongationStamp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProlongationStamp` ;

CREATE  TABLE IF NOT EXISTS `ProlongationStamp` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `stamp_number` VARCHAR(45) NULL ,
  `date_of_sale` VARCHAR(45) NULL ,
  `validity_date_from` DATE NULL ,
  `validity_date_to` DATE NULL ,
  `ProductType_id` INT NULL ,
  `Card_id` INT UNSIGNED NULL ,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'Tabulka prolongacnych znamok';


-- -----------------------------------------------------
-- Table `Exemplar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Exemplar` ;

CREATE  TABLE IF NOT EXISTS `Exemplar` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(45) NULL ,
  `ISBN` VARCHAR(45) NULL ,
  `langugage` VARCHAR(45) NULL ,
  `issue_date` DATE NULL ,
  `publisher` VARCHAR(45) NULL ,
  `authors` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Borrowing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Borrowing` ;

CREATE  TABLE IF NOT EXISTS `Borrowing` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `borrowing_date` DATE NULL ,
  `returning_date` DATE NULL ,
  `note` VARCHAR(45) NULL ,
  `Card_id` INT UNSIGNED NULL ,
  `state` INT NULL ,
  `Exemplar_id` INT NULL ,
  `Facility_id` INT NULL ,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Food`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Food` ;

CREATE  TABLE IF NOT EXISTS `Food` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(45) NULL ,
  `weight` INT NULL ,
  `buy_price` REAL NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Order` ;

CREATE  TABLE IF NOT EXISTS `Order` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `time` DATETIME NULL ,
  `Facility_id` INT NULL ,
  `Card_id` INT UNSIGNED NULL ,
  `Food_id` INT NULL ,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Date`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Date` ;

CREATE  TABLE IF NOT EXISTS `Date` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `Day` INT NULL ,
  `Week` INT NULL ,
  `Month` INT NULL ,
  `Semester` INT NULL ,
  `Year` INT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodSale`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FoodSale` ;

CREATE  TABLE IF NOT EXISTS `FoodSale` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `sale_price` REAL NULL ,
  `profit` REAL NULL ,
  `Food_id` INT NULL ,
  `Facility_id` INT NULL ,
  `Date_id` INT NULL ,
  `CardOwner_id` INT NULL ,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


CREATE  TABLE IF NOT EXISTS `Address` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `address_city` VARCHAR(45) NULL ,
  `address_street` VARCHAR(45) NULL ,
  `address_state` VARCHAR(45) NULL ,
  `address_zip` VARCHAR(45) NULL ,
  `address_region` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Data for table `Address`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;

INSERT INTO `Address` (`id`, `address_city`, `address_street`, `address_state`, `address_zip`, `address_region`) VALUES ('1', 'Bratislava', 'Ilkovicova 3', 'Slovakia', '842 16', 'Bratislavsky kraj');

COMMIT;

-- -----------------------------------------------------
-- Data for table `ProductType`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;

INSERT INTO `ProductType` (`id`, `name`, `description`, `abreviation`, `issue_date_from`, `issue_date_to`) VALUES ('1', 'Medzinarodny preukaz studenta ISIC', NULL, 'ISIC', '2000-01-01', '2012-01-01');
INSERT INTO `ProductType` (`id`, `name`, `description`, `abreviation`, `issue_date_from`, `issue_date_to`) VALUES ('2', 'Medzinarodny preukaz ITIC', NULL, 'ITIC', '2000-01-01', '2015-01-01');

COMMIT;

-- -----------------------------------------------------
-- Data for table `FacilityType`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;

INSERT INTO `FacilityType` (`id`, `name`, `description`) VALUES ('1', 'Jedalen', NULL);
INSERT INTO `FacilityType` (`id`, `name`, `description`) VALUES ('2', 'Kniznica', NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `Facility`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;

INSERT INTO `Facility` (`id`, `name`, `description`, `FacilityType_id`, `Address_id`) VALUES ('1', 'Jedalen FIIT STU', 'jedalen', '1', '1');
INSERT INTO `Facility` (`id`, `name`, `description`, `FacilityType_id`, `Address_id`) VALUES ('2', 'Kniznica FIIT STU', 'kniznica', '2', '1');

COMMIT;

-- -----------------------------------------------------
-- Data for table `OwnerRole`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;

INSERT INTO `OwnerRole` (`id`, `name`, `description`) VALUES ('1', 'Student', NULL);
INSERT INTO `OwnerRole` (`id`, `name`, `description`) VALUES ('2', 'Zamestnanec', NULL);
INSERT INTO `OwnerRole` (`id`, `name`, `description`) VALUES ('3', 'Asistent', NULL);
INSERT INTO `OwnerRole` (`id`, `name`, `description`) VALUES ('4', 'Doktorant', NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `Organization`
-- -----------------------------------------------------
SET AUTOCOMMIT=0;

INSERT INTO `Organization` (`id`, `name`, `description`, `Address_id`) VALUES ('1', 'FIIT STU', 'Fakulta Informatiky a Informacnych Technologii STU', '1');

COMMIT;
