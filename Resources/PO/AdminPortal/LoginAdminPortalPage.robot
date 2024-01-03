*** Settings ***
Library     Collections
Library     BuiltIn
Library     SeleniumLibrary


*** Keywords ***
LoginAdminPortal
    [Documentation]     Login to Admin portal
    [Arguments]             ${Userid}           ${Password}
    Input Text              //div/input         ${Userid}
    Input Text              //div[2]/input      ${Password}
    Click Button            //button[@type = 'submit' and (text() = 'LOG IN' or . = 'LOG IN')]
    Wait Until Page Contains Element    //*[text()='We are happy to see you again! Lets get productive today.']
    Page Should Contain     We are happy to see you again! Lets get productive today.

GotoMobility-SessionsPage
    Wait Until Element Is Visible   //button[(text() = 'Off-street parking' or . = 'Off-street parking')]
    Click Button                    //button[(text() = 'Off-street parking' or . = 'Off-street parking')]
    Wait Until Element Is Visible   //a[@href = '/off-street-parking/sessions' and (text() = 'Sessions' or . = 'Sessions')]
    Click Element                   //a[@href = '/off-street-parking/sessions' and (text() = 'Sessions' or . = 'Sessions')]

GotoMobility-LocationsPage
    Wait Until Element Is Visible   //button[(text() = 'Off-street parking' or . = 'Off-street parking')]
    Click Button                    //button[(text() = 'Off-street parking' or . = 'Off-street parking')]
    Wait Until Element Is Visible   //a[@href = '/off-street-parking/locations' and (text() = 'Locations' or . = 'Locations')]
    Click Element                   //a[@href = '/off-street-parking/locations' and (text() = 'Locations' or . = 'Locations')]

    



