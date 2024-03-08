package curiescience.keycloak.resource;

import jakarta.ws.rs.ForbiddenException;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.NotAuthorizedException;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.ext.Provider;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.enums.SchemaType;
import org.eclipse.microprofile.openapi.annotations.media.Content;
import org.eclipse.microprofile.openapi.annotations.media.Schema;
import org.eclipse.microprofile.openapi.annotations.responses.APIResponse;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.RealmModel;
import org.keycloak.models.ClientModel;
import org.keycloak.models.UserModel;
import org.keycloak.models.UserProvider;
import org.keycloak.models.UserConsentModel;
import org.keycloak.models.ClientScopeModel;
import org.keycloak.services.managers.AppAuthManager;
import org.keycloak.services.managers.AuthenticationManager.AuthResult;
import org.keycloak.services.resource.RealmResourceProvider;
import org.keycloak.representations.idm.UserConsentRepresentation;

import java.util.Map;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.ArrayList;

@Provider
// https://github.com/keycloak/keycloak/issues/25882
public class ConsentResourceProvider implements RealmResourceProvider {

	private final KeycloakSession session;

	public ConsentResourceProvider(KeycloakSession session) {
        this.session = session;
    }

	@Override
	public Object getResource() {
		return this;
	}

	@Override
	public void close() {
	}

	/* @GET
	@Path("hello")
	@Produces(MediaType.APPLICATION_JSON)
	public Response helloAnonymous() {
		return Response.ok(Map.of("hello", session.getContext().getRealm().getName())).build();
	} */

	@PUT
	@Path("{userId}/consents")
	@Produces(MediaType.APPLICATION_JSON)
	// Overwrites all scopes within the UserConsentModel object. Send all granted scopes via payload.
	public Response updateConsent(@PathParam("userId") String userId, UserConsentRepresentation consentRep) {
		RealmModel realm = session.getContext().getRealm();
		UserProvider userProvider = session.users();
		ClientModel client = realm.getClientByClientId(consentRep.getClientId());
		UserModel user = session.users().getUserById(realm, userId);

		// Validate Objects existence
		if (client == null) {
			return Response.status(Response.Status.NOT_FOUND).entity("Client not found").build();
		}
		if (user == null) {
			return Response.status(Response.Status.NOT_FOUND).entity("User not found").build();
		}

		// Revoke existing consent if it exists, UserConsentModel does not offer a method to update or delete clientScopes
		UserConsentModel existingConsent = userProvider.getConsentByClient(realm, userId, client.getId());
		if (existingConsent != null) {
			userProvider.revokeConsentForClient(realm, userId, client.getId());
		}	
		
		// construct the new UserConsentModel
		UserConsentModel updatedConsent = new UserConsentModel(client);

		List<String> grantedScopeNames = consentRep.getGrantedClientScopes();
		Map<String, ClientScopeModel> clientScopes = client.getClientScopes(false);  // all optional scopes if false, all default scopes if true
		
		for (String scopeName : grantedScopeNames) {
			ClientScopeModel clientScope = clientScopes.get(scopeName);
			if (clientScope != null) {
				updatedConsent.addGrantedClientScope(clientScope);
			} else {
				return Response.status(Response.Status.BAD_REQUEST).entity("Scope " + scopeName + " not found").build();
			}
		}

		// Add Consent to User
		userProvider.addConsent(realm, userId, updatedConsent);	

        return Response.ok().entity(String.format("Consent updated successfully.")).build();
    }

}

