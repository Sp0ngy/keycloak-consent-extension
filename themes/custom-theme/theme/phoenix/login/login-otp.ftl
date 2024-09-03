<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp'); section>
    <#if section="header">
        ${msg("doLogIn")}
    <#elseif section="form">
        <form id="kc-otp-login-form" class="${properties.kcFormClass!}" action="${url.loginAction}"
            method="post">
            <#if otpLogin.userOtpCredentials?size gt 1>
                <div class="${properties.kcFormGroupClass!}">
                    <div class="${properties.kcInputWrapperClass!}">
                        <#list otpLogin.userOtpCredentials as otpCredential>
                            <input id="kc-otp-credential-${otpCredential?index}" class="${properties.kcLoginOTPListInputClass!}" type="radio" name="selectedCredentialId" value="${otpCredential.id}" <#if otpCredential.id == otpLogin.selectedCredentialId>checked="checked"</#if>>
                            <label for="kc-otp-credential-${otpCredential?index}" class="${properties.kcLoginOTPListClass!}" tabindex="${otpCredential?index}">
                                <span class="${properties.kcLoginOTPListItemHeaderClass!}">
                                    <span class="${properties.kcLoginOTPListItemIconBodyClass!}">
                                      <i class="${properties.kcLoginOTPListItemIconClass!}" aria-hidden="true"></i>
                                    </span>
                                    <span class="${properties.kcLoginOTPListItemTitleClass!}">${otpCredential.userLabel}</span>
                                </span>
                            </label>
                        </#list>
                    </div>
                </div>
            </#if>

            <!-- otp form field -->
            <div class="mb-3 text-start">
              <label class="form-label" for="otp">
                  ${msg("authenticatorCode")}<span class="text-danger">*</span>
              </label>
              <div class="form-icon-container">
                <input class="form-control form-icon-input <#if messagesPerField.existsError('otp')>is-invalid</#if>" id="otp" type="text" placeholder=${msg("authenticatorCode")}
                       name="otp" autocomplete="off" required="" aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>">
                  <span class="fas fa-key text-body fs-9 form-icon"></span>
                <#if messagesPerField.existsError('totp')>
                    <div class="invalid-feedback">
                        ${kcSanitize(messagesPerField.get('totp'))?no_esc}
                    </div>
                </#if>
              </div>
            <div>

        </div>
            <p>${msg("lostOTPAccess")}</p>
            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                    </div>
                </div>

                <div class="col-auto">
                    <input
                        class="btn btn-primary w-100 mb-3"
                        name="login" id="kc-login" type="submit" value="${msg("doLogIn")}" />
                </div>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>