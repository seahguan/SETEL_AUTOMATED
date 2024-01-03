*** Settings ***
Library    Collections
Library    BuiltIn
Library    SeleniumLibrary

Resource    ../Resources/PO/AdminPortal/LoginAdminPortalPage.robot
Resource    ../Resources/PO/AdminPortal/Off_Street_parking-SessionPage.robot
Resource    ../Resources/API/CreateParkingSession.robot
Resource    ../Resources/API/GetListOfParkingSession.robot

*** Variables ***
${ParkingSessionId}
${baseUrl}              https://api-dev.setel.com
${CarPlateNo}           KIM1802

*** Test Cases ***
Void Session-Void Category is Manual
    [Documentation]     ADMIN: Void Session | Void Category is Manual
    [Tags]              PR-1351

    # Check is there any active session under this car plate no
    GetListOfParkingSession     ${baseUrl}      ${CarPlateNo}   ACTIVE

    # Create Parking Session
    CreateParkingSession     ${baseUrl}     ${CarPlateNo}    141    7043
    Log     ${ParkingSessionId}
    # open Browser
    Open Browser                        ${baseUrl}/login    chrome
    Maximize Browser Window
    Wait Until Page Contains Element   //label[text()='Email address']      timeout=30s
    Page Should Contain                 Email address
    LoginAdminPortal                    setel-finance2@email.com            Treasury@123456
    GotoMobility-SessionsPage
    VerifySessionsPage
    SearchWithCarPlateNo                ${CarPlateNo}
    ClickSearchIcon
    ClickCarPlateActiveSession          ${ParkingSessionId}
    EditParkingSession                  'Voided'

    # login MixPanel - missing mix panel login credential
    # Find the rec - search for the latest event related
                         #parking_session_voided and expand it
    # Verify the mix panel rec - Verify void_catogery value is manual
    Close All Browsers

