# DSB

### 5. Lage og tilby moduler

Vi ønsker å etablere et sett med standardiserte DSB-Terraform-moduler. Disse skal ha defaults hensiktsmessig for DSB, sørge for at vi etablerer infrastruktur mest mulig uniformt i Azure og gjøre det lettere for oss å gjøre endringer på mange steder samtidig.

Hva er viktige hensyn å ta her? Og, hvis du skulle bygge opp en standardisert CI/CD-prosess for Terraform-moduler, hvilke prosesser skulle den bestått av?

## Forslag

Dette er et forslag om å bruke Terraform i en monorepo og implementere CI/CD. Dette forslaget fungerer best for et lite-medium prosjekt, når kompleksiteten øker, bør vi bruke sub-modules for å ha mer fleksibilitet.

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

![alt text](https://github.com/c00ler82/terraform-demo/raw/15855620927413c54c34b015e2fe8119b7fb887e/images/pipeline.png)

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

![alt text](https://github.com/c00ler82/terraform-demo/raw/15855620927413c54c34b015e2fe8119b7fb887e/images/terra-docs.webp)
