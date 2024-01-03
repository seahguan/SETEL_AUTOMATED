*** Settings ***
Library     Collections
Library     RequestsLibrary
Resource    Get_IAM_AUTH_Access.robot
Resource    DisableActiveParkingSession.robot
Library     BuiltIn

*** Variables ***
${endpoint}             /api/parking/sessions/
${accept_header}        application/json
${content_type}         application/json
${AccessToken}


*** Keywords ***
DisableParkingSession
    [Documentation]    Disable Active Parking session
    [Arguments]         ${base_url}     ${session_id}
    ${sessionAccessToken}       Run Keyword And Return Status       Get_IAM_AUTH_Access.AuthLogin   https://api.dev2.setel.my   setel-finance2@email.com    Treasury@123456
    ${url}      Set Variable    ${base_url}${endpoint}
    Log     ${url}

    # setting Endpoint params & headers
    Create Session    my_session          ${base_url}
    ${headers}        Create Dictionary   accept=${accept_header}    access-token=${AccessToken}
    ${payload}        Create Dictionary   remarks=Automationtest

    # Trigger endpoint to get list of active session
    ${response}       PUT On Session       my_session  ${session_id}    headers=${headers}     json=${payload}

    Should Be Equal As Strings    '200'    ${response.status_code}
    Log     ${response.content}