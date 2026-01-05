
Profile: CorrectionProvenanceProfile
Parent: Provenance
Title: "Provenance Profile for Corrections"
Description: "A profile of the Provenance resource to document corrections made to FHIR data."
* target MS
* target ^comment = "References the resource(s) that were corrected."
* recorded 1..1 MS
* recorded ^comment = "The instant of time at which the correction was made."
* activity MS
* activity = http://terminology.hl7.org/CodeSystem/v3-ActReason#FIXDATA
* activity ^comment = "The activity that resulted in the correction, e.g., data review or error detection."
* why 1..1 MS
* why ^comment = "The reason for the correction."
* agent MS
* agent ^comment = "The individual or system responsible for making the correction."
* entity MS
* entity ^comment = "Details about the corrected resource and the nature of the correction."
* basedOn MS
* basedOn ^comment = "References the reason for the correction, such as a DocumentReference containing correction details. In R4 this is an additional entity[] with role = instantiates."


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

Instance: ex-provenance-correction-removal
InstanceOf: CorrectionProvenanceProfile
Title: "Provenance for Correction Removal"
Description: "Provenance resource documenting the removal of incorrect food allergy observation. This example does not point at a resource that explains the correction, such as a DocumentReference."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* target[+] = Reference(Observation/ex-observation-food)
* recorded = "2024-06-01T12:00:00Z"
* agent[+].type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#author
* agent[=].who = Reference(http:///example.org/Practitioner/ex-practitioner)
* activity = http://terminology.hl7.org/CodeSystem/v3-ActReason#FIXDATA
* why = "Removed incorrect food allergy observation as it was found to be erroneous."
* entity[+].role = #removal
* entity[=].what = Reference(Observation/ex-observation-food)
* entity[=].what.display = "Incorrect Food Allergy Observation"
* patient = Reference(https://example.org/Patient/ex-patient)

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

Instance: ex-provenance-correction-replacement
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
* why = "Corrected immunization record to reflect accurate vaccine information."
* entity[+].role = #removal
* entity[=].what = Reference(Immunization/ex-immunization-wrong)
* entity[=].what.display = "Original Immunization Record with Errors"
* patient = Reference(https://example.org/Patient/ex-patient)

/* R4 */
/*
* entity[+].role = #instantiates
* entity[=].what = Reference(DocumentReference/ex-documentation-immunization-correction)
* entity[=].what.display = "Documentation of Immunization Correction"
*/
/* R4 */
/* R6 */
* basedOn[+] = Reference(DocumentReference/ex-documentation-immunization-correction)
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

Instance: ex-ai-error-detection
InstanceOf: CorrectionProvenanceProfile
Title: "Provenance for AI Error Detection"
Description: "Provenance resource documenting the detection of an error in FHIR data by an AI system."
Usage: #example
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* target[+] = Reference(Observation/ex-observation-food)
* recorded = "2024-06-01T14:00:00Z"
* agent[+].who = Reference(http:///example.org/Device/ex-ai-system)
* agent[=].type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#verifier 
* activity = http://terminology.hl7.org/CodeSystem/v3-ActReason#FIXDATA
* why = "AI system detected an inconsistency in the food allergy observation data."
* entity[+].role = #revision
* entity[=].what = Reference(Observation/ex-observation-food)
* entity[=].what.display = "Food Allergy Observation with Detected Error"
* patient = Reference(https://example.org/Patient/ex-patient)

