*** Settings ***
Documentation     Tests dealing with stale elements
Suite Setup       Go To Page "javascript/stale_elements.html"
Test Setup        Initialize page
Resource          ../resource.robot
Force Tags        stale

*** Test Cases ***
Detached Element Should Be Stale
    Click Button    id:detach-child
    Wait Until Element State Is    STALE    ${child}
    Click Button    id:detach-parent
    Wait Until Element State Is    STALE    ${parent}

Detaching Parent Should Make Child Stale
    Click Button    id:detach-parent
    Wait Until Element State Is    STALE    ${child}

*** Keywords ***
Initialize Page
    [Documentation]    Initialize Page
    Reload Page
    Wait Until Page Contains Element    id:grandparent
    Wait Until Page Contains Element    id:parent
    Wait Until Page Contains Element    id:child
    Wait Until Page Contains Element    tag:button    limit=4
    ${parent} =    Get WebElement    id:parent
    Set Test Variable    ${parent}
    ${child} =    Get WebElement    id:child
    Set Test Variable    ${child}
