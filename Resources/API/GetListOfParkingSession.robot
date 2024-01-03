*** Settings ***
Library     Collections
Library     RequestsLibrary
Resource    Get_IAM_AUTH_Access.robot
Resource    DisableActiveParkingSession.robot
Library     BuiltIn

*** Variables ***
#${base_urlB}            https://api-dev.setel.com
${accept_header}        application/json
#${sessionStatus}        ACTIVE
#${plateNumber}          KIM1802
${paymentMethod}        UNKNOWN_TYPE
${AccessToken}
${parkingSessionId}


*** Keywords ***
GetListOfParkingSession
    [Documentation]     Get List of Parking Session by Carplate no
    [Arguments]         ${baseUrl}      ${plateNumber}      ${ParkingStatus}

    # get AUTH access code
    ${sessionAccessToken}       Run Keyword And Return Status       Get_IAM_AUTH_Access.AuthLogin   https://api.dev2.setel.my   setel-finance2@email.com    Treasury@123456
#    ${plateNumber}              Set Variable    KIM1802
    # setting Endpoint params & headers
    Create Session              my_session                          ${baseUrl}
    ${headers}                  Create Dictionary                   accept=${accept_header}                 access-token=${AccessToken}
    ${params}                   Create Dictionary                   sessionStatus=${ParkingStatus}
    ...                         plateNumber=${plateNumber}          paymentMethod=${paymentMethod}
    Log Many    ${headers}  ${params}   my_session

    # Trigger endpoint to get list of active session
    ${response}                 GET On Session                      my_session  /api/parking/sessions       headers=${headers}
    ...                         params=${params}

    # retreive neccessary info from respons
    IF    ${response.status_code} == '200'
        ${recordLength}             Set Variable                        ${response.json()['metadata']['totalCount']}
        IF    ${recordLength} > 0
            ${parkingSessionId}     Set Variable    ${response.json()['data'][0]['id']}
            Log   ${parkingSessionId}
            DisableParkingSession   ${baseUrl}  ${parkingSessionId}
        END
    ELSE
        Log   no active parking rec not found under this plate no
    END