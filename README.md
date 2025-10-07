# fiap-soat-fastfood-infrastructure

Projeto desenvolvido para o curso de [pós-graduação em Arquitetura de Software (Soat Póstech) da FIAP](https://postech.fiap.com.br/curso/software-architecture/).

Este repositório contém a infraestrutura como código (IaC) para o projeto Fastfood, utilizando Terraform para provisionamento de recursos na Azure. O projeto está organizado em ambientes de **development** e **production**, cada um com seus próprios diretórios e estados remotos.

## 🏃 Integrantes do grupo

- Jeferson dos Santos Gomes - **RM 362669**
- Jamison dos Santos Gomes - **RM 362671**
- Alison da Silva Cruz - **RM 362628**

## 🗂️ Estrutura do Projeto

```
.
├── development/
│   ├── api_management/
│   ├── function/
│   ├── infrastructure/
│   └── resources/
├── production/
│   ├── api_management/
│   ├── function/
│   ├── infrastructure/
│   └── resources/
└── modules/
    ├── backend/
    ├── function_app/
    ├── k8s/
    │   ├── cluster/
    │   ├── namespace/
    │   └── network/
```

### ✅ Ambientes

- **development/**: Infraestrutura para o ambiente de desenvolvimento, permitindo testes e validações sem impactar o ambiente produtivo.
- **production/**: Infraestrutura para o ambiente de produção, executada via pipeline com [github actions](https://github.com/features/actions?locale=pt-BR).

Cada ambiente possui subdiretórios para diferentes domínios de recursos:

- **infrastructure/**: Provisão de recursos base, como Resource Groups, redes virtuais e clusters AKS.
- **function/**: Provisão de Azure Functions, Key Vaults e recursos relacionados à autenticação.
- **resources/**: Recursos auxiliares, como namespaces no Kubernetes.
- **api_management/**: Provisão do Azure API Management e configuração de APIs.

### 📈 Módulos

Os módulos reutilizáveis ficam em `modules/` e são utilizados tanto em development quanto em production:

- **backend/**: Criação de Resource Group, Storage Account e Container para armazenamento de estado remoto do Terraform.
- **function_app/**: Provisão de Function App, Storage Account, Service Plan e Application Insights para Azure Functions.
- **k8s/cluster/**: Provisão do cluster AKS, incluindo RBAC, pools de nós e permissões de rede.
- **k8s/network/**: Criação de rede virtual, sub-rede, IPs públicos e NAT Gateway para o AKS.
- **k8s/namespace/**: Criação de namespaces no cluster Kubernetes.

## 🔁 CI/CD

O pipeline de CI/CD está configurado em [.github/workflows/github-actions.yml](.github/workflows/github-actions.yml), automatizando o deploy da infraestrutura via GitHub Actions.

---