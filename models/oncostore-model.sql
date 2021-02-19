-- MySQL Script generated by MySQL Workbench
-- Thu Feb 18 08:00:00 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema oncostore
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `oncostore` ;

-- -----------------------------------------------------
-- Schema oncostore
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oncostore` DEFAULT CHARACTER SET utf8 ;
USE `oncostore` ;

-- -----------------------------------------------------
-- Table `oncostore`.`gene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`gene` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`gene` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `symbol` VARCHAR(25) NULL,
  `name` VARCHAR(255) NULL,
  `biotype` VARCHAR(45) NULL,
  `chr` VARCHAR(15) NULL,
  `start` BIGINT NULL,
  `end` BIGINT NULL,
  `synonyms` VARCHAR(45) NULL,
  `geneid` VARCHAR(45) NULL,
  `description` VARCHAR(255) NULL,
  `strand` VARCHAR(1) NULL,
  `version` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `gene_idx` (`geneid` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oncostore`.`variant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`variant` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`variant` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `chr` VARCHAR(15) NOT NULL,
  `start` BIGINT NOT NULL,
  `end` BIGINT NOT NULL,
  `ref` VARCHAR(255) NOT NULL,
  `obs` VARCHAR(255) NOT NULL,
  `issomatic` TINYINT NOT NULL,
  `uuid` VARCHAR(36) NOT NULL,
  `databaseidentifier` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `variant_idx` (`chr` ASC, `start` ASC, `end` ASC, `ref`(255) ASC, `obs`(255) ASC, `issomatic` ASC, `databaseidentifier` ASC),
  INDEX `variant_idx_start` (`start` ASC),
  INDEX `variant_idx_chr` (`chr` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oncostore`.`consequence`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`consequence` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`consequence` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `allele` VARCHAR(80) NULL,
  `codingchange` VARCHAR(179) NULL,
  `transcriptid` VARCHAR(80) NOT NULL,
  `transcriptversion` INT NULL,
  `type` VARCHAR(128) NOT NULL,
  `biotype` VARCHAR(45) NOT NULL,
  `canonical` TINYINT NULL,
  `aachange` VARCHAR(179) NULL,
  `cdnaposition` VARCHAR(45) NULL,
  `cdsposition` VARCHAR(45) NULL,
  `proteinposition` VARCHAR(45) NULL,
  `proteinlength` INT NULL,
  `cdnalength` INT NULL,
  `cdslength` INT NULL,
  `impact` VARCHAR(25) NOT NULL,
  `exon` VARCHAR(45) NULL,
  `intron` VARCHAR(45) NULL,
  `strand` INT NULL,
  `genesymbol` VARCHAR(45) NULL,
  `featuretype` VARCHAR(179) NULL,
  `distance` INT NULL,
  `warnings` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `fk_idx` (`codingchange` ASC, `proteinposition` ASC, `proteinlength` ASC, `type` ASC, `impact` ASC, `strand` ASC, `transcriptid` ASC, `transcriptversion` ASC, `canonical` ASC, `biotype` ASC, `cdnaposition` ASC, `cdsposition` ASC, `cdnalength` ASC, `cdslength` ASC, `genesymbol` ASC, `featuretype` ASC, `distance` ASC, `allele` ASC, `exon` ASC, `intron` ASC),
  INDEX `consequence_idx_genesymbol` (`genesymbol` ASC),
  INDEX `consequence_idx_type` (`type` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oncostore`.`referencegenome`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`referencegenome` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`referencegenome` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `source` VARCHAR(45) NULL,
  `build` VARCHAR(45) NULL,
  `version` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `rf_idx` (`source` ASC, `build` ASC, `version` ASC),
  INDEX `referencegenome_idx_build_id` (`build` ASC, `id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oncostore`.`annotationsoftware`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`annotationsoftware` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`annotationsoftware` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `version` VARCHAR(30) NOT NULL,
  `doi` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `fk_idx` (`name` ASC, `version` ASC, `doi` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oncostore`.`project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`project` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`project` (
  `id` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `project_index` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oncostore`.`entity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`entity` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`entity` (
  `id` VARCHAR(15) NOT NULL,
  `project_id` VARCHAR(15) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_vase_project_idx` (`project_id` ASC),
  UNIQUE INDEX `entity_index` (`id` ASC),
  CONSTRAINT `fk_Case_Project1`
    FOREIGN KEY (`project_id`)
    REFERENCES `oncostore`.`project` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oncostore`.`variantcaller`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`variantcaller` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`variantcaller` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `version` VARCHAR(30) NOT NULL,
  `doi` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `fk_idx` (`name` ASC, `version` ASC, `doi` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oncostore`.`sample`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`sample` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`sample` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `identifier` VARCHAR(15) NULL,
  `entity_id` VARCHAR(15) NULL,
  `cancerentity` VARCHAR(45) NULL,
  INDEX `fk_sample_case_idx` (`entity_id` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `fk_idx` (`identifier` ASC, `entity_id` ASC, `cancerentity` ASC),
  CONSTRAINT `fk_Sample_Case1`
    FOREIGN KEY (`entity_id`)
    REFERENCES `oncostore`.`entity` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oncostore`.`annotationsoftware_has_consequence`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`annotationsoftware_has_consequence` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`annotationsoftware_has_consequence` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `annotationsoftware_id` INT NOT NULL,
  `consequence_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_annotationsoftware_has_consequence_consequence_idx` (`consequence_id` ASC),
  INDEX `fk_annotationsoftware_has_consequence_annotationsoftware_idx` (`annotationsoftware_id` ASC),
  UNIQUE INDEX `fk_idx` (`annotationsoftware_id` ASC, `consequence_id` ASC),
  CONSTRAINT `fk_AnnotationSoftware_has_Consequence_AnnotationSoftware1`
    FOREIGN KEY (`annotationsoftware_id`)
    REFERENCES `oncostore`.`annotationsoftware` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AnnotationSoftware_has_Consequence_Consequence1`
    FOREIGN KEY (`consequence_id`)
    REFERENCES `oncostore`.`consequence` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oncostore`.`variant_has_referencegenome`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`variant_has_referencegenome` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`variant_has_referencegenome` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `variant_id` INT NOT NULL,
  `referencegenome_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Variant_has_ReferenceGenome_ReferenceGenome1_idx` (`referencegenome_id` ASC),
  INDEX `fk_Variant_has_ReferenceGenome_Variant1_idx` (`variant_id` ASC),
  UNIQUE INDEX `fk_idx` (`variant_id` ASC, `referencegenome_id` ASC),
  CONSTRAINT `fk_Variant_has_ReferenceGenome_Variant1`
    FOREIGN KEY (`variant_id`)
    REFERENCES `oncostore`.`variant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Variant_has_ReferenceGenome_ReferenceGenome1`
    FOREIGN KEY (`referencegenome_id`)
    REFERENCES `oncostore`.`referencegenome` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oncostore`.`variant_has_consequence`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`variant_has_consequence` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`variant_has_consequence` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `variant_id` INT NOT NULL,
  `consequence_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_variant_has_consequence_consequence_idx` (`consequence_id` ASC),
  INDEX `fk_variant_has_consequence_variant_idx` (`variant_id` ASC),
  UNIQUE INDEX `fk_idx` (`variant_id` ASC, `consequence_id` ASC),
  CONSTRAINT `fk_Variant_has_Consequence_Variant1`
    FOREIGN KEY (`variant_id`)
    REFERENCES `oncostore`.`variant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Variant_has_Consequence_Consequence1`
    FOREIGN KEY (`consequence_id`)
    REFERENCES `oncostore`.`consequence` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oncostore`.`variant_has_variantcaller`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`variant_has_variantcaller` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`variant_has_variantcaller` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `variant_id` INT NOT NULL,
  `variantcaller_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_variant_has_variantcaller_variantcaller_idx` (`variantcaller_id` ASC),
  INDEX `fk_variant_has_variantcaller_variant_idx` (`variant_id` ASC),
  UNIQUE INDEX `fk_idx` (`variant_id` ASC, `variantcaller_id` ASC),
  CONSTRAINT `fk_Variant_has_VariantCaller_Variant1`
    FOREIGN KEY (`variant_id`)
    REFERENCES `oncostore`.`variant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Variant_has_VariantCaller_VariantCaller1`
    FOREIGN KEY (`variantcaller_id`)
    REFERENCES `oncostore`.`variantcaller` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oncostore`.`ensembl`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`ensembl` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`ensembl` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `version` INT NULL,
  `date` VARCHAR(45) NULL,
  `referencegenome_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ensembl_referencegenome_idx` (`referencegenome_id` ASC),
  UNIQUE INDEX `ensembl_index` (`version` ASC, `date` ASC),
  CONSTRAINT `fk_Ensembl_ReferenceGenome1`
    FOREIGN KEY (`referencegenome_id`)
    REFERENCES `oncostore`.`referencegenome` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oncostore`.`consequence_has_gene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`consequence_has_gene` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`consequence_has_gene` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `consequence_id` INT NOT NULL,
  `gene_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_consequence_has_gene_gene_idx` (`gene_id` ASC),
  INDEX `fk_consequence_has_gene_consequence_idx` (`consequence_id` ASC),
  UNIQUE INDEX `fk_idx` (`consequence_id` ASC, `gene_id` ASC),
  CONSTRAINT `fk_Consequence_has_Gene_Consequence1`
    FOREIGN KEY (`consequence_id`)
    REFERENCES `oncostore`.`consequence` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consequence_has_Gene_Gene1`
    FOREIGN KEY (`gene_id`)
    REFERENCES `oncostore`.`gene` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oncostore`.`ensembl_has_gene`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`ensembl_has_gene` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`ensembl_has_gene` (
  `ensembl_id` INT NOT NULL,
  `gene_id` INT NOT NULL,
  PRIMARY KEY (`ensembl_id`, `gene_id`),
  INDEX `fk_ensembl_has_gene_gene_idx` (`gene_id` ASC),
  INDEX `fk_ensembl_has_gene_ensembl_idx` (`ensembl_id` ASC),
  CONSTRAINT `fk_Ensembl_has_Gene_Ensembl1`
    FOREIGN KEY (`ensembl_id`)
    REFERENCES `oncostore`.`ensembl` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ensembl_has_Gene_Gene1`
    FOREIGN KEY (`gene_id`)
    REFERENCES `oncostore`.`gene` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oncostore`.`vcfinfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`vcfinfo` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`vcfinfo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ancestralallele` VARCHAR(45) NULL,
  `allelecount` VARCHAR(45) NULL,
  `allelefrequency` VARCHAR(45) NULL,
  `numberalleles` INT NULL,
  `basequality` INT NULL,
  `cigar` VARCHAR(45) NULL,
  `dbsnp` TINYINT NULL,
  `hapmaptwo` TINYINT NULL,
  `hapmapthree` TINYINT NULL,
  `thousandgenomes` TINYINT NULL,
  `combineddepth` INT NULL,
  `endpos` INT NULL,
  `rms` INT NULL,
  `mqzero` INT NULL,
  `strandbias` INT NULL,
  `numbersamples` INT NULL,
  `somatic` TINYINT NULL,
  `validated` TINYINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `info_idx` (`ancestralallele` ASC, `allelecount` ASC, `allelefrequency` ASC, `numberalleles` ASC, `basequality` ASC, `cigar` ASC, `dbsnp` ASC, `hapmaptwo` ASC, `hapmapthree` ASC, `thousandgenomes` ASC, `combineddepth` ASC, `endpos` ASC, `rms` ASC, `mqzero` ASC, `strandbias` ASC, `numbersamples` ASC, `somatic` ASC, `validated` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oncostore`.`genotype`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`genotype` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`genotype` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `genotype` VARCHAR(45) NULL,
  `readdepth` INT NULL,
  `filter` VARCHAR(45) NULL,
  `likelihoods` VARCHAR(45) NULL,
  `genotypelikelihoods` VARCHAR(45) NULL,
  `genotypelikelihoodshet` VARCHAR(45) NULL,
  `posteriorprobs` VARCHAR(45) NULL,
  `genotypequality` INT NULL,
  `haplotypequalities` VARCHAR(45) NULL,
  `phaseset` VARCHAR(45) NULL,
  `phasingquality` INT NULL,
  `alternateallelecounts` VARCHAR(45) NULL,
  `mappingquality` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `genotype_idx` (`genotype` ASC, `readdepth` ASC, `filter` ASC, `likelihoods` ASC, `genotypelikelihoods` ASC, `genotypelikelihoodshet` ASC, `genotypequality` ASC, `haplotypequalities` ASC, `phaseset` ASC, `phasingquality` ASC, `alternateallelecounts` ASC, `mappingquality` ASC, `posteriorprobs` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oncostore`.`sample_has_variant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oncostore`.`sample_has_variant` ;

CREATE TABLE IF NOT EXISTS `oncostore`.`sample_has_variant` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sample_id` INT NOT NULL,
  `variant_id` INT NOT NULL,
  `vcfinfo_id` INT NOT NULL,
  `genotype_id` INT NOT NULL,
  INDEX `fk_sample_has_variant_variant_idx` (`variant_id` ASC),
  INDEX `fk_sample_has_variant_vcfinfo1_idx` (`vcfinfo_id` ASC),
  INDEX `fk_sample_has_variant_genotype1_idx` (`genotype_id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_sample_has_variant_sample1_idx` (`sample_id` ASC),
  UNIQUE INDEX `fk_idx` (`sample_id` ASC, `variant_id` ASC, `vcfinfo_id` ASC, `genotype_id` ASC),
  CONSTRAINT `fk_Sample_has_Variant_Variant1`
    FOREIGN KEY (`variant_id`)
    REFERENCES `oncostore`.`variant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sample_has_variant_vcfinfo1`
    FOREIGN KEY (`vcfinfo_id`)
    REFERENCES `oncostore`.`vcfinfo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sample_has_variant_genotype1`
    FOREIGN KEY (`genotype_id`)
    REFERENCES `oncostore`.`genotype` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sample_has_variant_sample1`
    FOREIGN KEY (`sample_id`)
    REFERENCES `oncostore`.`sample` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
