*** Settings ***
Library          SeleniumLibrary
Resource         setup_teardown.robot
Test Setup       Dado que eu acesse o Organo
Test Teardown    Fechar o navegador

*** Variables ***
${CAMPO_NOME}      id:form-nome
${CAMPO_CARGO}     id:form-cargo
${CAMPO_IMAGEM}    id:form-imagem
${CAMPO_TIME}      class:lista-suspensa
${BOTAO_CARD}      id:form-botao 
${PROGRAMACAO}     //option[contains(.,'Programação')]
${FRONT-END}       //option[contains(.,'Front-End')]
${DADOS}           //option[contains(.,'Data Science')]
${DEVOPS}          //option[contains(.,'Devops')]
${UX}              //option[contains(.,'UX e Design')]
${MOBILE}          //option[contains(.,'Mobile')]
${INOVACAO}        //option[contains(.,'Inovação')]

*** Test Cases ***
Verificar se ao preencher corretamente o formulário os dados são inseridos corretamente na lista e se um novo card é criado no time escolhido  
     Dado que eu preencha os campos do formulário
     E clique no botão "Criar Card"
     Então identificar o card no time esperado

*** Keywords ***
Dado que eu preencha os campos do formulário
    Input Text       id:form-nome       Akemi
    Input Text       id:form-cargo      Desenvolvedora 
    Input Text       id:form-imagem     https://picsum.photos/200/300
    Click Element    class:lista-suspensa
    Click Element    //option[contains(.,'Programação')]
    
E clique no botão "Criar Card"    
    Click Element    id:form-botao

Então identificar o card no time esperado
    Element Should Be Visible    class:colaborador
