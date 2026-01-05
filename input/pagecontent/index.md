
Shows how Provenance can be used to track corrections to FHIR data. When data are corrected, especially when the Patient themselves reported that the data was wrong, there needs to be breadcrumbs left behind. Correction is a form of updating of data, but with the special need to indicate that previous data was in error. Some corrections result in the previous data being removed, while others result in the previous data being replaced with corrected data.

Therefore the needs to be a special indication of a correction Provenance, as distinct from a general update Provenance, with the following goals:

1. So that future uses understand the past might have seen different data
2. So that requests for data, especially from outside (e.g. HIE), can see that previous data has been corrected.

<div markdown="1" class="stu-note">

<br/>
This IG is founded on HL7 FHIR Revision {{site.data.fhir.version}} found at [{{site.data.fhir.path}}]({{site.data.fhir.path}})
<br/>
</div>

Recommended use of a [Profile on Provenance](StructureDefinition-CorrectionProvenanceProfile.html) to indicate corrections:

Examples:
- [Provenance removal](Provenance-ex-correction-removal.html) resource documenting the removal of incorrect food allergy observation. This example does not point at a resource that explains the correction, such as a DocumentReference.
- [Provenance replacement](Provenance-ex-correction-replacement.html) Provenance resource documenting the replacement of an immunization record that was in error. This example includes a reference to a DocumentReference that explains the correction.
- [Provenance AI corrected](Provenance-ex-ai-error-detection-replacement.html) Provenance resource documenting the detection of an error in FHIR data by an AI system. The original Observation that is error is removed, and a new AllergyIntolerance resource is created to replace it.
- [Provenance AI corrected with replacement](Provenance-ex-ai-error-detection-replacement.html) Provenance resource documenting the detection of an error in FHIR data by an AI system, where the Observation was used to record a food allergy, but the AI system detected that this should have been an AllergyIntolerance resource instead. Thus the Observation is removed, and the AllergyIntolerance is created.
- [Provenance patient correction](Provenance-ex-patient-requested-correction.html) Provenance resource documenting a patient requested correction of their birth date.
- [Provenance revision correction](Provenance-ex-condition-corrected.html) Provenance resource documenting the revision of a Condition resource with corrected onset date. In this case the original Condition is revised. Thus the old version history/1 is indicated as revised, and the new version history/2 is indicated as the current version.


**changes from R4->R6 Consent:**

In R6 basedOn would be used to hold the evidence for the correction. Where in R4 would use entity with role=instantiates.


### Source

The source code for this Implementation Guide can be found on [GitHub](https://github.com/JohnMoehrke/correction)

#### Cross Version Analysis

{% include cross-version-analysis.xhtml %}

#### Dependency Table

{% include dependency-table.xhtml %}

#### Globals Table

{% include globals-table.xhtml %}

#### IP Statements

{% include ip-statements.xhtml %}
