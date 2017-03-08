-- MySQL Script generated by MySQL Workbench
-- 03/02/17 14:51:26
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema skola
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema skola
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `skola` DEFAULT CHARACTER SET utf8 ;
USE `skola` ;

-- -----------------------------------------------------
-- Table `skola`.`klass`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skola`.`klass` (
  `kod` CHAR(6) NOT NULL,
  `namn` VARCHAR(50) NOT NULL,
  `arkurs` YEAR NOT NULL,
  PRIMARY KEY (`kod`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skola`.`elev`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skola`.`elev` (
  `personnummer` CHAR(10) NOT NULL,
  `fornamn` VARCHAR(50) NOT NULL,
  `efternamn` VARCHAR(50) NOT NULL,
  `epost` VARCHAR(50) NOT NULL,
  `telefon` VARCHAR(15) NULL,
  `klass_kod` CHAR(6) NOT NULL,
  `ort` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`personnummer`),
  INDEX `fk_Elev_Klass_idx` (`klass_kod` ASC),
  CONSTRAINT `fk_Elev_Klass`
    FOREIGN KEY (`klass_kod`)
    REFERENCES `skola`.`klass` (`kod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skola`.`kurs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skola`.`kurs` (
  `kod` CHAR(6) NOT NULL,
  `namn` VARCHAR(50) NOT NULL,
  `startdatum` DATE NOT NULL,
  `slutdatum` DATE NOT NULL,
  `poang` INT NOT NULL,
  `klass_kod` CHAR(6) NOT NULL,
  PRIMARY KEY (`kod`),
  INDEX `fk_kurs_klass1_idx` (`klass_kod` ASC),
  CONSTRAINT `fk_kurs_klass1`
    FOREIGN KEY (`klass_kod`)
    REFERENCES `skola`.`klass` (`kod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skola`.`klass_kurs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skola`.`klass_kurs` (
  `klass_kod` CHAR(6) NOT NULL,
  `kurs_kod` CHAR(6) NOT NULL,
  PRIMARY KEY (`klass_kod`, `kurs_kod`),
  INDEX `fk_Klass_has_Kurs_Kurs1_idx` (`kurs_kod` ASC),
  INDEX `fk_Klass_has_Kurs_Klass1_idx` (`klass_kod` ASC),
  CONSTRAINT `fk_Klass_has_Kurs_Klass1`
    FOREIGN KEY (`klass_kod`)
    REFERENCES `skola`.`klass` (`kod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Klass_has_Kurs_Kurs1`
    FOREIGN KEY (`kurs_kod`)
    REFERENCES `skola`.`kurs` (`kod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skola`.`lokal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skola`.`lokal` (
  `lokalkummer` INT NOT NULL AUTO_INCREMENT,
  `namn` VARCHAR(50) NOT NULL,
  `antal_platser` INT NOT NULL,
  PRIMARY KEY (`lokalkummer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skola`.`kurslokal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skola`.`kurslokal` (
  `kurs_kod` CHAR(6) NOT NULL,
  `lokal_lokalkummer` INT NOT NULL,
  `datum` DATE NOT NULL,
  `tid` TIME(4) NOT NULL,
  PRIMARY KEY (`kurs_kod`, `lokal_lokalkummer`, `datum`, `tid`),
  INDEX `fk_Kurs_has_Lokal_Kurs1_idx` (`kurs_kod` ASC),
  INDEX `fk_kurslokal_lokal1_idx` (`lokal_lokalkummer` ASC),
  CONSTRAINT `fk_Kurs_has_Lokal_Kurs1`
    FOREIGN KEY (`kurs_kod`)
    REFERENCES `skola`.`kurs` (`kod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_kurslokal_lokal1`
    FOREIGN KEY (`lokal_lokalkummer`)
    REFERENCES `skola`.`lokal` (`lokalkummer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skola`.`avdelning`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skola`.`avdelning` (
  `avdelningsnummer` INT NOT NULL AUTO_INCREMENT,
  `namn` VARCHAR(50) NULL,
  PRIMARY KEY (`avdelningsnummer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skola`.`larare`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skola`.`larare` (
  `anstallningsnummer` INT NOT NULL AUTO_INCREMENT,
  `fornamn` VARCHAR(50) NULL,
  `efternamn` VARCHAR(50) NULL,
  `epost` VARCHAR(50) NULL,
  `telefon` VARCHAR(15) NULL,
  `ort` VARCHAR(50) NULL,
  `avdelning_avdelningsnummer` INT NOT NULL,
  PRIMARY KEY (`anstallningsnummer`),
  INDEX `fk_Larare_Avdelning1_idx` (`avdelning_avdelningsnummer` ASC),
  CONSTRAINT `fk_Larare_Avdelning1`
    FOREIGN KEY (`avdelning_avdelningsnummer`)
    REFERENCES `skola`.`avdelning` (`avdelningsnummer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skola`.`undervisar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skola`.`undervisar` (
  `kurs_kod` CHAR(6) NOT NULL,
  `larare_anstallningsnummer` INT NOT NULL,
  PRIMARY KEY (`kurs_kod`, `larare_anstallningsnummer`),
  INDEX `fk_Kurs_has_Larare_Larare1_idx` (`larare_anstallningsnummer` ASC),
  INDEX `fk_Kurs_has_Larare_Kurs1_idx` (`kurs_kod` ASC),
  CONSTRAINT `fk_Kurs_has_Larare_Kurs1`
    FOREIGN KEY (`kurs_kod`)
    REFERENCES `skola`.`kurs` (`kod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Kurs_has_Larare_Larare1`
    FOREIGN KEY (`larare_anstallningsnummer`)
    REFERENCES `skola`.`larare` (`anstallningsnummer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `skola`.`kursbetyg`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `skola`.`kursbetyg` (
  `elev_personnummer` CHAR(10) NOT NULL,
  `kurs_kod` CHAR(6) NOT NULL,
  `betyg` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`elev_personnummer`, `kurs_kod`),
  INDEX `fk_Elev_has_Kurs_Kurs1_idx` (`kurs_kod` ASC),
  INDEX `fk_Elev_has_Kurs_Elev1_idx` (`elev_personnummer` ASC),
  CONSTRAINT `fk_Elev_has_Kurs_Elev1`
    FOREIGN KEY (`elev_personnummer`)
    REFERENCES `skola`.`elev` (`personnummer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Elev_has_Kurs_Kurs1`
    FOREIGN KEY (`kurs_kod`)
    REFERENCES `skola`.`kurs` (`kod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
