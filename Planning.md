# Planejamento do Projeto: Rick and Morty API App

## Objetivo

O objetivo do aplicativo é permitir o estudo e prática de conceitos fundamentais no desenvolvimento iOS, utilizando a [API pública de Rick and Morty](https://rickandmortyapi.com/documentation/#character). O app exibirá uma lista de personagens com detalhes adicionais, proporcionando experiência prática com:

- Consumo de API com tratamento de erros.
- Integração de interfaces desenvolvidas com UIKit e SwiftUI.
- Implementação de paginação para carregamento eficiente de dados.
- Criação de testes unitários para validação do comportamento do app.
- Salvamento de dados em chache.

## Funcionalidades Principais

- Listagem de personagens com nome, foto e tipo.
- Detalhamento de cada personagem, incluindo:
  - Status
  - Espécie
  - Foto
  - Gênero
  - Origem
  - Localização atual

## Telas e Fluxo do App

1. **Tela de Lista de Personagens**:
   - Exibe uma lista paginada com:
     - Nome do personagem
     - Foto do personagem
     - Tipo do personagem (se disponível)
   - Desenvolvida com UIKit.
   - Permite navegação para a tela de detalhes ao selecionar um personagem.

2. **Tela de Detalhes do Personagem**:
   - Exibe informações detalhadas do personagem selecionado:
     - Status
     - Espécie
     - Gênero
     - Origem
     - Localização
     - Foto ampliada
   - Desenvolvida com SwiftUI.

- [Link do protótipo no Figma](https://www.figma.com/design/ogaKzEGzSFoSBHbk4XAZ5k/Mentoria-iOS?node-id=0-1&t=yCeJrID7rmqHfCAj-1)

## Arquitetura

### Escolha: VIPER (View-Interactor-Presenter-Entity-Router)

**Justificativa**:
- **Modularidade**: VIPER promove uma separação clara e modular, facilitando a escalabilidade e manutenção.
- **Separação de responsabilidades**: Cada camada tem um papel bem definido, evitando a sobrecarga de responsabilidades.
- **Testabilidade**: As camadas bem definidas facilitam a criação de testes unitários para lógica de negócios, navegação e interação com a API.

**Componentes**:
- **View**: Exibe a interface do usuário e recebe interações.
- **Interactor**: Lida com a lógica de negócios e consumo de API.
- **Presenter**: Faz a ponte entre a View e o Interactor, preparando os dados.
- **Entity**: Representa os modelos de dados.
- **Router**: Gerencia a navegação entre telas.

## Plano de Consumo da API

1. **Lista de Personagens**: 
   - Endpoint: `https://rickandmortyapi.com/api/character`
   - Retorna informações sobre todos os personagens, incluindo nome, status, espécie, gênero, origem, localização e imagem.

2. **Imagem dos Personagens**:
   - URL base: `"https://rickandmortyapi.com/api/character/avatar/{id}.jpeg"`

**Tratamento de Erros**:
- Implementar tratamento para erros comuns como:
  - Falha na conexão com a API.
  - Respostas inesperadas ou inválidas.
  - Status HTTP que indiquem erro.

## Estratégia de Desenvolvimento

### Estrutura do Código

1. **Camadas**:
   - **View**: Interfaces do usuário criadas em UIKit e SwiftUI.
   - **Interactor**: Manipulação de lógica e consumo de API.
   - **Presenter**: Manipulação dos dados para exibição.
   - **Entity**: Estruturas de dados.
   - **Router**: Navegação entre telas.

2. **Pastas**:
   - `Entities/`: Contém os modelos de dados.
   - `Interactors/`: Contém a lógica de negócios.
   - `Presenters/`: Contém os Presenters que conectam a lógica com a View.
   - `Views/`: Contém as interfaces em UIKit e SwiftUI.
   - `Routers/`: Contém a lógica de navegação.
   - `Services/`: Contém a lógica para consumo da API.
   - `Tests/`: Contém os testes unitários.

### Etapas de Desenvolvimento

1. **Configuração Inicial**:
   - Configurar o projeto no Xcode.

2. **Desenvolvimento da Tela de Lista**:
   - Criar o layout em UIKit.
   - Configurar a lógica de paginação no Interactor.
   - Integrar Presenter e View para exibir os dados da API.

3. **Desenvolvimento da Tela de Detalhes**:
   - Criar o layout em SwiftUI.
   - Implementar navegação usando o Router.
   - Integrar Presenter e View para exibir os dados completos do personagem.

4. **Tratamento de Erros e Salvamento em Cache**:
   - Adicionar mensagens de erro amigáveis para o usuário.
   - Implementar estratégias de fallback, como um botão de recarregar.
   - Salver personagens em Cache.

5. **Testes Unitários**:
   - Criar testes para validar:
     - Lógica de consumo da API no Interactor.
     - Comportamento dos Presenters.
     - Navegação gerenciada pelo Router.

6. **Ajustes Finais**:
   - Revisar a interface para garantir usabilidade e consistência visual.
   - Corrigir eventuais bugs.
