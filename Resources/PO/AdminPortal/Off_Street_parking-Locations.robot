*** Settings ***
Library     Collections
Library     BuiltIn
Library     SeleniumLibrary
Library     String

*** Variables ***
${AlphaNumericRegec}            ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
${buttonName}                   'Create'
${OptionsName}
${DDL_Name}
${button}                       //button[text()=${buttonName}]
${CreateLocationHdr}            //div[text()='Create location']
${LocationOrder_TXT}            //input[@name='locationOrder']
${MerchantId_TXT}               //input[@name='merchantId']
${VendorName_DDL}               //label[text()='Vendor Name']/parent::div/descendant::span[@role='button']
${ParkingLocationName_TXT}      //input[@name='name']
${ParkingStatus_DDL}            //label[text()='Parking status']/parent::div/descendant::span[@role='button']
${Addr1_TXT}                    //input[@name='addressLine1']
${Addr2_TXT}                    //input[@name='addressLine2']
${City_TXT}                     //input[@name='city']
${LocationCode_TXT}             //input[@name='locationCode']
${Latitude_NUM}                 //input[@name='gpsCoordinatesLat']
${Longitude_NUM}                //input[@name='gpsCoordinatesLon']
${FeeQueryStatus_DDL}           //label[text()='Fee query status']/parent::div/descendant::span[@role='button']
${LocationType_DDL}             //label[text()='Location type']/parent::div/descendant::span[@role='button']
${GracePeriod_NUM}              //input[@name='gracePeriod']
${ClearSession_NUM}             //input[@name='sessionExpiry']
${Postcode_TXT}                 //input[@name='postcode']
${State_DDL}                    //label[text()='State']/parent::div/descendant::span[@role='button']
${ParkingRates_TXT}             //input[@name='parkingRatesUrl']
${LoyaltyCategoryCode_NUM}      //input[@name='loyaltyCategoryCode']

#${ParkingDDL_opions}            //label[text()='Parking status']/parent::div/descendant::div/div[text()='${OptionsName}']
#${FeeQueryStatus_DDL_Options}   //label[text()='Fee query status']/parent::div/descendant::div/div[text()='${OptionsName}']
#${LocationType_DDL_Options}     //label[text()='Location type']/parent::div/descendant::div/div[text()='${OptionsName}']
#${State_DDL_Options}            //label[text()='State']/parent::div/descendant::div/div[text()='${OptionsName}']

${Options_DDL}                  //label[text()=%s]/parent::div/descendant::div/div[text()=%s]
${Options_DDL2}                 //div[text()=%s]

*** Keywords ***
VerifyLocationPage
    [Documentation]     Validate Location page
    Wait Until Page Contains Element    //h1[text() = 'Locations']
    Page Should Contain    Locations

CreateNewLocations
    [Documentation]     Create new Locations
    [Arguments]     ${merchantId}   ${parkingLocationName}
    # click on Create Button
    Wait Until Element Is Visible       ${button}
    Click Element                       ${button}

    # ensure the pop up screen appear
    Wait Until Element Is Visible    ${CreateLocationHdr}

    # Here is to fill up all the info
    ${locationOrder}    Evaluate                        random.randint(1, 100)      # get random no for location order
    ${locationCode}     Generate Random String     20   ${AlphaNumericRegec}
    Log    ${locationCode}

    # fill in all the fields
    Input Text      ${LocationOrder_TXT}          ${locationOrder}
    Input Text      ${MerchantId_TXT}             ${merchantId}
    Input Text      ${Addr1_TXT}                  Test Automation Addr 1
    Input Text      ${Addr2_TXT}                  Test Automation Addr 2
    Input Text      ${City_TXT}                   KL
    Input Text      ${LocationCode_TXT}           ${locationCode}
    Input Text      ${Latitude_NUM}               3.1577957632870595
    Input Text      ${Longitude_NUM}              101.71234297706725
    Input Text      ${GracePeriod_NUM}            5
    Input Text      ${ClearSession_NUM}           1
    Input Text      ${Postcode_TXT}               47180
    Input Text      ${ParkingRates_TXT}           -
    Input Text      ${LoyaltyCategoryCode_NUM}    1001

    # select VendorName = WeiLong
    ${Sel_options}      Set Variable        'weilong'
    ${FinalLocator}     Evaluate            "${Options_DDL2}" %  "${Sel_options}"
    Log Many    ${FinalLocator}

    Click Element       ${VendorName_DDL}
    Wait Until Element Is Visible           ${FinalLocator}
    Click Element       ${FinalLocator}

    #  Select Parking Status = Maintenance
    ${label}            Set Variable        'Parking status'
    ${Sel_options}      Set Variable        'Maintenance'
    ${FinalLocator}     Evaluate            "${Options_DDL}" % ("${label}", "${Sel_options}")
    Log     ${FinalLocator}

    Click Element                       ${ParkingStatus_DDL}
    Wait Until Element Is Visible       ${FinalLocator}
    Click Element                       ${FinalLocator}

    #  select Fee Query status = No
    ${label}            Set Variable        'Fee query status'
    ${Sel_options}      Set Variable        'No'
    ${FinalLocator}     Evaluate            "${Options_DDL}" % ("${label}", "${Sel_options}")
    Log     ${FinalLocator}

    Click Element                       ${FeeQueryStatus_DDL}
    Wait Until Element Is Visible       ${FinalLocator}
    Click Element                       ${FinalLocator}

    #  select Location Type = Affiliate
    ${Selected_DDL_Field}   Replace String     ${Options_DDL}           ${DDL_Name}     Location type
    ${FinalLocator}         Replace String     ${Selected_DDL_Field}    ${OptionsName}  Affiliate
    Log     ${FinalLocator}

    Click Element                       ${LocationType_DDL}
    Wait Until Element Is Visible       ${FinalLocator}
    Click Element                       ${FinalLocator}


    # select State = KL
    ${Selected_DDL_Field}   Replace String     ${Options_DDL}           ${DDL_Name}     State
    ${FinalLocator}         Replace String     ${Selected_DDL_Field}    ${OptionsName}  Kuala Lumpur
    Log     ${FinalLocator}

    Click Element    ${State_DDL}
    ${OptionsName}  Set Variable        Kuala Lumpur
    Wait Until Element Is Visible       ${FinalLocator}
    Click Element                       ${FinalLocator}

    Sleep    10s

    ${button}   Replace String    ${button}    ${buttonName}    Save Changes
    Click Element    ${button}

    Sleep    10s
