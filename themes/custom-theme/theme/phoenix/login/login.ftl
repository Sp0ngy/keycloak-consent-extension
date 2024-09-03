<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section == "header">
    <#elseif section == "form">
            <a class="d-flex flex-center text-decoration-none mb-4">
              <div class="d-flex align-items-center fw-bolder fs-3 d-inline-block">
                <img src="${url.resourcesPath}/img/Oncoprevia.svg" alt="Oncoprevia" width="250">
              </div>
            </a>
            <div class="text-center mb-4">
              <h3 class="text-body-highlight fw-semi-bold">${msg("loginAccountTitle")}</h3>
            </div>

            <#if realm.password>
                <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post" novalidate>
                    <#if !usernameHidden??>
                        <!-- username form field -->
                        <div class="mb-3 text-start">
                          <label class="form-label" for="username">
                              <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
                          </label>
                          <div class="form-icon-container">
                            <input class="form-control form-icon-input <#if messagesPerField.existsError('username')>is-invalid</#if>" tabindex="1" id="username" name="username" value="${(login.username!'')}"
                                   type="text" autofocus autocomplete="off" placeholder="name@example.com" required=""
                                   aria-invalid="<#if messagesPerField.existsError('username')>true</#if>" />
                              <span class="fas fa-user text-body fs-9 form-icon"></span>
                            <#if messagesPerField.existsError('username')>
                                <div class="invalid-feedback">
                                    ${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}
                                </div>
                            </#if>
                          </div>
                        </div>
                    </#if>
                    <!-- password form field -->
                    <div class="mb-3 text-start">
                      <label class="form-label" for="password">
                          ${msg("password")}
                      </label>
                      <div class="form-icon-container">
                        <input class="form-control form-icon-input <#if messagesPerField.existsError('password')>is-invalid</#if>" id="password" type="password" placeholder=${msg("password")}
                               tabindex="2" name="password" autocomplete="off" required=""
                               aria-invalid="<#if messagesPerField.existsError('password')>true</#if>">
                          <span class="fas fa-key text-body fs-9 form-icon"></span>
                        <#if messagesPerField.existsError('password')>
                            <div class="invalid-feedback">
                                ${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}
                            </div>
                        </#if>
                      </div>
                    </div>
                    <div class="row flex-between-center mb-4">
                      <div class="col-auto">
                        <#if realm.rememberMe && !usernameHidden??>
                        <div class="form-check mb-0">
                            <#if login.rememberMe??>
                                <input class="form-check-input" tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                            <#else>
                                <input class="form-check-input" tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                            </#if>
                          <label class="form-check-label mb-0" for="rememberMe">Remember me</label>
                        </div>
                        </#if>
                      </div>
                      <#if realm.resetPasswordAllowed>
                        <div class="col-auto"><a class="fs-9 fw-normal" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></div>
                      </#if>
                    </div>
                    <button class="btn btn-primary w-100 mb-3" type="submit">${msg("doLogIn")}</button>
                </form>
                    <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                        <div class="text-center fw-normal">
                            <p>${msg("noAccount")} <a tabindex="6" href="${url.registrationUrl}">${msg("doRegister")}</a></p>
                        </div>
                    </#if>
            </#if>
    <#elseif section == "info">

    <#elseif section == "socialProviders">
        <#if realm.password && social.providers??>
            <div class="text-center mb-4">
                <#list social.providers as p>
                    <button class="btn btn-phoenix-secondary w-100 mb-3" onclick="window.location.href='${p.loginUrl}'">
                        <i class="${p.iconClasses}" aria-hidden="true"></i>${p.displayName}
                    </button>
                </#list>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>
