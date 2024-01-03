*** Settings ***
Library    Collections
Library    BuiltIn
Library    SeleniumLibrary

Resource    ../Resources/PO/AdminPortal/LoginAdminPortalPage.robot
Resource    ../Resources/PO/AdminPortal/Off_Street_parking-Locations.robot


*** Variables ***
${baseUrl}              https://dev-admin.setel.my/login
${adminPortalId}        setel-finance2@email.com
${adminPortalPass}      Treasury@123456

*** Test Cases ***
Create and update location
    [Documentation]     ADMIN: Location List | Location order | Create and update location
    Open Browser                        ${baseUrl}    chrome
    Maximize Browser Window
    Wait Until Page Contains Element   //label[text()='Email address']      timeout=30s
    Page Should Contain                 Email address
    LoginAdminPortal                    ${adminPortalId}                ${adminPortalPass}
    GotoMobility-LocationsPage
    CreateNewLocations                  635fc76dc0b8ec0011e06bcb        AutomationTestLocation

    Sleep    10s
