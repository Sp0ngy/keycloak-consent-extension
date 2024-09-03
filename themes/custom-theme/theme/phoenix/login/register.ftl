<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=true; section>
    <#if section == "header">
    <#elseif section == "form">
        <a class="d-flex flex-center text-decoration-none mb-4">
          <div class="d-flex align-items-center fw-bolder fs-3 d-inline-block">
            <img src="${url.resourcesPath}/img/Oncoprevia.svg" alt="Oncoprevia" width="250">
          </div>
        </a>
        <div class="text-center mb-7">
          <h3 class="text-body-highlight fw-semi-bold">${msg("registerTitle")}</h3>
        </div>
        <form id="kc-register-form" action="${url.registrationAction}" method="post" novalidate>
            <!-- Email form field -->
            <div class="mb-3 text-start">
                <label class="form-label" for="email">
                    ${msg("email")}
                </label>
                <div class="form-icon-container">
                    <input class="form-control form-icon-input <#if messagesPerField.existsError('email')>is-invalid</#if>" id="email" name="email" type="email"
                           value="${(login.email!'')}" autofocus autocomplete="off" placeholder="name@example.com"
                           required aria-invalid="<#if messagesPerField.existsError('email')>true</#if>">
                    <span class="fas fa-user text-body fs-9 form-icon"></span>
                    <#if messagesPerField.existsError('email')>
                        <div class="invalid-feedback">
                            ${kcSanitize(messagesPerField.getFirstError('email'))?no_esc}
                        </div>
                    </#if>
                </div>
            </div>
            <!-- Password form field -->
            <div class="mb-3 text-start">
                <label class="form-label" for="password">
                    ${msg("password")}
                </label>
                <div class="form-icon-container">
                    <input class="form-control form-icon-input <#if messagesPerField.existsError('password')>is-invalid</#if>" id="password" name="password" type="password"
                           placeholder=${msg("password")} required aria-invalid="<#if messagesPerField.existsError('password')>true</#if>">
                    <span class="fas fa-key text-body fs-9 form-icon"></span>
                    <#if messagesPerField.existsError('password')>
                        <div class="invalid-feedback">
                            ${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}
                        </div>
                    </#if>
                </div>
            </div>
            <!-- Password confirmation form field -->
            <div class="mb-3 text-start">
                <label class="form-label" for="password-confirm">
                    ${msg("passwordConfirm")}
                </label>
                <div class="form-icon-container">
                    <input class="form-control form-icon-input <#if messagesPerField.existsError('password-confirm')>is-invalid</#if>" id="password-confirm" name="password-confirm"
                           type="password" placeholder=${msg("passwordConfirm")} required aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>">
                    <span class="fas fa-key text-body fs-9 form-icon"></span>
                    <#if messagesPerField.existsError('password-confirm')>
                        <div class="invalid-feedback">
                            ${kcSanitize(messagesPerField.getFirstError('password-confirm'))?no_esc}
                        </div>
                    </#if>
                </div>
            </div>


            <#if termsAcceptanceRequired??>
            <div class="row d-flex justify-content-center mb-2">
                <div class="col-6 d-flex flex-column align-items-center justify-content-center">
                    <a class="icon-nav-item btn border-0" target="_blank" href="https://s3.eu-central-3.ionoscloud.com/publicdocuments/AGB_B2C_Oncoprevia.pdf">
                        <div class="icon-container mb-2 bg-info-100 d-flex justify-content-center align-items-center" style="width: 100px; height: 100px;">
                          <span class="nav-link-icon far fa-file-alt fa-5x"></span></div>
                      <h6 class="nav-label">${msg("termsTitle")}</h6>
                    </a>
                </div>
                <!-- TODO: add url -->
                <div class="col-6 d-flex flex-column align-items-center justify-content-center">
                    <a class="icon-nav-item btn border-0" target="_blank" href="https://s3.eu-central-3.ionoscloud.com/publicdocuments/WRB_B2C_Oncoprevia.pdf">
                        <div class="icon-container mb-2 bg-info-100 d-flex justify-content-center align-items-center" style="width: 100px; height: 100px;">
                          <span class="nav-link-icon fas fa-shield fa-5x"></span></div>
                      <h6 class="nav-label">${msg("dataTitle")}</h6>
                    </a>
                </div>
            </div>
            <div class="form-check mb-3">
                <input type="checkbox" id="termsAccepted" name="termsAccepted" class="form-check-input <#if messagesPerField.existsError('termsAccepted')>is-invalid</#if>"
                       aria-invalid="<#if messagesPerField.existsError('termsAccepted')>true</#if>">
                <label for="termsAccepted" class="form-check-label">${msg("acceptTerms")}</label>
                <#if messagesPerField.existsError('termsAccepted')>
                    <div class="invalid-feedback mt-0">
                        ${kcSanitize(messagesPerField.get('termsAccepted'))?no_esc}
                    </div>
                </#if>
            </div>
            </#if>
            <!-- Form Buttons -->
            <div class="d-flex justify-content-between">
                <a href="${url.loginUrl}" class="btn btn-link">${kcSanitize(msg("backToLogin"))?no_esc}</a>
                <button class="btn btn-primary" type="submit">${msg("doRegister")}</button>
            </div>
        </form>
    <script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>
    </#if>
</@layout.registrationLayout>
