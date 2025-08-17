# Sistema de Investimento Pessoal

## 📌 Regras de Negócio

1. O usuário deve possuir uma conta para acessar o sistema.
2. Cada investimento deve estar vinculado a uma categoria (ações, fundos, renda fixa, criptomoedas etc.).
3. O sistema não permite exclusão de registros de investimento que já possuem movimentações financeiras associadas — apenas inativação.
4. O saldo disponível deve ser recalculado automaticamente após cada operação (compra, venda, depósito, retirada).
5. O usuário só pode visualizar e editar investimentos vinculados à sua própria conta.
6. Os relatórios financeiros devem considerar apenas investimentos ativos.
7. Cada operação financeira deve ser registrada com data, hora e valor imutáveis.


## ✅ Requisitos Funcionais

1. O sistema deve permitir o cadastro, edição e inativação de investimentos.
2. O sistema deve permitir o registro de operações financeiras (compra, venda, depósito e retirada).
3. O sistema deve fornecer relatórios financeiros por período e categoria.
4. O usuário deve conseguir visualizar seu saldo atualizado em tempo real.
5. O sistema deve permitir exportar relatórios em PDF e Excel.
6. O sistema deve enviar notificações de operações realizadas (via e-mail ou aplicativo).
7. O usuário deve poder configurar metas financeiras e acompanhar seu progresso.


## ⚙️ Requisitos Não Funcionais

1. O sistema deve estar disponível 99,9% do tempo (alta disponibilidade).
2. O tempo de resposta das operações críticas não deve ultrapassar 2 segundos.
3. Todas as senhas devem ser armazenadas com criptografia forte (bcrypt ou Argon2).
4. O sistema deve seguir a LGPD, garantindo segurança e privacidade dos dados.
5. O sistema deve ser responsivo, acessível em desktop, tablet e dispositivos móveis.
6. A aplicação deve suportar pelo menos 10.000 usuários simultâneos sem degradação de performance.
7. O sistema deve possuir logs de auditoria para todas as operações críticas.


