package life.qbic.oncostore.model

import groovy.transform.EqualsAndHashCode
import htsjdk.variant.variantcontext.CommonInfo
import life.qbic.oncostore.util.VcfConstants

/**
 * A class to store information as given in the INFO column as defined in the Variant Call Format specification
 *
 * @since: 1.0.0
 */
@EqualsAndHashCode
class VcfInfo {

    // possible reserved sub-fields of the INFO column as defined in the VCF specification
    // http://samtools.github.io/hts-specs/ (VCF 4.1 and 4.2)
    //TODO deal with future releases?
    /**
     * The ancestral allele
     **/
    String ancestralAllele
    /**
     * The allele count
     **/
    List<Integer> alleleCount
    /**
     * The allele frequency
     **/
    List<Float> alleleFrequency
    /**
     * The number of alleles
     **/
    Integer numberAlleles
    /**
     * The RMS base quality
     **/
    Integer baseQuality
    /**
     * The cigar string describing how to align an alternate allele to the reference allele
     **/
    String cigar
    /**
     * Membership in dbSNP ?
     **/
    Boolean dbSnp
    /**
     * Membership in hapmap2 ?
     **/
    Boolean hapmapTwo
    /**
     * Membership in hapmap3 ?
     **/
    Boolean hapmapThree
    /**
     * Membership in 1000 Genomes ?
     **/
    Boolean thousandGenomes
    /**
     * The combined depth (DP) across samples
     **/
    Integer combinedDepth
    /**
     * The end position of the described variant
     **/
    Integer endPos
    /**
     * The RMS mapping quality (MQ)
     **/
    Float rms
    /**
     * The number of MAPQ==0 reads covering this record (MQ0)
     **/
    Integer mqZero
    /**
     * The strand bias at this position
     **/
    Integer strandBias
    /**
     * The number of samples with data
     **/
    Integer numberSamples
    /**
     * Indicates that the record is a somatic mutation
     **/
    Boolean somatic
    /**
     * Validated by follow-up experiment
     **/
    Boolean validated

    VcfInfo() { }

    VcfInfo(CommonInfo commonInfo) {
        //TODO check if that isn`t AA (amino acid) annotation?
        this.ancestralAllele = commonInfo.getAttributeAsString(VcfConstants.VcfInfoAbbreviations.ANCESTRALALLELE.tag, null)
        this.alleleCount = commonInfo.getAttributeAsIntList(VcfConstants.VcfInfoAbbreviations.ALLELECOUNT.tag, -1)
        this.alleleFrequency = commonInfo.getAttributeAsIntList(VcfConstants.VcfInfoAbbreviations.ALLELEFREQUENCY.tag, -1) as List<Float>
        this.numberAlleles = commonInfo.getAttributeAsInt(VcfConstants.VcfInfoAbbreviations.NUMBERALLELES.tag, -1)
        this.baseQuality = commonInfo.getAttributeAsInt(VcfConstants.VcfInfoAbbreviations.BASEQUALITY.tag, -1)
        this.cigar = commonInfo.getAttributeAsString(VcfConstants.VcfInfoAbbreviations.CIGAR.tag, null)
        this.dbSnp = commonInfo.getAttributeAsBoolean(VcfConstants.VcfInfoAbbreviations.DBSNP.tag, false)
        this.hapmapTwo = commonInfo.getAttributeAsBoolean(VcfConstants.VcfInfoAbbreviations.HAPMAPTWO.tag, false)
        this.hapmapThree = commonInfo.getAttributeAsBoolean(VcfConstants.VcfInfoAbbreviations.HAPMAPTHREE.tag, false)
        this.thousandGenomes = commonInfo.getAttributeAsBoolean(VcfConstants.VcfInfoAbbreviations.THOUSANDGENOMES.tag, false)
        this.combinedDepth = commonInfo.getAttributeAsInt(VcfConstants.VcfInfoAbbreviations.COMBINEDDEPTH.tag, -1)
        this.endPos = commonInfo.getAttributeAsInt(VcfConstants.VcfInfoAbbreviations.ENDPOS.tag, -1)
        this.rms = commonInfo.getAttributeAsDouble(VcfConstants.VcfInfoAbbreviations.RMS.tag, -1) as Float
        this.mqZero = commonInfo.getAttributeAsInt(VcfConstants.VcfInfoAbbreviations.MQZERO.tag, -1)
        this.strandBias = commonInfo.getAttributeAsInt(VcfConstants.VcfInfoAbbreviations.STRANDBIAS.tag, -1)
        this.numberSamples = commonInfo.getAttributeAsInt(VcfConstants.VcfInfoAbbreviations.NUMBERSAMPLES.tag, -1)
        this.somatic = commonInfo.getAttributeAsBoolean(VcfConstants.VcfInfoAbbreviations.SOMATIC.tag, false)
        this.validated = commonInfo.getAttributeAsBoolean(VcfConstants.VcfInfoAbbreviations.VALIDATED.tag, false)
    }

    String getAncestralAllele() {
        return ancestralAllele
    }

    List<Integer> getAlleleCount() {
        return alleleCount
    }

    List<Float> getAlleleFrequency() {
        return alleleFrequency
    }

    Integer getNumberAlleles() {
        return numberAlleles
    }

    Integer getBaseQuality() {
        return baseQuality
    }

    String getCigar() {
        return cigar
    }

    Boolean getDbSnp() {
        return dbSnp
    }

    Boolean getHapmapTwo() {
        return hapmapTwo
    }

    Boolean getHapmapThree() {
        return hapmapThree
    }

    Boolean getThousandGenomes() {
        return thousandGenomes
    }

    Integer getCombinedDepth() {
        return combinedDepth
    }

    Integer getEndPos() {
        return endPos
    }

    Integer getRms() {
        return rms
    }

    Integer getMqZero() {
        return mqZero
    }

    Integer getStrandBias() {
        return strandBias
    }

    Integer getNumberSamples() {
        return numberSamples
    }

    Boolean getSomatic() {
        return somatic
    }

    Boolean getValidated() {
        return validated
    }

    /**
     * Generate representation in INFO column format.
     *
     * @return the content of an INFO column as specified in a Variant Call Format file
     */
    String toVcfFormat() {
        def vcfInfoString = new StringJoiner(VcfConstants.PROPERTY_DELIMITER)
        this.properties.each { it ->
            if (it.key != "class" & it.value != null & it.value != -1 & it.value != false & it.value != [] & it.value
                    != "") {
                def name = it.key.toString().toUpperCase() as VcfConstants.VcfInfoAbbreviations
                vcfInfoString.add("${name.getTag()}${VcfConstants.PROPERTY_DEFINITION_STRING}${it.value.toString()}")
            }
        }
        return vcfInfoString
    }
}
