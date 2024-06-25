# keycloak-consent-extension
Extension for Keycloak to manage User Consent. Implementation for:

## Versioning
- see `pom.xml`

## API
```
curl -X PUT "${OIDC_HOST}/realms/${OIDC_REALM}/custom-consent/${user_id}/consents" \
     -H "Authorization: Bearer ${token}" \
     -H "Content-Type: application/json" \
     -d '{"clientId": "${OIDC_RP_CLIENT_ID}", "grantedClientScopes": ["tos-accepted-v1.0", "marketing-accepted-v1.0"]}'
```
- authenticated REST API (`realm-admin` role required)
- `realm-admin` role has to be assigned to client `service-account` which is generally user for the Protection API of a realm
- hint: if working with default `master` realm, it will throw ForbiddenException
- UserConsentModel gets update (behind the scene, the consent is revoked and newly created - constraint through available methods)

## Build maven project JAR and Deployment on docker-compose
- `mvn clean package`
- copy package to `keycloak/deployment` which is mounted on `- ./keycloak/deployment:/opt/keycloak/providers` via docker-compose
- start keycloak server and check under <YourRealm>->Provider info these entries:
    1. `realm-restapi-extension`: `custom-consent`
    2. `protocol-mapper`: `oidc-consent-mapper`
    -> If existing, means they a properly installed

## Manual Configuration in Keycloak
- create a new scope in your Realm under Client Scopes (type `Optional` required)
- assign new scope to your Client-><YourClient>->Client scopes->Add client scope
- create new Consent Mapper:
    - Client-><YourClient>->Client scopes->`<YourClient>-dedicated`->Add mapper->By configuration
    - Select `ConsentMapper` and configure it, e.g. `Name: Consent Mapper`, `Token Claim Name: consent`

## Deploy custom Java Script police
- install JDK
- on windows in `<root>\kc_policies\` exec `"C:\Program Files\Java\jdk-21\bin\jar.exe" -cvf keycloakPolicies-1.0.jar -C . .`
- copy JAR file to `keycloak/deployment`
- Keycloak admin UI is buggy with custom JS policies, needs to save first to show JS code
- Instruction: https://keycloak.discourse.group/t/how-to-create-js-policy/22821/2

## Build custom theme JAR
- on windows in `<root>\themes\custom-theme` exec `"C:\Program Files\Java\jdk-21\bin\jar.exe" -cvf custom_themes-1.0.jar -C . .`