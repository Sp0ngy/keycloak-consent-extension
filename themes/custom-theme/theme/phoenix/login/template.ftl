<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
<html class="${properties.kcHtmlClass!}"<#if realm.internationalizationEnabled> lang="${locale.currentLanguageTag}"</#if>>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if authenticationSession??>
        <script type="module">
            import { checkCookiesAndSetTimer } from "${url.resourcesPath}/js/authChecker.js";

            checkCookiesAndSetTimer(
              "${authenticationSession.authSessionId}",
              "${authenticationSession.tabId}",
              "${url.ssoLoginInOtherTabsUrl}"
            );
        </script>
    </#if>
</head>

<body id="keycloak-bg" class="${properties.kcBodyClass!}">
<div id="kc-header""></div>
    <main class="main">
    <div class="container">
        <div class="row flex-center min-vh-100 py-5">
          <div class="col-sm-10 col-md-8 col-lg-5 col-xl-5 col-xxl-3">

              <header class="">
                <h1 class=""><#nested "header"></h1>
              </header>

              <div class="text-center">
                <#-- App-initiated actions should not see warning messages about the need to complete the action -->
                <#-- during login.                                                                               -->
                <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                    <#if message.type = 'success'><div class="${properties.kcFeedbackSuccessIcon!}">${kcSanitize(message.summary)?no_esc}</div></#if>
                    <#if message.type = 'warning'><div class="${properties.kcFeedbackWarningIcon!}">${kcSanitize(message.summary)?no_esc}</div></#if>
                    <#if message.type = 'error'><div class="${properties.kcFeedbackErrorIcon!}">${kcSanitize(message.summary)?no_esc}</div></#if>
                    <#if message.type = 'info'><div class="${properties.kcFeedbackInfoIcon!}">${kcSanitize(message.summary)?no_esc}</div></#if>
                </#if>
              </div>

                <#nested "form">

                <#if displayInfo>
                  <div id="kc-info" class="${properties.kcSignUpClass!}">
                      <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                          <#nested "info">
                      </div>
                  </div>
                </#if>
              </div>
              <footer class="pf-v5-c-login__main-footer">
                <#nested "socialProviders">
              </footer>
          </div>
        </div>
    </div>
    </main>
</div>
</body>
</html>
</#macro>
