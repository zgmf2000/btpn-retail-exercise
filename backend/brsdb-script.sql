-- MySQL Script generated by MySQL Workbench
-- 05/11/17 08:15:58
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema brsdb
-- -----------------------------------------------------
-- Database for sample BTPN Retail System.
DROP SCHEMA IF EXISTS `brsdb` ;

-- -----------------------------------------------------
-- Schema brsdb
--
-- Database for sample BTPN Retail System.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `brsdb` DEFAULT CHARACTER SET utf8 ;
USE `brsdb` ;

-- -----------------------------------------------------
-- Table `brsdb`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brsdb`.`role` ;

CREATE TABLE IF NOT EXISTS `brsdb`.`role` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(128) NOT NULL,
  `role_description` VARCHAR(256) NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `brsdb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brsdb`.`user` ;

CREATE TABLE IF NOT EXISTS `brsdb`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `role_id` INT NOT NULL,
  `first_name` VARCHAR(256) NOT NULL,
  `last_name` VARCHAR(256) NOT NULL,
  `address` VARCHAR(256) NOT NULL,
  `phone` VARCHAR(18) NOT NULL,
  `email` VARCHAR(128) NOT NULL,
  `register_date` DATE NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`),
  INDEX `fk_user_role_idx` (`role_id` ASC),
  CONSTRAINT `fk_user_role`
    FOREIGN KEY (`role_id`)
    REFERENCES `brsdb`.`role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `brsdb`.`transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brsdb`.`transaction` ;

CREATE TABLE IF NOT EXISTS `brsdb`.`transaction` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `transaction_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` INT NOT NULL,
  `total_price` DOUBLE NOT NULL,
  `discount` DOUBLE NOT NULL,
  `grand_total` DOUBLE NOT NULL,
  PRIMARY KEY (`transaction_id`, `user_id`),
  INDEX `fk_transaction_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_transaction_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `brsdb`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `brsdb`.`item_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brsdb`.`item_category` ;

