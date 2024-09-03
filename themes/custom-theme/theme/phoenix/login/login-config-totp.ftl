<#import "template.ftl" as layout>
<#import "password-commons.ftl" as passwordCommons>
<@layout.registrationLayout displayRequiredFields=false displayMessage=!messagesPerField.existsError('totp','userLabel'); section>

    <#if section = "header">
        ${msg("loginTotpTitle")}
    <#elseif section = "form">
        <ol id="kc-totp-settings">
            <li>
                <p>${msg("loginTotpStep1")}</p>

                <ul id="kc-totp-supported-apps">
                    <#list totp.supportedApplications as app>
                        <li>${msg(app)}</li>
                    </#list>
                </ul>
            </li>

            <#if mode?? && mode = "manual">
                <li>
                    <p>${msg("loginTotpManualStep2")}</p>
                    <p><span id="kc-totp-secret-key">${totp.totpSecretEncoded}</span></p>
                    <p><a href="${totp.qrUrl}" id="mode-barcode">${msg("loginTotpScanBarcode")}</a></p>
                </li>
                <li>
                    <p>${msg("loginTotpManualStep3")}</p>
                    <p>
                    <ul>
                        <li id="kc-totp-type">${msg("loginTotpType")}: ${msg("loginTotp." + totp.policy.type)}</li>
                        <li id="kc-totp-algorithm">${msg("loginTotpAlgorithm")}: ${totp.policy.getAlgorithmKey()}</li>
                        <li id="kc-totp-digits">${msg("loginTotpDigits")}: ${totp.policy.digits}</li>
                        <#if totp.policy.type = "totp">
                            <li id="kc-totp-period">${msg("loginTotpInterval")}: ${totp.policy.period}</li>
                        <#elseif totp.policy.type = "hotp">
                            <li id="kc-totp-counter">${msg("loginTotpCounter")}: ${totp.policy.initialCounter}</li>
                        </#if>
                    </ul>
                    </p>
                </li>
            <#else>
                <li>
                    <p>${msg("loginTotpStep2")}</p>
                    <img id="kc-totp-secret-qr-code" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: Barcode"><br/>
                    <p><a href="${totp.manualUrl}" id="mode-manual">${msg("loginTotpUnableToScan")}</a></p>
                </li>
            </#if>
        </ol>

        <form action="${url.loginAction}" class="${properties.kcFormClass!}" id="kc-totp-settings-form" method="post">
            <!-- totp form field -->
            <div class="mb-3 text-start">
              <label class="form-label" for="totp">
                  ${msg("authenticatorCode")}<span class="text-danger">*</span>
              </label>
              <div class="form-icon-container">
                <input class="form-control form-icon-input <#if messagesPerField.existsError('totp')>is-invalid</#if>" id="totp" type="text" placeholder=${msg("authenticatorCode")}
                       name="totp" autocomplete="off" required="" aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>">
                  <span class="fas fa-key text-body fs-9 form-icon"></span>
                <#if messagesPerField.existsError('totp')>
                    <div class="invalid-feedback">
                        ${kcSanitize(messagesPerField.get('totp'))?no_esc}
                    </div>
                </#if>
              </div>
              <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
	          <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}"/></#if>
            <div>

            <div class="${properties.kcFormGroupClass!}">
                <@passwordCommons.logoutOtherSessions/>
            </div>

            <#if isAppInitiatedAction??>
                <input type="submit"
                       class="btn btn-primary w-100 mb-3"
                       id="saveTOTPBtn" value="${msg("doSubmit")}"
                />
                <button type="submit"
                        class="btn btn-primary w-100 mb-3"
                        id="cancelTOTPBtn" name="cancel-aia" value="true" />${msg("doCancel")}
                </button>
            <#else>
                <input type="submit"
                       class="btn btn-primary w-100 mb-3"
                       id="saveTOTPBtn" value="${msg("doSubmit")}"
                />
            </#if>
        </form>
    </#if>
</@layout.registrationLayout>
