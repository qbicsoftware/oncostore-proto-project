package life.qbic.variantstore.parser

import groovy.json.JsonSlurper
import life.qbic.variantstore.model.Annotation
import life.qbic.variantstore.model.Case
import life.qbic.variantstore.model.ReferenceGenome
import life.qbic.variantstore.model.VariantCaller
import life.qbic.variantstore.model.Sample
import life.qbic.variantstore.util.AnnotationHandler


/**
 * A class to read in metadata provdided as JSON content and provide
 * extracted information as {@MetadataContext} object.
 *
 * @since: 1.0.0
 */
class MetadataReader {

    /**
     * The metadata stored as {@MetadataContext}
     */
    final MetadataContext metadataContext

    MetadataReader(File file) {
        def slurper = new JsonSlurper()
        def jsonContent = slurper.parse(file)
        this.metadataContext = new MetadataContext(parseIsSomatic(jsonContent), parseCallingSoftware(jsonContent), parseAnnotationSoftware(jsonContent), parseReferenceGenome(jsonContent), parseCase(jsonContent), parseSample(jsonContent))
    }

    MetadataReader(String content) {
        def slurper = new JsonSlurper()
        def jsonContent = slurper.parseText(content)
        this.metadataContext = new MetadataContext(parseIsSomatic(jsonContent), parseCallingSoftware(jsonContent), parseAnnotationSoftware(jsonContent), parseReferenceGenome(jsonContent), parseCase(jsonContent), parseSample(jsonContent))
    }

    MetadataContext getMetadataContext() {
        return metadataContext
    }

    /**
     * Parse information whether provided variants are somatic.
     * @param jsonContent the metadata content
     * @return true if variants are somatic
     */
    static boolean parseIsSomatic(jsonContent) {
        return jsonContent.is_somatic
    }

    /**
     * Parse information whether provided variants are somatic.
     * @param jsonContent the metadata content
     * @return true if variants are somatic
     */
    static Annotation parseAnnotationSoftware(jsonContent) {
        def name = jsonContent.variant_annotation.name as String
        def version = jsonContent.variant_annotation.version
        def doi = jsonContent.variant_annotation.doi

        assert name.toUpperCase() in AnnotationHandler.AnnotationTools.values().collect{value -> value.name()}
        return new Annotation(name, version, doi)
    }

    /**
     * Parse information whether provided variants are somatic.
     * @param jsonContent the metadata content
     * @return true if variants are somatic
     */
    static VariantCaller parseCallingSoftware(jsonContent) {
        return new VariantCaller(jsonContent.variant_calling.name, jsonContent.variant_calling.version, jsonContent.variant_calling.doi)
    }

    /**
     * Parse information whether provided variants are somatic.
     * @param jsonContent the metadata content
     * @return true if variants are somatic
     */
    static ReferenceGenome parseReferenceGenome(jsonContent) {
        return new ReferenceGenome(jsonContent.reference_genome.source, jsonContent.reference_genome.build, jsonContent.reference_genome.version)
    }

    /**
     * Parse information whether provided variants are somatic.
     * @param jsonContent the metadata content
     * @return true if variants are somatic
     */
    static Case parseCase(jsonContent) {
        return new Case(jsonContent.case.identifier)
    }

    /**
     * Parse information whether provided variants are somatic.
     * @param jsonContent the metadata content
     * @return true if variants are somatic
     */
    static List<Sample> parseSample(jsonContent) {
        def samples = []
        jsonContent.samples.each { sample ->
            def cancerEntity = sample.cancerEntity ?: ''
            samples.add(new Sample(sample.identifier, cancerEntity, jsonContent.case.identifier))
        }
        return samples
    }
}