SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `dwh` ;
CREATE SCHEMA IF NOT EXISTS `dwh` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `dwh` ;

-- -----------------------------------------------------
-- Table `ProductType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProductType` ;

CREATE  TABLE IF NOT EXISTS `ProductType` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NULL ,
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
  `name` VARCHAR(255) NULL ,
  `description` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
COMMENT = 'Tabulka typov zariadeni';


-- -----------------------------------------------------
-- Table `Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Address` ;

CREATE  TABLE IF NOT EXISTS `Address` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `address_city` VARCHAR(255) NULL ,
  `address_street` VARCHAR(255) NULL ,
  `address_state` VARCHAR(255) NULL ,
  `address_zip` VARCHAR(255) NULL ,
  `address_region` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Facility`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Facility` ;

CREATE  TABLE IF NOT EXISTS `Facility` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NULL ,
  `description` TEXT NULL ,
  `facilitytype_id` INT NULL ,
  `address_id` INT NULL ,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'Jednotlive zariadenia jedalen,kniznica a pod';


-- -----------------------------------------------------
-- Table `OwnerRole`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `OwnerRole` ;

CREATE  TABLE IF NOT EXISTS `OwnerRole` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NULL ,
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
  `first_name` VARCHAR(255) NULL ,
  `last_name` VARCHAR(255) NULL ,
  `title_before_name` VARCHAR(255) NULL ,
  `title_after_name` VARCHAR(255) NULL ,
  `date_of_birth` DATE NULL ,
  `sex` INT NULL COMMENT 'ciselnik' ,
  `birth_place` VARCHAR(255) NULL ,
  `birth_number` VARCHAR(255) NULL ,
  `id_card_number` VARCHAR(255) NULL ,
  `id_card_type` INT NULL ,
  `photo` VARCHAR(255) NULL ,
  `note` VARCHAR(255) NULL ,
  `ownerrole_id` INT NULL ,
  `address_id` INT NULL ,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'Tabulka drzitelov kariet';


-- -----------------------------------------------------
-- Table `Organization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Organization` ;

CREATE  TABLE IF NOT EXISTS `Organization` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NULL ,
  `description` TEXT NULL ,
  `address_id` INT NULL ,
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
  `serial_number` VARCHAR(255) NULL ,
  `validity_date_from` DATE NULL ,
  `validity_date_to` DATE NULL ,
  `sale_date` DATE NULL ,
  `void_date` DATE NULL ,
  `facility_id` INT NULL ,
  `cardowner_id` INT NULL ,
  `producttype_id` INT NULL ,
  `organization_id` INT NULL ,
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
  `stamp_number` VARCHAR(255) NULL ,
  `date_of_sale` VARCHAR(255) NULL ,
  `validity_date_from` DATE NULL ,
  `validity_date_to` DATE NULL ,
  `producttype_id` INT NULL ,
  `card_id` INT UNSIGNED NULL ,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'Tabulka prolongacnych znamok';


-- -----------------------------------------------------
-- Table `Exemplar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Exemplar` ;

CREATE  TABLE IF NOT EXISTS `Exemplar` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `title` VARCHAR(255) NULL ,
  `ISBN` VARCHAR(255) NULL ,
  `langugage` VARCHAR(255) NULL ,
  `issue_date` DATE NULL ,
  `publisher` VARCHAR(255) NULL ,
  `authors` VARCHAR(255) NULL ,
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
  `note` VARCHAR(255) NULL ,
  `card_id` INT UNSIGNED NULL ,
  `state` INT NULL ,
  `exemplar_id` INT NULL ,
  `facility_id` INT NULL ,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Food`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Food` ;

CREATE  TABLE IF NOT EXISTS `Food` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Order` ;

CREATE  TABLE IF NOT EXISTS `Order` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `time` DATETIME NULL ,
  `facility_id` INT NULL ,
  `card_id` INT UNSIGNED NULL ,
  `food_id` INT NULL ,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Date`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Date` ;

CREATE  TABLE IF NOT EXISTS `Date` (
  `id` INT NULL ,
  `day` INT NULL ,
  `week` INT NULL ,
  `month` INT NULL ,
  `semester` INT NULL ,
  `year` INT NULL )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FoodSale`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FoodSale` ;

CREATE  TABLE IF NOT EXISTS `FoodSale` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `buy_price` REAL NULL ,
  `sale_price` REAL NULL ,
  `profit` REAL NULL ,
  `weight` REAL NULL ,
  `food_id` INT NULL ,
  `facility_id` INT NULL ,
  `date_id` INT NULL ,
  `card_id` INT NULL ,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Address`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Address` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `address_city` VARCHAR(255) NULL ,
  `address_street` VARCHAR(255) NULL ,
  `address_state` VARCHAR(255) NULL ,
  `address_zip` VARCHAR(255) NULL ,
  `address_region` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;
