<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>
    <#if section = "header">
        ${msg("emailForgotTitle")}
    <#elseif section = "form">
        <form id="kc-reset-password-form" action="${url.loginAction}" method="post" novalidate>
            <!-- username form field -->
            <div class="mb-3 text-start">
              <label class="form-label" for="username">
                  <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
              </label>
              <div class="form-icon-container">
                <input class="form-control form-icon-input <#if messagesPerField.existsError('username')>is-invalid</#if>" tabindex="1" id="username" name="username" value="${(login.username!'')}"
                       type="text" autofocus autocomplete="off" placeholder="name@example.com" required=""
                       aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />
                  <span class="fas fa-user text-body fs-9 form-icon"></span>
                <#if messagesPerField.existsError('username','password')>
                    <div class="invalid-feedback">
                        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                    </div>
                </#if>
              </div>
            </div>
            <!-- Form Buttons -->
            <div class="d-flex justify-content-between">
                <a href="${url.loginUrl}" class="btn btn-link">${kcSanitize(msg("backToLogin"))?no_esc}</a>
                <button class="btn btn-primary" type="submit" value="${msg("doSubmit")}">${msg("doSubmit")}</button>
            </div>
        </form>
    <#elseif section = "info" >
        <#if realm.duplicateEmailsAllowed>
            <div class="d-flex justify-content-between">
                <p>${msg("emailInstructionUsername")}</p>
            </div>
        <#else>
            <div class="d-flex justify-content-between">
                <p>${msg("emailInstruction")}</p>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>
