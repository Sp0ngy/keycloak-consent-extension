<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>
    <#if section = "header">
        ${msg("updatePasswordTitle")}
    <#elseif section = "form">
        <form id="kc-passwd-update-form" action="${url.loginAction}" method="post" novalidate>
            <!-- New Password form field -->
            <div class="mb-3 text-start">
                <label class="form-label" for="password-new">
                    ${msg("passwordNew")}
                </label>
                <div class="form-icon-container">
                    <input class="form-control form-icon-input <#if messagesPerField.existsError('password','password-confirm')>is-invalid</#if>" id="password-new" name="password-new" type="password"
                           placeholder="Password" required aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>">
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
                           type="password" placeholder="Confirm Password" required aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>">
                    <span class="fas fa-key text-body fs-9 form-icon"></span>
                    <#if messagesPerField.existsError('password-confirm')>
                        <div class="invalid-feedback">
                            ${kcSanitize(messagesPerField.getFirstError('password-confirm'))?no_esc}
                        </div>
                    </#if>
                </div>
            </div>

            <div class="d-flex justify-content-between">
                <#if isAppInitiatedAction??>
                    <input class="btn btn-primary" type="submit" value="${msg("doSubmit")}" />
                    <button class="btn btn-secondary" type="submit" name="cancel-aia" value="true">${msg("doCancel")}</button>
                <#else>
                    <input class="btn btn-primary w-100" type="submit" value="${msg("doSubmit")}" />
                </#if>
            </div>
        </form>
        <script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>
    </#if>
</@layout.registrationLayout>
