*** Settings ***
Resource        base.robot

Test Setup          Nova sessão
Test Teardown       Encerra sessão

*** Variables ***

*** Test Cases ***
Login com sucesso
    Go To                       ${url}/login
    Login With                  stark                                                   jarvis!
    #Page Should Contain         Olá, Tony Stark. Você acessou a área logada!
    Should see Logged user      Tony Stark
Senha inválida
    [tags]                      pwd_error
    Go To                       ${url}/login
    Login With                  stark                                                   abc123
    Should Contain Login Alert  Senha é invalida!
    # Page Should Contain         Senha é invalida!
    # ${message}=                 Get WebElement                                          id:flash
    # Should Contain              ${message.text}                                         Senha é invalida!

Usuário inválido
    [tags]                      usr_error
    Go To                       ${url}/login
    Login With                  abc123                                                  jarvis!
    Should Contain Login Alert  O usuário informado não está cadastrado!
    # Page Should Contain         O usuário informado não está cadastrado!
    # ${message}=                 Get WebElement                                          id:flash
    # Should Contain              ${message.text}                                         O usuário informado não está cadastrado!

*** Keywords ***
Login With
    [Arguments]                 ${uname}   ${pass}

    Input text                  id:userId                                               ${uname}
    Input Text                  id:passId                                               ${pass}
    Click Element               class:btn-login

Should Contain Login Alert
    [Arguments]                 ${expect_message}
    Page Should Contain         ${expect_message}
    ${message}=                 Get WebElement                                          id:flash
    Should Contain              ${message.text}                                         ${expect_message}

Should see Logged user
    [Arguments]                 ${full_name}

    Page Should Contain         Olá, ${full_name}. Você acessou a área logada!