-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema warehouse_project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema warehouse_project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `warehouse_project` DEFAULT CHARACTER SET utf8 ;
USE `warehouse_project` ;

-- -----------------------------------------------------
-- Table `warehouse_project`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warehouse_project`.`countries` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `warehouse_project`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warehouse_project`.`cities` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `countries_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Cities_Countries1_idx` (`countries_id` ASC),
  CONSTRAINT `fk_Cities_Countries1`
    FOREIGN KEY (`countries_id`)
    REFERENCES `warehouse_project`.`countries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `warehouse_project`.`locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warehouse_project`.`locations` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(45) NOT NULL,
  `number` VARCHAR(45) NOT NULL,
  `code` VARCHAR(45) NOT NULL,
  `cities_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Locations_Cities1_idx` (`cities_id` ASC),
  CONSTRAINT `fk_Locations_Cities1`
    FOREIGN KEY (`cities_id`)
    REFERENCES `warehouse_project`.`cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `warehouse_project`.`warehouses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warehouse_project`.`warehouses` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `total_capacity` DOUBLE NOT NULL,
  `available_capacity` DOUBLE NOT NULL,
  `locations_id` INT(11) NULL DEFAULT NULL,
  `next_warehouses_id` INT(11) NULL DEFAULT NULL,
  `days_to_next_warehouse` INT(11) NULL DEFAULT NULL,
  `companies_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Warehouses_Locations1_idx` (`locations_id` ASC),
  INDEX `fk_Warehouses_Warehouses1_idx` (`next_warehouses_id` ASC) ,
  INDEX `fk_Warehouses_Companies1_idx` (`companies_id` ASC) ,
  CONSTRAINT `fk_Warehouses_Warehouses1`
    FOREIGN KEY (`next_warehouses_id`)
    REFERENCES `warehouse_project`.`warehouses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Warehouses_Companies1`
    FOREIGN KEY (`companies_id`)
    REFERENCES `warehouse_project`.`companies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Warehouses_Locations1`
    FOREIGN KEY (`locations_id`)
    REFERENCES `warehouse_project`.`locations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 33
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `warehouse_project`.`companies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warehouse_project`.`companies` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `next_warehouses_id` INT(11) NULL DEFAULT NULL,
  `days_to_closes_warerehouse` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Companies_Warehouses1_idx` (`next_warehouses_id` ASC) ,
  CONSTRAINT `fk_Companies_Warehouses1`
    FOREIGN KEY (`next_warehouses_id`)
    REFERENCES `warehouse_project`.`warehouses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `warehouse_project`.`drivers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warehouse_project`.`drivers` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `age` INT(11) NULL DEFAULT NULL,
  `birth` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = '								';


-- -----------------------------------------------------
-- Table `warehouse_project`.`trucks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warehouse_project`.`trucks` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `capacity` DOUBLE NOT NULL,
  `companies_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  INDEX `fk_Trucks_Companies1_idx` (`companies_id` ASC) ,
  CONSTRAINT `fk_Trucks_Companies1`
    FOREIGN KEY (`companies_id`)
    REFERENCES `warehouse_project`.`companies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `warehouse_project`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warehouse_project`.`orders` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `total_volume` DOUBLE NOT NULL,
  `total_price` DOUBLE NOT NULL,
  `trucks_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idOrders_UNIQUE` (`id` ASC),
  INDEX `fk_Orders_Trucks1_idx` (`trucks_id` ASC),
  CONSTRAINT `fk_Orders_Trucks1`
    FOREIGN KEY (`trucks_id`)
    REFERENCES `warehouse_project`.`trucks` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `warehouse_project`.`product_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warehouse_project`.`product_categories` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `warehouse_project`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warehouse_project`.`products` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `volume` DOUBLE NOT NULL,
  `due_date` DATE NOT NULL,
  `price` DOUBLE NOT NULL,
  `product_categories_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  INDEX `fk_Products_produc_categories1_idx` (`product_categories_id` ASC) ,
  CONSTRAINT `fk_Products_Product_Categories1`
    FOREIGN KEY (`product_categories_id`)
    REFERENCES `warehouse_project`.`product_categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 38
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `warehouse_project`.`orders_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warehouse_project`.`orders_details` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `quantity` INT(11) NOT NULL,
  `subtotal_volume` DOUBLE NOT NULL DEFAULT '0',
  `subtotal_price` DOUBLE NOT NULL DEFAULT '0',
  `products_id` INT(11) NOT NULL,
  `orders_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  INDEX `fk_Orders_Details_Products1_idx` (`products_id` ASC) ,
  INDEX `fk_Orders_Details_Orders1_idx` (`orders_id` ASC) ,
  CONSTRAINT `fk_Orders_Details_Orders1`
    FOREIGN KEY (`orders_id`)
    REFERENCES `warehouse_project`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Details_Products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `warehouse_project`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `warehouse_project`.`phone_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warehouse_project`.`phone_types` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `warehouse_project`.`phones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warehouse_project`.`phones` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `number` VARCHAR(20) NOT NULL,
  `type_id` INT(10) UNSIGNED NOT NULL,
  `drivers_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) ,
  INDEX `fk_Phones_Drivers1_idx` (`drivers_id` ASC) ,
  INDEX `fk_Phones_Types_idx` (`type_id` ASC) ,
  CONSTRAINT `fk_Phones_Drivers1`
    FOREIGN KEY (`drivers_id`)
    REFERENCES `warehouse_project`.`drivers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Phones_Types`
    FOREIGN KEY (`type_id`)
    REFERENCES `warehouse_project`.`phone_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `warehouse_project`.`trucks_drivers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `warehouse_project`.`trucks_drivers` (
  `trucks_id` INT(11) NOT NULL,
  `drivers_id` INT(11) NOT NULL,
  PRIMARY KEY (`trucks_id`, `drivers_id`),
  INDEX `fk_trucks_has_drivers_drivers1_idx` (`drivers_id` ASC) ,
  INDEX `fk_trucks_has_drivers_trucks1_idx` (`trucks_id` ASC) ,
  CONSTRAINT `fk_trucks_has_drivers_trucks1`
    FOREIGN KEY (`trucks_id`)
    REFERENCES `warehouse_project`.`trucks` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_trucks_has_drivers_drivers1`
    FOREIGN KEY (`drivers_id`)
    REFERENCES `warehouse_project`.`drivers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
