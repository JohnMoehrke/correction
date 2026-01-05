
# Correction example IG

 When data are corrected, especially when the Patient themselves reported that the data was wrong, there needs to be breadcrumbs left behind 

so that future uses understand the past might have seen different data
so that requests for data, especially from outside (e.g. HIE), can see that previous data has been corrected.

IG ticket https://jira.hl7.org/browse/FHIR-53782


The corrected data needs to (should) have a profiled Provenance so that future use of the data can clearly see that the data was corrected.

I would recommend a Profile on Provenance. (Note I recommend recording both the reference and business identifiers as they may be what is needed downstream to fully match, especially in the case of data removal)
a. Provenance indicates that this Reference and Identifier are to be deleted
b. Provenance indicates that this Reference and Identifier are to be replaced by Target.

Where Provenance.activity is given a couple of codes to indicate patient requested correction.

Where Provenance.entity also points at the records corrected communication. entity.role=#instantiates


FHIR Core Ticket: https://jira.hl7.org/browse/FHIR-53783


TODO: Trigger when AI detects the error.

## CI Build

- ci-build - http://build.fhir.org/ig/JohnMoehrke/correction/branches/main/index.html
- ci-build for FHIR R6 - https://build.fhir.org/ig/JohnMoehrke/correction/branches/R6/index.html

## Status

This is a trial IG to explore using Provenance to track corrections to data.

