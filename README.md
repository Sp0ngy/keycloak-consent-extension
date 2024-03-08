# keycloak-consent-extension
Extension for Keycloak to manage User Consent. Implementation for:

## API
```
curl -X PUT "${OIDC_HOST}/realms/${OIDC_REALM}/custom-consent/${user_id}/consents" \
     -H "Authorization: Bearer ${token}" \
     -H "Content-Type: application/json" \
     -d '{"clientId": "${OIDC_RP_CLIENT_ID}", "grantedClientScopes": ["tos-accepted-v1.0", "marketing-accepted-v1.0"]}'
```
- API called using Client access token
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