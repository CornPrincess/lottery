-- MySQL Script generated by MySQL Workbench
-- Tue Dec 29 22:32:32 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema lottery
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lottery
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lottery` DEFAULT CHARACTER SET utf8 ;
USE `lottery` ;

-- -----------------------------------------------------
-- Table `lottery`.`lottery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lottery`.`lottery` ;

CREATE TABLE IF NOT EXISTS `lottery`.`lottery` (
  `lottery_id` SMALLINT(5) UNSIGNED NOT NULL,
  `title` VARCHAR(45) NOT NULL COMMENT '抽奖页面标题',
  `create_time` DATETIME NOT NULL COMMENT '创建时间',
  `status` TINYINT NOT NULL COMMENT '抽奖页面状态，0-正常，1-删除',
  `last_update` TIMESTAMP NOT NULL COMMENT '最新更新时间',
  PRIMARY KEY (`lottery_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lottery`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lottery`.`category` ;

CREATE TABLE IF NOT EXISTS `lottery`.`category` (
  `category_id` TINYINT(3) UNSIGNED NOT NULL,
  `name` VARCHAR(45) NOT NULL COMMENT '类型名称',
  `last_update` TIMESTAMP NOT NULL COMMENT '最新更新时间',
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lottery`.`prize`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lottery`.`prize` ;

CREATE TABLE IF NOT EXISTS `lottery`.`prize` (
  `prize_id` SMALLINT(5) UNSIGNED NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `probability` DECIMAL(5,2) NOT NULL,
  `amount` SMALLINT(5) NOT NULL COMMENT '奖品数量，0 无限量，>0限量，<0无奖品',
  `left_amount` SMALLINT(5) NOT NULL COMMENT '剩余数量',
  `picture` BLOB NOT NULL COMMENT '奖品 图片',
  `category_id` TINYINT(3) UNSIGNED NOT NULL COMMENT '奖品类型id',
  `status` TINYINT NOT NULL COMMENT '奖品状态，0-删除，1-正常',
  `create-time` DATETIME NOT NULL COMMENT '奖品创建时间',
  `last_update` VARCHAR(45) NOT NULL COMMENT '最新更新时间',
  PRIMARY KEY (`prize_id`),
  INDEX `fk_prize_category_id_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_prize_category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `lottery`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lottery`.`lottery_prize`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lottery`.`lottery_prize` ;

CREATE TABLE IF NOT EXISTS `lottery`.`lottery_prize` (
  `lottery_id` SMALLINT(5) UNSIGNED NOT NULL,
  `prize_id` SMALLINT(5) UNSIGNED NOT NULL,
  `last_update` TIMESTAMP NOT NULL COMMENT '最新更新时间',
  PRIMARY KEY (`lottery_id`, `prize_id`),
  INDEX `fk_lottery_prize_prize_idx` (`prize_id` ASC) VISIBLE,
  CONSTRAINT `fk_lottery_prize_lottery`
    FOREIGN KEY (`lottery_id`)
    REFERENCES `lottery`.`lottery` (`lottery_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lottery_prize_prize`
    FOREIGN KEY (`prize_id`)
    REFERENCES `lottery`.`prize` (`prize_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lottery`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lottery`.`user` ;

CREATE TABLE IF NOT EXISTS `lottery`.`user` (
  `user_id` INT UNSIGNED NOT NULL,
  `username` VARCHAR(45) CHARACTER SET 'DEFAULT' NOT NULL COMMENT '用户名',
  `contact_name` VARCHAR(45) CHARACTER SET 'DEFAULT' NOT NULL COMMENT '联系人',
  `phone` VARCHAR(20) CHARACTER SET 'DEFAULT' NOT NULL COMMENT '手机号',
  `address` VARCHAR(45) CHARACTER SET 'DEFAULT' NOT NULL COMMENT '地址',
  `create_time` DATETIME NOT NULL COMMENT '创建时间',
  `last_update` TIMESTAMP NOT NULL COMMENT '最新修改时间',
  `ip` VARCHAR(45) NOT NULL COMMENT 'ip地址',
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lottery`.`record`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lottery`.`record` ;

CREATE TABLE IF NOT EXISTS `lottery`.`record` (
  `record_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `prize_id` SMALLINT(5) UNSIGNED NOT NULL,
  `info` VARCHAR(45) NOT NULL COMMENT '获奖信息',
  `create_date` DATETIME NOT NULL COMMENT '创建时间',
  `status` TINYINT(3) NOT NULL COMMENT '状态，0-正常，1-删除，2-作弊',
  `last_update` TIMESTAMP NOT NULL COMMENT '最新更新时间',
  PRIMARY KEY (`record_id`),
  INDEX `fk_record_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_record_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `lottery`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_record_prize`
    FOREIGN KEY ()
    REFERENCES `lottery`.`lottery` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lottery`.`count_date`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lottery`.`count_date` ;

CREATE TABLE IF NOT EXISTS `lottery`.`count_date` (
  `count_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `count_day` TINYINT(1) NOT NULL COMMENT '该用户该天抽奖的总次数',
  `count_week` TINYINT(1) NOT NULL,
  `count_month` TINYINT(1) NOT NULL COMMENT '该用户当月抽奖的总次数',
  `count_year` TINYINT(1) NOT NULL COMMENT '该用户当年抽奖的总次数',
  `count_lifelong` VARCHAR(45) NOT NULL COMMENT '该用户注册以来累计抽奖的总次数',
  `count_lottery` TINYINT(1) NOT NULL,
  `last_upate` TIMESTAMP NOT NULL COMMENT '最新更新时间',
  PRIMARY KEY (`count_id`),
  INDEX `fk_count_day_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_count_day_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `lottery`.`user` (`user_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lottery`.`count_lottery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lottery`.`count_lottery` ;

CREATE TABLE IF NOT EXISTS `lottery`.`count_lottery` (
  `count_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL COMMENT '参与抽奖用户id',
  `lottery_id` SMALLINT(5) UNSIGNED NOT NULL COMMENT '抽奖页面id',
  `count` TINYINT(1) UNSIGNED NOT NULL COMMENT '该用户对该抽奖页面的抽奖次数',
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最新更新时间',
  PRIMARY KEY (`count_id`),
  INDEX `fk_count_lottery_user_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_count_lottery_lottery_idx` (`lottery_id` ASC) VISIBLE,
  CONSTRAINT `fk_count_lottery_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `lottery`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_count_lottery_lottery`
    FOREIGN KEY (`lottery_id`)
    REFERENCES `lottery`.`lottery` (`lottery_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lottery`.`limit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lottery`.`limit` ;

CREATE TABLE IF NOT EXISTS `lottery`.`limit` (
  `limit_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `limit_day` TINYINT(1) NOT NULL COMMENT '该用户每天抽奖次数的最大值',
  `limit_week` TINYINT(1) NOT NULL COMMENT '该用户每周抽奖次数的最大值',
  `limit_month` TINYINT(1) NOT NULL COMMENT '该用户每月抽奖次数的最大值',
  `limit_year` TINYINT(1) NOT NULL COMMENT '该用户每年抽奖次数的最大值',
  `limit_lifelong` TINYINT(1) NOT NULL COMMENT '该用户终身抽奖次数的最大值',
  `limit_lottery` TINYINT(1) NOT NULL COMMENT '该用户参加所有抽奖活动的次数总和的最大值',
  PRIMARY KEY (`limit_id`),
  INDEX `fk_limit_user_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_limit_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `lottery`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
