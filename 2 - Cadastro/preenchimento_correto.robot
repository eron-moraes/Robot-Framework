*** Settings ***
Library          SeleniumLibrary
Library          FakerLibrary    locale=pt_BR
Resource         setup_teardown.robot
Test Setup       Dado que eu acesse o Organo
Test Teardown    Fechar o navegador

*** Variables ***
${CAMPO_NOME}      id:form-nome
${CAMPO_CARGO}     id:form-cargo
${CAMPO_IMAGEM}    id:form-imagem
${CAMPO_TIME}      class:lista-suspensa
${BOTAO_CARD}      id:form-botao 

@{selecionar_time}
...       //option[contains(.,'Programação')]
...       //option[contains(.,'Front-End')]
...       //option[contains(.,'Data Science')]
...       //option[contains(.,'Devops')]
...       //option[contains(.,'UX e Design')]
...       //option[contains(.,'Mobile')]
...       //option[contains(.,'Inovação')]

*** Test Cases ***
Verificar se ao preencher corretamente o formulário os dados são inseridos corretamente na lista e se um novo card é criado no time escolhido  
     Dado que eu preencha os campos do formulário
     E clique no botão "Criar Card"
     Então identificar o card no time esperado

Verificar se é possivel criar mais de um card se preenchermos os campos corretamente
    Dado que eu preencha os campos do formulário
    E clique no botão "Criar Card"
    Então identificar 3 cards no time esperado

Verificar se é possível criar um card para cada time se preenchermos os campos corretamente
    Dado que eu preencha os campos do formulário
    Então criar card e identificar 1 card em cada time disponível

*** Keywords ***
Dado que eu preencha os campos do formulário
    ${Nome}          FakerLibrary.First Name
    Input Text       ${CAMPO_NOME}       ${Nome}
    ${Cargo}         FakerLibrary.Job    
    Input Text       ${CAMPO_CARGO}      ${Cargo} 
    ${Imagem}        FakerLibrary.Image Url    
    Input Text       ${CAMPO_IMAGEM}     ${Imagem}
    Click Element    ${CAMPO_TIME}
    Click Element    ${selecionar_time}[0]
    
E clique no botão "Criar Card"    
    Click Element    ${BOTAO_CARD}

Então identificar o card no time esperado
    Element Should Be Visible    class:colaborador

Então identificar 3 cards no time esperado
    FOR    ${i}    IN RANGE    1     3       
        Dado que eu preencha os campos do formulário
        E clique no botão "Criar Card"
    END
    Sleep    10s

Então criar card e identificar 1 card em cada time disponível
    FOR    ${indice}    ${time}    IN ENUMERATE    @{selecionar_time}
        Dado que eu preencha os campos do formulário
        Click Element    ${time}
        E clique no botão "Criar Card"
        
    END
    Sleep    10s

