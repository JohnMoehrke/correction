
ValueSet: CorrectionPurposesVS
Title: "Correction Purposes ValueSet"
Description: "A value set of codes representing the purposes for which a correction to FHIR data
may be made."
* ^experimental = false
* http://terminology.hl7.org/CodeSystem/v3-ActReason#PATSFTY
* http://terminology.hl7.org/CodeSystem/v3-ActReason#HQUALIMP
* http://terminology.hl7.org/CodeSystem/v3-ActReason#PATRQT
* http://terminology.hl7.org/CodeSystem/v3-ActReason#_ActHealthInformationManagementReason
* http://hl7.org/fhir/resource-status#replaced
* http://hl7.org/fhir/resource-status#refuted
//* http://hl7.org/fhir/resource-status#amended // not in R4

Profile: CorrectionProvenanceProfile
Parent: Provenance
Title: "Provenance Profile for Corrections"
Description: "A profile of the Provenance resource to document corrections made to FHIR data."
* target MS
* target ^comment = "References the resource(s) that were corrected."
* recorded 1..1 MS
* recorded ^comment = "The instant of time at which the correction was made."
* activity MS
* activity 1..1
* activity = http://terminology.hl7.org/CodeSystem/v3-ActReason#FIXDATA
* reason MS
* reason from CorrectionPurposesVS
* reason ^comment = "The activity that resulted in the correction, e.g., data review or error detection."
* agent MS
* agent ^comment = "The individual or system responsible for making the correction."
* entity MS
* entity ^comment = "Details about the corrected resource and the nature of the correction."
* entity ^slicing.discriminator[0].type = #value
* entity ^slicing.discriminator[0].path = "role"
* entity ^slicing.rules = #open
* entity contains removalEntry 0..* MS and revisionEntry 0..* MS
* entity[removalEntry].role = #removal
* entity[removalEntry].what MS
* entity[removalEntry].what ^comment = "References the resource that was removed as part of the correction."
* entity[removalEntry].what.identifier MS
* entity[removalEntry].what.identifier ^comment = "Identifier of the removed resource for traceability and de-duplication support."
* entity[revisionEntry].role = #revision
* entity[revisionEntry].what MS
* entity[revisionEntry].what ^comment = "References the resource that was revised as part of the correction."
* entity[revisionEntry].what.identifier MS
* entity[revisionEntry].what.identifier ^comment = "Identifier of the revised resource for traceability and de-duplication support."
/* R4 and R5 */
* entity contains reasonBasedOn 0..* MS
* entity[reasonBasedOn].role = #derivation // later changed to instantiates in R5 and basedOn in R6
* entity[reasonBasedOn].what MS
* entity[reasonBasedOn].what ^comment = "References the resource that provided the basis for the correction, such as a DocumentReference containing correction details."
/* R6
* basedOn MS
* basedOn ^comment = "References the reason for the correction, such as a DocumentReference containing correction details. In R4 this is an additional entity[] with role = instantiates."
* why 1..1 MS
* why ^comment = "The reason for the correction."

*/



Instance:   ex-patient
InstanceOf: Patient
Title:      "Dummy Patient example"
Description: "Dummy patient example for completeness sake. No actual use of this resource other than an example target"
Usage: #example
//* identifier = urn:uuid:2.16.840.1.113883.4.349#MVI // MVI ICN VALUE WITH CHECKSUM>
// history - http://playgroundjungle.com/2018/02/origins-of-john-jacob-jingleheimer-schmidt.html
// wiki - https://en.wikipedia.org/wiki/John_Jacob_Jingleheimer_Schmidt
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* name[+].use = #usual
* name[=].family = "Schmidt"
* name[=].given = "John"
* name[+].use = #old
* name[=].family = "Schnidt"
* name[=].given[+] = "John"
* name[=].given[+] = "Jacob"
* name[=].given[+] = "Jingle"
* name[=].given[+] = "Heimer"
* name[=].period.end = "1960"
* name[+].use = #official
* name[=].family = "Schmidt"
* name[=].given[+] = "John"
* name[=].given[+] = "Jacob"
* name[=].given[+] = "Jingleheimer"
* name[=].period.start = "1960-01-01"
* name[+].use = #nickname
* name[=].family = "Schmidt"
* name[=].given = "Jack"
* gender = #other
* birthDate = "1923-07-25"
* address.state = "WI"
* address.country = "USA"
* identifier[+].system = "http://example.org/mrn"
* identifier[=].value = "123456"

