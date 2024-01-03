*** Settings ***
Library    String


#*** Variables ***
#${OptionsName}                  OLDv_alue
#${label}                        OLD_lable
#${DDL_Name}                     OLD_DDl_vale
#${Options_DDL}                  //label[text()=${DDL_Name}]/parent::div/descendant::div/div[text()=${OptionsName}]
#${DDL_Option_2}                 //div[text()=${OptionsName}]
#
#
#*** Test Cases ***
#Example Test Case
#    Log    Original OptionsName: ${OptionsName}
#    Log    Original label: ${label}
#    Log    Original FeeQueryStatus_DDL_Options: ${Options_DDL}
#
#    # Assign a new value to ${OptionsName}
#    ${tmp} =    Set Variable    'abc'
#    Set Global Variable    ${OptionsName}   ${tmp}
#    ${Options_DDL}  Replace Variables   ${tmp}
#    Log   1st OptionsName : ${OptionsName}
#    Log   1st FeeQueryStatus_DDL_Options: ${Options_DDL}

#    Set Global Variable  ${OptionsName}  NewVal 2
#    Log   2nd OptionsName : ${OptionsName}
#    Log   2nd FeeQueryStatus_DDL_Options: ${Options_DDL}


    # Update FeeQueryStatus_DDL_Options with the new OptionsName
#    ${FeeQueryStatus_DDL_Options}=    Set Variable    //label[text()='Location type']/parent::div/descendant::div/div[text()='${OptionsName}']
#
#    Log    Updated OptionsName: ${OptionsName}
#    Log    Updated FeeQueryStatus_DDL_Options: ${FeeQueryStatus_DDL_Options}
#
#    ${NewString}    Replace String    ${FeeQueryStatus_DDL_Options}    ${OptionsName}    ABCD
#    Log Many   usnig Replace String ${FeeQueryStatus_DDL_Options} || ${NewString}


#*** Test Cases ***
#Replace Strings
#    ${original_string}  Set Variable  This is an example string with foo and bar.
#
#    # Replace 'foo' with '123'
#    ${modified_string}  Replace String  ${original_string}  foo  123
#
#    # Replace 'bar' with '456'
#    ${final_string}  Replace String  ${modified_string}  bar  456
#
#    Log To Console  Original String: ${original_string}
#    Log To Console  Modified String: ${modified_string}
#    Log To Console  Final String: ${final_string}

#*** Variables ***
#${OptionsName}
#${CommonXPathPattern}    //label[text()='${OptionsName}']/parent::div/descendant::div/div[text()='${OptionsName}']
#
#${ParkingDDL_options}            ${CommonXPathPattern}
#${FeeQueryStatus_DDL_Options}   ${CommonXPathPattern}
#${LocationType_DDL_Options}     ${CommonXPathPattern}
#${State_DDL_Options}            ${CommonXPathPattern}

#*** Test Cases ***
#Example Test
#    ${OptionsName1}=    Set Variable    Parking status
#    ${OptionsName2}=    Set Variable    Fee query status
#    ${OptionsName3}=    Set Variable    Location type
#    ${OptionsName4}=    Set Variable    State
#
#    # Using different values for OptionsName
#    ${ParkingDDL_options}=            Set Variable    ${CommonXPathPattern.replace('${OptionsName}', ${OptionsName1})}
#    ${FeeQueryStatus_DDL_Options}=   Set Variable    ${CommonXPathPattern.replace('${OptionsName}', ${OptionsName2})}
#    ${LocationType_DDL_Options}=     Set Variable    ${CommonXPathPattern.replace('${OptionsName}', ${OptionsName3})}
#    ${State_DDL_Options}=            Set Variable    ${CommonXPathPattern.replace('${OptionsName}', ${OptionsName4})}
#
#    Log    ${ParkingDDL_options}
#    Log    ${FeeQueryStatus_DDL_Options}
#    Log    ${LocationType_DDL_Options}
#    Log    ${State_DDL_Options}

#*** Variables ***
#${name}              John
#${greeting}          Hello, ${name}!
#${modified_name}     Tom
#
#*** Test Cases ***
#Replace Variables Example
#    ${modified_greeting}    Replace Variables    ${greeting}
#    ...                     WITH ${name}=${modified_name}
#    Log To Console    Original Greeting: ${greeting}
#    Log To Console    Modified Greeting: ${modified_greeting}


*** Variables ***
${greeting}          Hello, %s! How are you
${Options_DDL}       //label[text()=%s]/parent::div/descendant::div/div[text()=%s]

*** Test Cases ***
Example Test
    ${name} =          Set Variable    John
    ${modified_greeting}=    Evaluate    "${greeting}" % "${name}"
    Log    Original Greeting: ${greeting}
    Log    Modified Greeting: ${modified_greeting}

    ${label} =          Set Variable        Parking status
    ${options_sel} =    Set Variable        Maintenance
    ${modified_locator}     Evaluate    "${Options_DDL}" % ("${label}", "${options_sel}")

    Log     Original locator addr: ${Options_DDL}
    Log     Modified locator addr: ${modified_locator}

#*** Variables ***
#${label}               'NEW_LABEL_VALUE'
#${OptionsName}         'NEW_VALUE'
#${Options_DDL}         //label[text()=%s]/parent::div/descendant::div/div[text()=%s]
#
#*** Test Cases ***
#Example Test
#    ${formatted_options}=    Evaluate    "${Options_DDL}" % ("${label}", "${OptionsName}")
#    Log    Formatted Options DDL: ${formatted_options}



