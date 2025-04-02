
# Rick and Morty Characters App

## 📌 Objetivo

Rick and Morty Characters App é um aplicativo iOS desenvolvido para estudo e prática de conceitos fundamentais no desenvolvimento mobile, utilizando a API pública de Rick and Morty. O aplicativo permite explorar personagens da série, visualizar detalhes e realizar buscas de maneira eficiente.

## Mentor
Conteúdos das mentorias do [@yagoal](https://github.com/yagoal)

## 🚀 Funcionalidades

- Listagem paginada de personagens com:
  - Nome
  - Foto
  - Tipo (se disponível)
- Pesquisa de personagens pelo nome via Search Bar.
- Detalhamento completo do personagem com:
  - Status
  - Espécie
  - Foto ampliada
  - Gênero
  - Origem
  - Localização atual
- Scroll infinito para carregamento dinâmico dos personagens.
- Tratamento de erros ao consumir a API.
- Salvamento de dados em cache para melhor desempenho.

## 🖥️ Tecnologias Utilizadas

- **Swift**
- **UIKit** (Tela de lista de personagens)
- **SwiftUI** (Tela de detalhes do personagem)
- **VIPER** (View-Interactor-Presenter-Entity-Router)
- **URLSession** (Requisição de dados)
- **Cache** para armazenamento temporário de personagens
- **XCTest** (Testes unitários)

## 🔍 Arquitetura - VIPER

A arquitetura VIPER foi escolhida para garantir:

- **Modularidade**: Melhor organização e manutenção do código.
- **Separação de responsabilidades**: Cada camada possui uma função bem definida.
- **Testabilidade**: Facilita a criação de testes unitários para a lógica de negócios.

### 🏗 Estrutura do Código
```
RickAndMortyCharactersApp/
│── Entities/         # Modelos de dados
│── Interactors/      # Lógica de negócios e consumo de API
│── Presenters/       # Conecta Interactor com a View
│── Views/            # Interfaces criadas com UIKit e SwiftUI
│── Routers/          # Navegação entre telas
│── Services/         # Requisição de API e armazenamento em cache
│── Tests/            # Testes unitários
```

## 🔗 Consumo da API

- **Lista de Personagens:** `https://rickandmortyapi.com/api/character`
- **Detalhes de Personagem:** `https://rickandmortyapi.com/api/character/{id}`
- **Pesquisa por Nome:** `https://rickandmortyapi.com/api/character/?name={nome}`

## 🛠 Estratégia de Desenvolvimento

1. **Configuração Inicial:**
   - Criar o projeto no Xcode e definir a estrutura de pastas.

2. **Desenvolvimento da Tela de Lista:**
   - Criar layout com UIKit.
   - Implementar paginação (scroll infinito).
   - Integrar Presenter e View para exibir os dados.
   - Implementar a barra de pesquisa.

3. **Desenvolvimento da Tela de Detalhes:**
   - Criar layout em SwiftUI.
   - Implementar navegação via Router.
   - Exibir dados detalhados do personagem.

4. **Tratamento de Erros e Cache:**
   - Implementar mensagens de erro amigáveis.
   - Criar fallback para erros de conexão.
   - Implementar cache para personagens carregados.

5. **Testes Unitários:**
   - Validar consumo da API.
   - Testar comportamento dos Presenters.
   - Garantir correto funcionamento da navegação.

6. **Ajustes Finais:**
   - Revisão da interface.
   - Correção de bugs.
   - Otimizações para performance.

## 🖼️ Protótipo no Figma

[🔗 Link para o Figma](https://www.figma.com/design/ogaKzEGzSFoSBHbk4XAZ5k/Mentoria-iOS?node-id=0-1&t=UkcIHfcwALh1xACG-1)

## 🧪 Testes

O projeto inclui testes unitários para garantir a confiabilidade do código. Os testes cobrem:

- Requisições de API no Interactor.
- Apresentação de dados no Presenter.
- Navegação entre telas via Router.

## 🤝 Contribuição

Se você deseja contribuir, siga os passos:

1. **Fork** o repositório.
2. Crie uma **branch** (`feature/nova-funcionalidade`).
3. Faça commit das suas alterações (`git commit -m 'Adiciona nova funcionalidade'`).
4. **Push** para a branch (`git push origin feature/nova-funcionalidade`).
5. Abra um **Pull Request**.

## 📜 Licença

Este projeto está sob a licença MIT. Sinta-se à vontade para utilizá-lo e modificá-lo conforme necessário.

---
Desenvolvido por [Guilherme Lenzolari](https://github.com/guilenzolari) 🚀

