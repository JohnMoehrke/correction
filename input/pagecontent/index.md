
Shows how Provenance can be used to track corrections to FHIR data, and communicate that a correction has been made. When data are corrected, especially when the Patient themselves reported that the data was wrong, there needs to be breadcrumbs left behind. Correction is a form of updating of data, but with the special need to indicate that previous data was in error. Some corrections result in the previous data being removed, while others result in the previous data being replaced with corrected data.

Therefore the needs to be a special indication of a correction Provenance, as distinct from a general update Provenance, with the following goals:

1. So that future uses understand the past might have seen different data
2. So that requests for data, especially from outside (e.g. HIE), can see that previous data has been corrected.

The recipient can then find if they have a copy or used the previous data, and take appropriate action.

<div markdown="1" class="stu-note">

<br/>
This IG is founded on HL7 FHIR Revision {{site.data.fhir.version}} found at [{{site.data.fhir.path}}]({{site.data.fhir.path}})
<br/>
</div>

### Use-cases

- A patient contacts their provider to report that there is some data that is incorrect. An investigation is done, and the data are found to be in error. The data is corrected, and a Provenance resource is created to indicate the correction.
  - One possibility for this workflow is the [HL7 FHIR Patient Requested Correction](https://hl7.org/fhir/uv/patient-corrections/)
- A Quality Improvement process finds that some data is incorrect. An investigation is done, and the data are found to be in error. The data is corrected, and a Provenance resource is created to indicate the correction.
  - One possibility for this detection is an AI system that reviews data and finds potential errors.

### Profiling

Recommended use of a [Profile on Provenance](StructureDefinition-CorrectionProvenanceProfile.html) to indicate corrections:

- `activity.coding`: will be code `FIXDATA` from [v3-ActReason](http://terminology.hl7.org/CodeSystem/v3-ActReason) to indicate that this Provenance is for a data correction.
- `reason.coding`: can use a set of codes often associated with a correction.
- `recorded`: will be the time the correction was made.
- `target`: points at the resource(s) that are corrected.
- `agent`: indicates who made the correction.
  - the Patient would be indicated here for corrections requested by the patient.
- `entity`: indicates the records corrected.
  - `entity.role`=`#removal` points at the record being replaced or removed (if applicable).
  - `entity.role`=`#revision` points at the record being revised (if applicable).
- textual reason can be in `why` in R6, or in `activity.text` in R4/R5.
- evidence such as the request for the correction can be in `basedOn` in R6, or in `entity` with `role`=`#derivation` in R4/R5.


Examples:
- [Provenance removal](Provenance-ex-correction-removal.html) resource documenting the removal of incorrect food allergy observation. This example does not point at a resource that explains the correction, such as a DocumentReference.
- [Provenance replacement](Provenance-ex-correction-replacement.html) Provenance resource documenting the replacement of an immunization record that was in error. This example includes a reference to a DocumentReference that explains the correction.
- [Provenance AI corrected](Provenance-ex-ai-error-detection-replacement.html) Provenance resource documenting the detection of an error in FHIR data by an AI system. The original Observation that is error is removed, and a new AllergyIntolerance resource is created to replace it.
- [Provenance AI corrected with replacement](Provenance-ex-ai-error-detection-replacement.html) Provenance resource documenting the detection of an error in FHIR data by an AI system, where the Observation was used to record a food allergy, but the AI system detected that this should have been an AllergyIntolerance resource instead. Thus the Observation is removed, and the AllergyIntolerance is created.
- [Provenance patient correction](Provenance-ex-patient-requested-correction.html) Provenance resource documenting a patient requested correction of their birth date.
- [Provenance revision correction](Provenance-ex-condition-corrected.html) Provenance resource documenting the revision of a Condition resource with corrected onset date. In this case the original Condition is revised. Thus the old version history/1 is indicated as revised, and the new version history/2 is indicated as the current version.


**changes from R4->R6 Provenance:**

- In R6 `basedOn` would be used to hold the evidence for the correction. Where in R4 would use `entity` with `role=derivation`, and in R5 with `role=instantiates`.
- In R6 `patient` element exists. Same in R6. R4 didn't have patient, so other methods would be needed to find all Provenance pointing at a patient's data.
- In R6 `why` exists. This does not exist in R4 or R5. Sometimes the `activity.text` would be used for this.
- In R6 and R5 `authorization` is a codeableReference, where in R5 `reason` is used to hold the PurposeOfUse

### Discovering Corrections

To find all corrections for a specific patient, one can search for Provenance resources with `Provenance.activity` with the `FIXDATA` code, and where the Provenance points at resources related to the patient.

#### FHIR R5 and R6

In FHIR R5 and R6 there is a `patient` element on Provenance, making it easy to find all Provenance resources related to a specific patient. One needs to simply filter on `Provenance.activity` with the `FIXDATA` code.

```
GET [base]/Provenance?patient=[patient-id]&activity=http://terminology.hl7.org/CodeSystem/v3-ActReason|FIXDATA
```

#### FHIR R4

In FHIR R4 one needs to search for Provenance resources that point at resources related to the patient. This can be done by searching for Provenance with `Provenance.activity` with `FIXDATA` and where the `target` or `entity.what` points at resources related to the patient. Since either `target` or `entity.what` may point at resources that contain a patient reference, these cannot be combined in a single standard FHIR search query. Both chained searches must be performed and results combined client-side to find all relevant Provenance resources:

```
GET [base]/Provenance?activity=http://terminology.hl7.org/CodeSystem/v3-ActReason|FIXDATA&target.patient=[patient-id]
GET [base]/Provenance?activity=http://terminology.hl7.org/CodeSystem/v3-ActReason|FIXDATA&entity.what.patient=[patient-id]
```

### Proposed FHIR Document section

I could not find an existing FHIR Document section that covers this topic. For example in an [International Patient Summary (IPS)](https://hl7.org/fhir/uv/ips/) this could be an additional section. In this way as new Cross-Community requests are made corrections would be communicated. This section contains information about corrections made to the patient's data, including details of the original data, the corrected data, and the reason for the correction. This information is provided to ensure data integrity and transparency in the patient's health record. I propose a new section:

- Section code: `http://loinc.org#77472-9` (Information integrity attribute)
- Section title: Corrections to Data
- Section text: Text summary of the corrections made.
- Section entries: Provenance resources documenting corrections made to the patient's data following [the correction Profile on Provenance](StructureDefinition-CorrectionProvenanceProfile.html).

Note that loinc code 77472-9 is "Information integrity attribute", which seems appropriate for this section. I am open to other code suggestions.

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
