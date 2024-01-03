*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     RequestsLibrary
Resource    Get_IAM_AUTH_Access.robot

*** Variables ***
${base_url}             https://api-dev.setel.com/api/parking/sessions
${accept_header}        application/json
${content_type}         application/json
#${plate_number}         KIM1802    #  VCE1234
#${entry_lane}           141
#${location_code}        7043
${AccessToken}
${sessionParking}


*** Keywords ***
CreateParkingSession
    [Documentation]    Create a parking session
    [Arguments]     ${base_url}     ${plate_number}     ${entry_lane}    ${location_code}
    ${url}          Set Variable        ${base_url}/api/parking/sessions
    Log   ${url}

    ${sessionAccessToken}      Run Keyword And Return Status    Get_IAM_AUTH_Access.AuthLogin   https://api.dev2.setel.my   setel-finance2@email.com    Treasury@123456

    ${headers}    Create Dictionary       accept=${accept_header}        access-token=${AccessToken}    Content-Type=${content_type}
    ${data}       Create Dictionary       plateNumber=${plate_number}    entryLane=${entry_lane}        locationCode=${location_code}
    ${response}   POST    ${url}          json=${data}                   headers=${headers}

#    ${response}   POST    ${base_url}          json=${data}                   headers=${headers}
#    Log    ${response.content}
#    Log    ${response.status_code}

    Should Be Equal As Numbers      ${response.status_code}     200
    ${sessionParking}               Get From Dictionary         ${response.json()}      sessionId
    Set Global Variable             ${ParkingSessionId}         ${sessionParking}