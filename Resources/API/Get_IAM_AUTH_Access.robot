*** Settings ***
Library     Collections
Library     RequestsLibrary

*** Variables ***
#${base_urlA}             https://api.dev2.setel.my
${accept_header}        application/json
${content_type}         application/json
#${identifier}           setel-finance2@email.com
#${password}             Treasury@123456
${AccessToken}


*** Keywords ***
AuthLogin
    [Documentation]    Generate Access TOken using Login at IAM/AUTH
    [Arguments]     ${base_url}     ${identifier}    ${password}

#    Setup the Headers & Payload
    ${url}          Set Variable    ${base_url}/api/iam/setel-admins/auth/login
    ${headers}      Create Dictionary    accept=${accept_header}    Content-Type=${content_type}
    ${data}         Create Dictionary    identifier=${identifier}    password=${password}

#    Trigger to request access token
    ${response}     POST    ${url}        json=${data}    headers=${headers}

#    Log    ${response.content}
    Should Be Equal As Numbers      ${response.status_code}    201
    ${AccessToken}                  Get From Dictionary    ${response.json()}   accessToken
    Set Global Variable             ${AccessToken}
#    Log    ${AccessToken}