Instance:   ex-observation-food
InstanceOf: Observation
Title:      "Food Allergy Observation"
Description: "An example Observation resource representing a food allergy."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #final
* category[+].coding[+] = http://terminology.hl7.org/CodeSystem/observation-category#symptom
* category[=].text = "Allergy"
* code.coding[+] = http://loinc.org#48765-2
* code.text = "Allergy to food"
* subject = Reference(http://example.org/Patient/ex-patient)
* effectiveDateTime = "2023-01-15T10:00:00Z"
* valueCodeableConcept.coding[+] = http://snomed.info/sct#235719002
* valueCodeableConcept.text = "Allergy to peanuts"
* interpretation[+].coding[+] = http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation#A
* interpretation[=].text = "Abnormal"
* note[+].text = "Patient has a known allergy to peanuts. Avoid all peanut-containing products."
* performer[+] = Reference(http://example.org/Practitioner/ex-practitioner)
* identifier[+].system = "http://example.org/observation-identifiers"
* identifier[=].value = "obs-food-allergy-001"

Instance: ex-allergy-corrected
InstanceOf: AllergyIntolerance
Title:      "Corrected Food Allergy"
Description: "An example AllergyIntolerance resource representing a corrected food allergy record."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* clinicalStatus.coding[+] = http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical#active
* verificationStatus.coding[+] = http://terminology.hl7.org/CodeSystem/allergyintolerance-verification#confirmed
* type = http://hl7.org/fhir/allergy-intolerance-type#allergy
* category[+] = http://hl7.org/fhir/allergy-intolerance-category#food
* code.coding[+] = http://snomed.info/sct#235719002
* code.text = "Allergy to peanuts"
* patient = Reference(http://example.org/Patient/ex-patient)
* onsetDateTime = "2023-01-15T10:00:00Z"


Instance: ex-correction-removal
InstanceOf: CorrectionProvenanceProfile
Title: "Provenance for Correction Removal"
Description: "Provenance resource documenting the removal of incorrect food allergy observation. This example does not point at a resource that explains the correction, such as a DocumentReference. This use-case also did not replace the concept."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* target[+] = Reference(Observation/ex-observation-food)
* recorded = "2024-06-01T12:00:00Z"
* agent[+].type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#author
* agent[=].who = Reference(http:///example.org/Practitioner/ex-practitioner)
* activity = http://terminology.hl7.org/CodeSystem/v3-ActReason#FIXDATA
//* why = "Removed incorrect food allergy observation as it was found to be erroneous."
* entity[removalEntry].role = #removal
* entity[removalEntry].what = Reference(Observation/ex-observation-food)
* entity[removalEntry].what.display = "Incorrect Food Allergy Observation"
* entity[removalEntry].what.identifier.system = "http://example.org/observation-identifiers"
* entity[removalEntry].what.identifier.value = "obs-food-allergy-001"
//* patient = Reference(https://example.org/Patient/ex-patient)

Instance: ex-immunization-wrong
InstanceOf: Immunization
Title:      "Immunization Example"
Description: "An example Immunization resource representing a vaccination."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #completed
* vaccineCode.coding[+] = http://hl7.org/fhir/sid/cvx#207
* vaccineCode.text = "COVID-19, mRNA, LNP-S, PF, 100 mcg/0.5 mL dose"
* patient = Reference(https://example.org/Patient/ex-patient)
* occurrenceDateTime = "2023-03-01T09:00:00Z"
* performer[+].actor = Reference(https://example.org/Practitioner/ex-practitioner)
* lotNumber = "12345"
* site.coding[+] = http://terminology.hl7.org/CodeSystem/v3-ActSite#LA
* site.text = "Left Arm"
* route.coding[+] = http://terminology.hl7.org/CodeSystem/v3-RouteOfAdministration#IM
* route.text = "Intramuscular"
* note[+].text = "Patient tolerated the vaccine well with no immediate adverse reactions."
* identifier.system = "http://example.org/immunization-identifiers"
* identifier.value = "immu-covid19-001"

Instance: ex-immunization-correction
InstanceOf: Immunization
Title:      "Corrected Immunization Example"
Description: "An example Immunization resource representing a corrected vaccination record."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #completed
* vaccineCode.coding[+] = http://hl7.org/fhir/sid/cvx#208
* vaccineCode.text = "COVID-19, mRNA, LNP-S, PF, 50 mcg/0.25 mL dose"
* patient = Reference(https://example.org/Patient/ex-patient)
* occurrenceDateTime = "2023-03-01T09:00:00Z"
* performer[+].actor = Reference(https://example.org/Practitioner/ex-practitioner)
* lotNumber = "67890"
* site.coding[+] = http://terminology.hl7.org/CodeSystem/v3-ActSite#RA
* site.text = "Right Arm"
* route.coding[+] = http://terminology.hl7.org/CodeSystem/v3-RouteOfAdministration#IM
* route.text = "Intramuscular"
* note[+].text = "Corrected immunization record to reflect the accurate vaccine dose
  and administration site."
* note[+].text = "Original record indicated 100 mcg dose in left arm; corrected to 50 mcg dose in right arm."
* identifier.system = "http://example.org/immunization-identifiers"
* identifier.value = "immu-covid19-001-corrected"

Instance: ex-correction-replacement
InstanceOf: CorrectionProvenanceProfile
Title: "Provenance for Immunization Replacement"
Description: "Provenance resource documenting the replacement of an immunization record that was in error. This example includes a reference to a DocumentReference that explains the correction."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* target[+] = Reference(Immunization/ex-immunization-correction)
* recorded = "2024-06-01T13:00:00Z"
* agent[+].type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#author
* agent[=].who = Reference(http:///example.org/Practitioner/ex-practitioner)
* activity = http://terminology.hl7.org/CodeSystem/v3-ActReason#FIXDATA
* reason = http://terminology.hl7.org/CodeSystem/v3-ActReason#PATSFTY
//* why = "Corrected immunization record to reflect accurate vaccine information."
* entity[removalEntry].role = #removal
* entity[removalEntry].what = Reference(Immunization/ex-immunization-wrong)
* entity[removalEntry].what.display = "Original Immunization Record with Errors"
* entity[removalEntry].what.identifier.system = "http://example.org/immunization-identifiers"
* entity[removalEntry].what.identifier.value = "immu-covid19-001"
//* patient = Reference(https://example.org/Patient/ex-patient)

/* R4 */

* entity[reasonBasedOn].role = #derivation
* entity[reasonBasedOn].what = Reference(DocumentReference/ex-documentation-immunization-correction)
* entity[reasonBasedOn].what.display = "Documentation of Immunization Correction"

/* R4 */
/* R6 */
//* basedOn[+] = Reference(DocumentReference/ex-documentation-immunization-correction)
/* R6 */

Instance: ex-documentation-immunization-correction
InstanceOf: DocumentReference
Title: "Documentation of Immunization Correction"
Description: "A DocumentReference resource providing documentation for the correction made to an immunization record."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* status = #current
* type.coding[+] = http://loinc.org#34133-9
* type.text = "Immunization record correction documentation"
* subject = Reference(https://example.org/Patient/ex-patient)
* date = "2024-06-01T13:00:00Z"
* content[+].attachment.contentType = #application/pdf
* content[=].attachment.url = "http://example.org/documents/immunization-correction.pdf"
* content[=].attachment.title = "Immunization Correction Documentation"
* content[=].attachment.creation = "2024-06-01T13:00:00Z"
* description = "This document provides details regarding the correction made to the immunization record of the patient."
* author[+] = Reference(https://example.org/Practitioner/ex-practitioner)
* custodian = Reference(https://example.org/Organization/ex-organization)

Instance: ex-ai-error-detection-replacement
InstanceOf: CorrectionProvenanceProfile
Title: "Provenance for AI Error Detection"
Description: "Provenance resource documenting the detection of an error in FHIR data by an AI system. Where Observation was used to record a food allergy, but the AI system detected that this should have been an AllergyIntolerance resource instead. Thus the Observation is removed, and the AllergyIntolerance is created."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* target[+] = Reference(AllergyIntolerance/ex-allergy-corrected)
* recorded = "2024-06-01T14:00:00Z"
* agent[+].who = Reference(http:///example.org/Device/ex-ai-system)
* agent[=].type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#verifier 
* activity = http://terminology.hl7.org/CodeSystem/v3-ActReason#FIXDATA
* reason = http://terminology.hl7.org/CodeSystem/v3-ActReason#HQUALIMP
//* why = "AI system detected an inconsistency in the food allergy Observation data should have been an AllergyIntolerance."
* entity[removalEntry].role = #removal
* entity[removalEntry].what = Reference(Observation/ex-observation-food)
* entity[removalEntry].what.display = "Food Allergy Observation with Detected Error"
* entity[removalEntry].what.identifier.system = "http://example.org/observation-identifiers"
* entity[removalEntry].what.identifier.value = "obs-food-allergy-001"
//* patient = Reference(https://example.org/Patient/ex-patient)

Instance: ex-ai-duplicate-detection
InstanceOf: CorrectionProvenanceProfile
Title: "Provenance for AI Duplicate Detection"
Description: "Provenance resource documenting the detection of duplicate FHIR data by an AI system. Where an Observation resources and an AllergyIntolerance were found to be duplicates. Thus the correction removed the Observation, and revised the AllergyIntolerance (updating the AllergyIntolerance with knowledge from the Observation like onset)."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* target[+] = Reference(AllergyIntolerance/ex-allergy-corrected)
* recorded = "2024-06-01T15:00:00Z"
* agent[+].who = Reference(http:///example.org/Device/ex-ai-system)
* agent[=].type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#verifier
* activity = http://terminology.hl7.org/CodeSystem/v3-ActReason#FIXDATA
* reason = http://terminology.hl7.org/CodeSystem/v3-ActReason#HQUALIMP
//* why = "AI system detected duplicate allergy information between Observation and AllergyIntolerance resources."
* entity[removalEntry].role = #removal
* entity[removalEntry].what = Reference(Observation/ex-observation-food)
* entity[removalEntry].what.display = "Duplicate Food Allergy Observation"
* entity[removalEntry].what.identifier.system = "http://example.org/observation-identifiers"
* entity[removalEntry].what.identifier.value = "obs-food-allergy-001"
* entity[revisionEntry].role = #revision
* entity[revisionEntry].what = Reference(AllergyIntolerance/ex-allergy-corrected)
* entity[revisionEntry].what.display = "Revised AllergyIntolerance after Duplicate Detection"
* entity[revisionEntry].what.identifier.system = "http://example.org/allergyintolerance-identifiers"
* entity[revisionEntry].what.identifier.value = "allergy-peanut-001"
//* patient = Reference(https://example.org/Patient/ex-patient)


/* Condition foo has a version/history 1 that is found to be incorrect, so a revision to version/history 2 is created to correct the error */
Instance: ex-condition-initial
InstanceOf: Condition
Title:      "Initial Condition Example"
Description: "An example Condition resource that has an error that version 2 will fix."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* clinicalStatus.coding[+] = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* code.coding[+] = http://snomed.info/sct#44054006
* code.text = "Diabetes mellitus type 2"
* subject = Reference(https://example.org/Patient/ex-patient)
* onsetDateTime = "2020-05-20T00:00:00Z"
* identifier.system = "http://example.org/condition-identifiers"
* identifier.value = "condition-diabetes-001"

Instance: ex-corrected
InstanceOf: Condition
Title:      "Corrected Condition Example"
Description: "An example Condition resource that corrects the error found in version 1."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* clinicalStatus.coding[+] = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* code.coding[+] = http://snomed.info/sct#44054006
* code.text = "Diabetes mellitus type 2"
* subject = Reference(https://example.org/Patient/ex-patient)
* onsetDateTime = "2019-05-20T00:00:00Z"  // Corrected onset date
* identifier.system = "http://example.org/condition-identifiers"
* identifier.value = "condition-diabetes-001"

Instance: ex-condition-corrected
InstanceOf: CorrectionProvenanceProfile
Title: "Provenance for Condition Correction"
Description: "Provenance resource documenting the correction made to a Condition resource. Note that the IG does not utilize history/1 and history/2, but this example shows how a correction Provenance would point at the initial incorrect resource and the corrected resource."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* target[+] = Reference(Condition/ex-corrected)
* recorded = "2024-06-01T16:00:00Z"
* agent[+].type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#author
* agent[=].who = Reference(http:///example.org/Practitioner/ex-practitioner)
* activity = http://terminology.hl7.org/CodeSystem/v3-ActReason#FIXDATA
//* why = "Corrected onset date of Condition resource."
* entity[revisionEntry].role = #revision
* entity[revisionEntry].what = Reference(Condition/ex-condition-initial)
* entity[revisionEntry].what.display = "Initial Condition with Incorrect Onset Date"
* entity[revisionEntry].what.identifier.system = "http://example.org/condition-identifiers"
* entity[revisionEntry].what.identifier.value = "condition-diabetes-001"
//* patient = Reference(https://example.org/Patient/ex-patient)


Instance: ex-patient-requested-correction
InstanceOf: CorrectionProvenanceProfile
Title: "Provenance for Patient Requested Correction"
Description: "Provenance resource documenting a patient requested correction of their birth date. This example shows how the IG for Patient Requested Corrections, which uses Communication to document the request, can be linked to a Correction Provenance that documents the actual correction made to the Patient resource. The Provenance.agent is the Patient as the data subject requesting the correction."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* target[+] = Reference(Patient/ex-patient)
* recorded = "2024-06-01T17:00:00Z"
* agent[+].type = http://terminology.hl7.org/CodeSystem/extra-security-role-type#datasubject
* agent[=].who = Reference(http:///example.org/Patient/ex-patient)
* activity = http://terminology.hl7.org/CodeSystem/v3-ActReason#FIXDATA
* reason = http://terminology.hl7.org/CodeSystem/v3-ActReason#PATRQT
//* why = "Patient requested correction of birth date."
* entity[revisionEntry].role = #revision
* entity[revisionEntry].what = Reference(Patient/ex-patient)
* entity[revisionEntry].what.display = "Patient Resource with Corrected Birth Date"
* entity[revisionEntry].what.identifier.system = "http://example.org/mrn"
* entity[revisionEntry].what.identifier.value = "123456"
//* patient = Reference(https://example.org/Patient/ex-patient)
//* basedOn = Reference(https://example.org/Communication/ex-communication-birthdate-correction)
* entity[reasonBasedOn].role = #derivation
* entity[reasonBasedOn].what = Reference(https://example.org/Communication/ex-communication-birthdate-correction)

Instance: ex-patient-forgotten
InstanceOf: CorrectionProvenanceProfile
Title: "Provenance for Patient Data Erasure Request"
Description: "Provenance resource documenting a patient request for data erasure (right to be forgotten). This example shows how the IG for Patient Requested Corrections, which uses DocumentReference to document the request, can be linked to a Correction Provenance that documents the erasure of the Patient resource. The Provenance.agent is the Patient as the data subject requesting the erasure. The Provenance.entity lists ALL of the patient data removed to comply with the request."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* target[+] = Reference(Patient/ex-patient)
* recorded = "2024-06-01T18:00:00Z"
* agent[+].type = http://terminology.hl7.org/CodeSystem/extra-security-role-type#datasubject
* agent[=].who = Reference(http:///example.org/Patient/ex-patient)
* activity = http://terminology.hl7.org/CodeSystem/v3-ActReason#FIXDATA
* reason = http://terminology.hl7.org/CodeSystem/v3-ActReason#PATRQT
/* R4 */
* activity.text = "Patient requested erasure of their data."
* entity[reasonBasedOn].role = #derivation
* entity[reasonBasedOn].what = Reference(https://example.org/DocumentReference/ex-data-erasure-request)
/* R4 */
/* R6 */
//* patient = Reference(https://example.org/Patient/ex-patient)
//* basedOn[+] = Reference(https://example.org/DocumentReference/ex-data-erasure-request)
//* why = "Patient requested erasure of their data."
/* R6 */
* entity[removalEntry][+].role = #removal
* entity[removalEntry][=].what = Reference(Patient/ex-patient)
* entity[removalEntry][+].role = #removal
* entity[removalEntry][=].what = Reference(Observation/ex-observation-food)
* entity[removalEntry][+].role = #removal
* entity[removalEntry][=].what = Reference(AllergyIntolerance/ex-allergy-corrected)
* entity[removalEntry][+].role = #removal
* entity[removalEntry][=].what = Reference(Immunization/ex-immunization-correction)
* entity[removalEntry][+].role = #removal
* entity[removalEntry][=].what = Reference(Condition/ex-corrected)
* entity[removalEntry][+].role = #removal
* entity[removalEntry][=].what = Reference(Immunization/ex-immunization-wrong)
* entity[removalEntry][+].role = #removal
* entity[removalEntry][=].what = Reference(Condition/ex-condition-initial)


Instance: ex-data-purge-due-to-age
InstanceOf: CorrectionProvenanceProfile
Title: "Provenance for purging Patient Data due to Age of that data and data retention policies"
Description: "Provenance resource documenting the purging of patient data due to the age of that data and compliance with data retention policies. This example shows how the IG for Patient Data Purge can be linked to a Correction Provenance that documents the erasure of the Patient resource and associated data. The Provenance.agent is the Medical Records Officer responsible for ensuring compliance with data retention policies. The Provenance.entity lists ALL of the patient data removed to comply with the data retention policy."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* target[+] = Reference(Patient/ex-patient)
* recorded = "2024-06-01T18:00:00Z"
* agent[+].type = http://terminology.hl7.org/CodeSystem/extra-security-role-type#datasubject
* agent[=].who = Reference(http://example.org/Practitioner/ex-medical-records-officer )
* activity = http://terminology.hl7.org/CodeSystem/v3-ActReason#FIXDATA
* reason = http://terminology.hl7.org/CodeSystem/v3-ActReason#_ActHealthInformationManagementReason
/* R4 */
* activity.text = "Medical Records Retention Policy Compliance - Data Age"
/* R4 */
/* R6 */
//* why = "Medical Records Retention Policy Compliance - Data Age"
/* R6 */
* entity[removalEntry][+].role = #removal
* entity[removalEntry][=].what = Reference(Patient/ex-patient)
* entity[removalEntry][+].role = #removal
* entity[removalEntry][=].what = Reference(Observation/ex-observation-food)
* entity[removalEntry][+].role = #removal
* entity[removalEntry][=].what = Reference(AllergyIntolerance/ex-allergy-corrected)
* entity[removalEntry][+].role = #removal
* entity[removalEntry][=].what = Reference(Immunization/ex-immunization-correction)
* entity[removalEntry][+].role = #removal
* entity[removalEntry][=].what = Reference(Condition/ex-corrected)
* entity[removalEntry][+].role = #removal
* entity[removalEntry][=].what = Reference(Immunization/ex-immunization-wrong)
* entity[removalEntry][+].role = #removal
* entity[removalEntry][=].what = Reference(Condition/ex-condition-initial)