CREATE TABLE IF NOT EXISTS `brsdb`.`item_category` (
  `item_category_id` INT NOT NULL,
  `item_category_name` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`item_category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `brsdb`.`item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brsdb`.`item` ;

CREATE TABLE IF NOT EXISTS `brsdb`.`item` (
  `item_id` INT NOT NULL AUTO_INCREMENT,
  `item_category_id` INT NOT NULL,
  `item_name` VARCHAR(128) NOT NULL,
  `item_price` DOUBLE NOT NULL,
  `item_picture` TEXT NULL,
  PRIMARY KEY (`item_id`, `item_category_id`),
  INDEX `fk_item_item_category1_idx` (`item_category_id` ASC),
  CONSTRAINT `fk_item_item_category1`
    FOREIGN KEY (`item_category_id`)
    REFERENCES `brsdb`.`item_category` (`item_category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `brsdb`.`transaction_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brsdb`.`transaction_detail` ;

CREATE TABLE IF NOT EXISTS `brsdb`.`transaction_detail` (
  `transaction_detail_id` INT NOT NULL AUTO_INCREMENT,
  `transaction_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `qty` INT NOT NULL DEFAULT 1,
  `single_price` DOUBLE NOT NULL,
  `discount` DOUBLE NULL,
  `subtotal` DOUBLE NOT NULL,
  PRIMARY KEY (`transaction_detail_id`, `transaction_id`, `item_id`),
  INDEX `fk_transaction_detail_transaction1_idx` (`transaction_id` ASC),
  INDEX `fk_transaction_detail_item1_idx` (`item_id` ASC),
  CONSTRAINT `fk_transaction_detail_transaction1`
    FOREIGN KEY (`transaction_id`)
    REFERENCES `brsdb`.`transaction` (`transaction_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaction_detail_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `brsdb`.`item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `brsdb`.`user_account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `brsdb`.`user_account` ;

CREATE TABLE IF NOT EXISTS `brsdb`.`user_account` (
  `user_account_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(128) NOT NULL,
  `password` VARCHAR(128) NOT NULL,
  `name` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`user_account_id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `brsdb`.`role`
-- -----------------------------------------------------
START TRANSACTION;
USE `brsdb`;
INSERT INTO `brsdb`.`role` (`role_id`, `role_name`, `role_description`) VALUES (1, 'employee', 'Common store employee');
INSERT INTO `brsdb`.`role` (`role_id`, `role_name`, `role_description`) VALUES (2, 'affiliate', 'Store affiliate');
INSERT INTO `brsdb`.`role` (`role_id`, `role_name`, `role_description`) VALUES (3, 'customer', 'Your average everyday customer');

COMMIT;


-- -----------------------------------------------------
-- Data for table `brsdb`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `brsdb`;
INSERT INTO `brsdb`.`user` (`user_id`, `role_id`, `first_name`, `last_name`, `address`, `phone`, `email`, `register_date`) VALUES (1, 3, 'Kenneth', 'Jones', 'Jl. Kebon Sirih 4 No. 10, Jakarta Selatan', '+628147348239', 'kenneth.jones@gmail.com', '1992-01-04');
INSERT INTO `brsdb`.`user` (`user_id`, `role_id`, `first_name`, `last_name`, `address`, `phone`, `email`, `register_date`) VALUES (2, 3, 'Mary', 'Magdalene', 'Jl. Anggrek 2 No. 25, Jakarta Selatan', '+628548123985', 'mary.magdalene@gmail.com', '2016-02-02');
INSERT INTO `brsdb`.`user` (`user_id`, `role_id`, `first_name`, `last_name`, `address`, `phone`, `email`, `register_date`) VALUES (3, 2, 'Christopher', 'Kevin', 'Jl. Selisih 5 No. X, Jakarta Utara', '+628438549811', 'christian.kevin@yahoo.com', '2015-12-25');
INSERT INTO `brsdb`.`user` (`user_id`, `role_id`, `first_name`, `last_name`, `address`, `phone`, `email`, `register_date`) VALUES (4, 2, 'John', 'Voltaire', 'Raffles Residence Room 2508, Jakarta Utara', '+624754129888', 'john.voltaire@voltaire-enterprises.com', '2010-04-15');
INSERT INTO `brsdb`.`user` (`user_id`, `role_id`, `first_name`, `last_name`, `address`, `phone`, `email`, `register_date`) VALUES (5, 1, 'Anastasia', 'Princeton', 'Jl. Merauke 1 No. 9, Jakarta Timur', '+624859420111', 'anastasia.princeton42@outlook.com', '2012-02-01');
INSERT INTO `brsdb`.`user` (`user_id`, `role_id`, `first_name`, `last_name`, `address`, `phone`, `email`, `register_date`) VALUES (6, 1, 'Stephanie', 'Meyer', 'Jl. Nasional 3 No. 12, Jakarta Barat', '+624835985999', 'stephanie.meyer@outlook.com', '2000-02-24');

COMMIT;


-- -----------------------------------------------------
-- Data for table `brsdb`.`item_category`
-- -----------------------------------------------------
START TRANSACTION;
USE `brsdb`;
INSERT INTO `brsdb`.`item_category` (`item_category_id`, `item_category_name`) VALUES (1, 'Grocery');
INSERT INTO `brsdb`.`item_category` (`item_category_id`, `item_category_name`) VALUES (2, 'Home and Furnishing');
INSERT INTO `brsdb`.`item_category` (`item_category_id`, `item_category_name`) VALUES (3, 'Hygiene');

COMMIT;


-- -----------------------------------------------------
-- Data for table `brsdb`.`item`
-- -----------------------------------------------------
START TRANSACTION;
USE `brsdb`;
INSERT INTO `brsdb`.`item` (`item_id`, `item_category_id`, `item_name`, `item_price`, `item_picture`) VALUES (1, 1, 'Sawi Putih', 25, NULL);
INSERT INTO `brsdb`.`item` (`item_id`, `item_category_id`, `item_name`, `item_price`, `item_picture`) VALUES (2, 1, 'Bawang Bombay', 0.25, NULL);
INSERT INTO `brsdb`.`item` (`item_id`, `item_category_id`, `item_name`, `item_price`, `item_picture`) VALUES (3, 1, 'Greenfields Full Cream', 100, NULL);
INSERT INTO `brsdb`.`item` (`item_id`, `item_category_id`, `item_name`, `item_price`, `item_picture`) VALUES (4, 2, 'Sapu Ijuk', 50, NULL);
INSERT INTO `brsdb`.`item` (`item_id`, `item_category_id`, `item_name`, `item_price`, `item_picture`) VALUES (5, 2, 'Kemucing', 40, NULL);
INSERT INTO `brsdb`.`item` (`item_id`, `item_category_id`, `item_name`, `item_price`, `item_picture`) VALUES (6, 2, 'Coffee Table', 350, NULL);
INSERT INTO `brsdb`.`item` (`item_id`, `item_category_id`, `item_name`, `item_price`, `item_picture`) VALUES (7, 2, 'Vas Bunga Tiruan', 150, NULL);
INSERT INTO `brsdb`.`item` (`item_id`, `item_category_id`, `item_name`, `item_price`, `item_picture`) VALUES (8, 3, 'Clear Men Mint 500ml', 75, NULL);
INSERT INTO `brsdb`.`item` (`item_id`, `item_category_id`, `item_name`, `item_price`, `item_picture`) VALUES (9, 3, 'Lifebuoy Handwash Liquid', 90, NULL);
INSERT INTO `brsdb`.`item` (`item_id`, `item_category_id`, `item_name`, `item_price`, `item_picture`) VALUES (10, 3, 'Men\'s Biore Shower Gel', 80, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `brsdb`.`user_account`
-- -----------------------------------------------------
START TRANSACTION;
USE `brsdb`;
INSERT INTO `brsdb`.`user_account` (`user_account_id`, `username`, `password`, `name`) VALUES (1, 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', 'Administrator');

COMMIT;

