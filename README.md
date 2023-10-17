# Terraform beste praksis

Verktøy som brukes:

- Terraform
- Github Actions
- Terratest
- Checkov
- pre-commit

## Hensyn og beste praksis

- DRY (Don’t Repeat Yourself).
- Sett “state” filen i skyen og bruk versionkontroll og Backup.
- Bruk Azure KeyVault og Github Secrets for å lage legimitasjon og sensitiv informasjon.
- Ikke endre infrastrukturen manuelt, dette kan føre til at “state” filen ikke er synkronisert og kan forårsake problemer.
- Unngå å gi nytt navn til allerede eksistere ressurse, dette kan føre til å slette den gamle ressursen som kan være nødvendig.
- Bruk forskjellige Azure-kontoer for forskjellige miljøer.
- Sørg alltid for at alle ressurser blir ødelagt etter testing.
- Bruk alltid den samme Terraform-versjonen for alle utviklere.
- Bruk terragrunt for å minimere koderepetisjoner.
- Bruk makefile for å forhindre menneskelige feil.

## Pipeline

Vi bruker Github-handlinger og andre verktøysett for å oppnå CI/CD.

![pipeline](https://github.com/c00ler82/terraform-demo/assets/29115833/158f35d1-2a3e-4a7e-ac10-4b341f0c5aed)

### Trinn

1. [pre-commit](https://www.notion.so/Terraform-cce392058dd648b1b6029995bddb0a9b?pvs=21) (Unit Test):

   Vi sørger for at vi har følgende på plass:

   - Formatering
   - Linting
   - terraform validate
   - Generere dokumentasjon ved å bruke [terra-docs](https://docs.terra.money/) (se på eksemplet nedenfor)
   - Statiske sikkerhetskontroller ved å bruke [checkov](https://www.checkov.io/)

2. Github Actions:
   1. Plan: Om dette mislyktes, fortsetter vi til neste trinn for å skrive ut utdataene.
   2. Apply: Nå har vi all infrastruktur på plass.
   3. Integration test: Vi bruker terratest for at vi sørger for at all infrastruktur fungerer som de skal.
   4. Destroy: Om dette er DEV, må vi ødelagt all infrastrukturer.

terra-docs eksempel

![terra-docs](https://github.com/c00ler82/terraform-demo/assets/29115833/d10fd5e6-0ae7-4d07-910d-48cfbc6a2b8b)
