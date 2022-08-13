-- creating database

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`student` ;

CREATE TABLE IF NOT EXISTS `mydb`.`student` (
  `id` INT NOT NULL,
  `Student_Name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`marks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`marks` ;

CREATE TABLE IF NOT EXISTS `mydb`.`marks` (
  `id` INT NOT NULL,
  `score` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `Student.id`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`ques_bank`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ques_bank` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ques_bank` (
  `QuesID` INT NOT NULL,
  `Question` VARCHAR(45) NULL DEFAULT NULL,
  `Marks` INT NULL DEFAULT NULL,
  `ans` CHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`QuesID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`questionattempt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`questionattempt` ;

CREATE TABLE IF NOT EXISTS `mydb`.`questionattempt` (
  `id` INT NOT NULL,
  `QuesID` INT NOT NULL,
  PRIMARY KEY (`id`, `QuesID`),
  INDEX `QuesID_idx` (`QuesID` ASC) VISIBLE,
  CONSTRAINT `id`
    FOREIGN KEY (`id`)
    REFERENCES `mydb`.`student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `QuesID`
    FOREIGN KEY (`QuesID`)
    REFERENCES `mydb`.`ques_bank` (`QuesID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

# insert Questions in ques_bank
INSERT INTO `ques_bank` VALUES (1,'Is earth habitable?',4, 'Y'),(2,'Smoking is healthy?',4, 'N'),(3,'obesity can kill?',4, 'Y'),(4,'Fast Food is healthy?',4, 'N');
INSERT INTO `ques_bank` VALUES (5,'Earth is 2/3rd water?',4, 'Y'),(6,'Avicii was a singer?',4, 'N'),(7,'Alt rock is same as rock?',4, 'N'),(8,'MCR is rock band?',4, 'Y');

# Student Identification
select Student_name from student;

# Student Marks
select student.Student_name, marks.score from marks INNER JOIN student on Student.ID=marks.ID;

# Question and marks
select question, marks from ques_bank;

# Questions defined to students
select student.Student_name, ques_bank.Question from questionattempt INNER JOIN student on Student.ID=questionattempt.ID INNER JOIN ques_bank on ques_bank.QuesID=questionattempt.QuesID;

# Leaderboard
select student.Student_name, marks.score from marks INNER JOIN student on Student.ID=marks.ID order by marks.score DESC;


