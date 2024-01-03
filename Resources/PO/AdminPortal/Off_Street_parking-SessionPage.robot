*** Settings ***
Library     Collections
Library     BuiltIn
Library     SeleniumLibrary


*** Keywords ***
VerifySessionsPage
    [Documentation]     Validate Session page
    Wait Until Page Contains Element    //h1[text() = 'Sessions']
    Page Should Contain    Sessions
    
SearchWithCarPlateNo
    [Documentation]
    [Arguments]     ${CarPlateNo}
    ${SearchVehiclePlateNo_Field}   Set Variable    //input[@id='getParkingSessionsplateNumber']
    Input Text                      ${SearchVehiclePlateNo_Field}   ${CarPlateNo}
#    Press Keys      ${SearchVehiclePlateNo_Field}   \\13


ClickSearchIcon
    [Documentation]     Search Parking Session with Car Plate No && Status=Active
    ${button_Search}                Set Variable    //input[@id='getParkingSessionsplateNumber']/parent::div/following-sibling::button
    ${Search_Result_Text}           Set Variable    //span[text()='Search results for:']
    ${Status_Filter}                Set Variable    //label[@for='getParkingSessionssessionStatus']/following-sibling::div
#    ${DropDown_Options}             Set Variable    //ul[@role='listbox']

#    Click Element                   ${Status_Filter}
    Click Element                   ${button_Search}
    Wait Until Element Is Visible   ${Search_Result_Text}


ClickCarPlateActiveSession
    [Documentation]
    [Arguments]     ${ParkingSessionId}
    ${RecURL}           Set Variable        https://https://dev-admin.setel.my/off-street-parking/sessions/
    ${SelectRecHREF}    Catenate            ${RecURL}   ${ParkingSessionId}
    ${Tables}           Set Variable        //a[@data-testid='sessions-row']
    ${Tables2}          Set Variable        //div[@class='pu-table-row-group'][2]/child::a

    Wait Until Element Is Visible    ${Tables2}
    ${TableElements}    Get WebElements     ${Tables2}

    ${ActiveOption}                 Set Variable    //div[(text() = 'Active' or . = 'Active')]
    sleep   1s
    Wait Until Element Is Visible   ${ActiveOption}
    Click Element                   ${ActiveOption}
#    sleep   15s

EditParkingSession
    [Documentation]     Edit Parking Session status
    [Arguments]     ${New_Status}
    ${button_name}          Set Variable        "EDIT"
    ${Edit_Header}          Set Variable        //div[@data-testid='edit-session-modal']
    ${EditStatusField}      Set Variable        //span[text()='Active']/ancestor::div[@data-value='ACTIVE']
    ${Edit_Option}          Set Variable        //div[text() = ${New_Status}]
    ${Remark_txt}           Set Variable        //textarea[@name='remarks']
    ${Button}               Set Variable        //button[text()=${button_name}]

    Log     ${New_Status}
    Wait Until Element Is Visible       ${Button}
    Click Element                       ${Button}

    Wait Until Element Is Visible       ${Edit_Header}
    Click Element                       ${EditStatusField}
    Click Element                       ${Edit_Option}
    Click Element                       ${Remark_txt}
    Input Text                          ${Remark_txt}       Automation testing
    ${button_name}                      Set Variable        "CANCEL"
    ${Button}                           Set Variable        //button[text()=${button_name}]
    Click Element                       ${Button}
#    ${button_name}  set Variables    'SAVE CHANGES'
#    Click Element                       ${Button}







