# Projeto Integrador 03 — Checklist de Equipamentos

Aplicativo Android para registro de inspeção pré-operacional de máquinas/equipamentos em campo. O operador seleciona o equipamento, responde ao checklist categorizado (combustível, segurança, motor, estrutura, elétrica e funcionamento) e submete os dados ao backend via API REST.

---

## Funcionalidades

| Tela | Descrição |
|------|-----------|
| Seleção de Operador | Lista operadores cadastrados; autenticação por PIN |
| Seleção de Máquina | Lista equipamentos disponíveis |
| Checklist — Combustível | Nível de combustível (Cheio / Médio / Vazio) |
| Checklist — Segurança | Itens de segurança individual e coletiva |
| Checklist — Motor & Estrutura | Condições mecânicas e estruturais |
| Checklist — Elétrica & Funcionamento | Sistema elétrico e operação geral |
| Resumo | Revisão consolidada e envio ao servidor |
| Detalhes do Checklist | Visualização completa de um checklist já realizado, acessado pelo histórico |

---

## Fluxo de Navegação

```
/operator-selection  →  /login  →  /machine-selection
                                          │
                                          ▼
                               /checklist/combustivel
                                          │
                               /checklist/seguranca
                                          │
                               /checklist/motor-estrutura
                                          │
                               /checklist/eletrica-funcionamento
                                          │
                               /checklist/resumo  →  / (home)
                                                          │
                                          ┌───────────────┘
                                          ▼
                               /checklist/detalhe/:id   ← toque em item do histórico
```

---

## Arquitetura

O projeto segue **MVVM + Clean Architecture** com separação estrita por camadas:

```
UI Layer
  └── Page (View)        → constrói a interface, sem lógica de negócio
  └── Cubit (ViewModel)  → gerencia estado e lógica de apresentação

Data Layer
  └── Repository (interface)      → contrato abstrato
  └── RepositoryImpl              → implementação concreta
  └── RemoteDataSource            → chamadas HTTP via Dio
  └── Model (DTO)                 → fromJson / toJson
  └── Entity                      → objeto de domínio puro
```

### Regras de dependência

| De | Para | Permitido |
|----|------|-----------|
| Page | Cubit | ✅ via `context.read<>()` |
| Cubit | Repository | ✅ via `get_it` |
| Cubit | outro Cubit | ❌ nunca |
| Cubit | BuildContext | ❌ nunca |
| Page | DataSource | ❌ nunca direto |

---

## Estrutura de Pastas

```
lib/
├── core/
│   ├── config/
│   │   └── env_config.dart          # variáveis de ambiente (dart-define)
│   ├── rest_client/
│   │   └── dio/
│   │       └── dio_rest_client.dart # Dio + interceptors de auth e erro
│   ├── utils/
│   │   ├── app_loading_overlay.dart # overlay de carregamento global
│   │   └── app_messages.dart        # snackbars padronizadas
│   ├── app_colors.dart
│   ├── app_router.dart              # GoRouter + auth guard
│   ├── auth_guard.dart
│   ├── injection.dart               # get_it setup
│   ├── responsive_context.dart      # extensão responsiva
│   └── theme_config.dart
├── cubits/
│   ├── auth_cubit.dart / auth_state.dart
│   ├── checklist_cubit.dart / checklist_state.dart
│   └── connectivity_cubit.dart
├── features/
│   ├── checklist/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── checklist_remote_datasource.dart  # create, saveAnswers, fetchById
│   │   │   ├── models/
│   │   │   │   ├── checklist_model.dart
│   │   │   │   └── checklist_detail_model.dart       # DTO do GET /checklists/{id}
│   │   │   └── repositories/
│   │   │       └── checklist_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── checklist_entity.dart
│   │   │   │   └── checklist_detail_entity.dart      # ChecklistDetailEntity + ChecklistAnswerEntity
│   │   │   └── repositories/
│   │   │       └── checklist_repository.dart
│   │   └── presentation/
│   │       ├── cubit/
│   │       │   ├── checklist_detail_cubit.dart       # fetchById(id)
│   │       │   └── checklist_detail_state.dart       # Initial | Loading | Loaded | Error
│   │       └── pages/
│   │           └── checklist_detail_page.dart        # tela de detalhe do histórico
│   ├── history/
│   │   ├── data/   (models, datasources, repositories)
│   │   ├── domain/ (entities, repositories)
│   │   └── presentation/ (cubit)
│   ├── machines/
│   │   ├── data/   (models, datasources, repositories)
│   │   ├── domain/ (entities, repositories)
│   │   └── presentation/ (cubit)
│   └── operators/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── views/
│   ├── widgets/
│   │   ├── app_button.dart
│   │   ├── activity_tile.dart
│   │   └── operator_card.dart
│   ├── home_page.dart
│   ├── login_page.dart
│   ├── machine_selection_page.dart
│   ├── operator_selection_page.dart
│   ├── checklist_fuel_page.dart
│   ├── checklist_safety_page.dart
│   ├── checklist_engine_structure_page.dart
│   ├── checklist_electrical_operation_page.dart
│   └── checklist_summary_page.dart
└── main.dart
```

---

## Packages Utilizados

### Dependências principais

| Package | Versão | Finalidade |
|---------|--------|------------|
| `flutter_bloc` | ^9.1.1 | Gerenciamento de estado com Cubit |
| `go_router` | ^15.1.2 | Navegação declarativa com auth guard |
| `get_it` | ^8.0.3 | Injeção de dependência (service locator) |
| `dio` | ^5.8.0+1 | Cliente HTTP com interceptors |
| `top_snackbar_flutter` | ^3.1.0 | Snackbars animadas (sucesso / erro) |
| `loading_animation_widget` | ^1.3.0 | Animações de carregamento para overlay |
| `internet_connection_checker_plus` | ^2.6.0 | Monitoramento de conectividade |
| `flutter_native_splash` | ^2.4.3 | Splash screen nativa |
| `flutter_launcher_icons` | ^0.14.3 | Geração de ícones do app |
| `envied` | ^1.1.0 | Leitura segura de variáveis de ambiente |

### Dependências de desenvolvimento

| Package | Versão | Finalidade |
|---------|--------|------------|
| `flutter_test` | sdk | Framework de testes |
| `flutter_lints` | ^5.0.0 | Regras de lint recomendadas |
| `envied_generator` | ^1.1.0 | Gerador de código para `envied` |
| `build_runner` | ^2.4.15 | Runner de geração de código |

---

## Padrões de Código

### Estado imutável com `copyWith`

Todos os estados Cubit são classes imutáveis. Campos anuláveis usam o padrão sentinel para distinguir "não informado" de `null` explícito:

```dart
class ChecklistState {
  final int? fuelLevel;
  final Map<String, int> respostas;

  // Sentinel para copyWith de campos anuláveis
  static const Object _sentinel = Object();

  ChecklistState copyWith({
    Object? fuelLevel = _sentinel,
    // ...
  }) {
    return ChecklistState(
      fuelLevel: identical(fuelLevel, _sentinel)
          ? this.fuelLevel
          : fuelLevel as int?,
    );
  }
}
```

### Responsividade

Toda dimensão visual (fonte, padding, tamanho de ícone) usa a extensão `responsiveValue`. Não há valores fixos espalhados pelo código:

```dart
final fontSize = context.responsiveValue<double>(
  mobile: 18.0,
  tablet: 24.0,
);

Text(
  'Selecione a Máquina',
  style: TextStyle(fontSize: fontSize),
)
```

### Mensagens ao usuário

Use sempre `AppMessages` para garantir consistência visual:

```dart
// Mensagem de sucesso (verde)
AppMessages.showSuccess(context, 'Dados salvos com sucesso!');

// Mensagem de erro (vermelho)
AppMessages.showError(context, 'Erro ao realizar login');
```

### Overlay de carregamento

`AppLoadingOverlay` bloqueia toda a tela durante operações assíncronas:

```dart
// Exibir (bloqueia a tela)
AppLoadingOverlay.show(context);

// Esconder (aguarda 100ms para evitar flicker)
AppLoadingOverlay.hide(context);
```

### Injeção de dependência

Todos os serviços são registrados em `lib/core/injection.dart` e injetados via `get_it`.

**`registerLazySingleton`** — cria a instância uma única vez, na primeira chamada, e reutiliza para sempre. Usado para repositórios, datasources e cubits globais (ex.: `AuthCubit`, `HistoryCubit`).

**`registerFactory`** — cria uma **nova instância a cada chamada**. Usado para cubits de tela específica que precisam de estado fresco a cada navegação, como `ChecklistDetailCubit`:

```dart
// Singleton — compartilhado em todo o app
getIt.registerLazySingleton<MachineRepository>(
  () => MachineRepositoryImpl(getIt()),
);

// Factory — nova instância a cada vez que a rota é aberta
getIt.registerFactory<ChecklistDetailCubit>(
  () => ChecklistDetailCubit(getIt<ChecklistRepository>()),
);
```

Na rota de detalhe, o `BlocProvider` cria o cubit e já dispara o carregamento:

```dart
GoRoute(
  path: '/checklist/detalhe/:id',
  builder: (context, state) {
    final id = int.parse(state.pathParameters['id']!);
    return BlocProvider(
      create: (_) => getIt<ChecklistDetailCubit>()..fetchById(id),
      child: const ChecklistDetailPage(),
    );
  },
),
```

---

## Pré-requisitos

Antes de rodar o projeto, certifique-se de ter instalado:

| Ferramenta | Versão mínima | Download |
|-----------|--------------|---------|
| Flutter SDK | 3.29.x (stable) | https://flutter.dev/docs/get-started/install |
| Dart SDK | 3.7.x (incluso no Flutter) | — |
| Android SDK | API 21 (Android 5.0+) | Android Studio |
| JDK | 17 | https://adoptium.net |
| Android Studio ou VS Code | qualquer versão recente | — |

Verifique se tudo está correto:

```bash
flutter doctor -v
```

Todos os itens devem aparecer com ✓ verde (exceto iOS/Xcode, que não é necessário para Android).

---

## Configuração do Ambiente (`.env`)

O projeto usa variáveis de ambiente injetadas em **tempo de compilação**. Você precisará criar um arquivo `.env` na raiz do projeto.

**Passo 1** — Copie o arquivo de exemplo:

```bash
cp .env.example .env
```

**Passo 2** — Edite o `.env` com os valores corretos:

```dotenv
# URL base da API REST (sem barra no final)
API_BASE_URL=https://sua-api.onrender.com

# Flavor do ambiente: dev ou prod
FLAVOR=dev
```

> **Por que usar dart-define e não `dotenv` em tempo de execução?**
>
> O Flutter compila o código Dart em binário nativo. Variáveis lidas em tempo de
> execução de um arquivo `.env` exigiriam que esse arquivo fosse empacotado junto
> ao APK, expondo segredos. Com `--dart-define-from-file=.env`, as variáveis são
> incorporadas ao binário em tempo de compilação pela classe `EnvConfig`:
>
> ```dart
> class EnvConfig {
>   static const String baseUrl =
>       String.fromEnvironment('API_BASE_URL', defaultValue: '');
>   static const String flavor =
>       String.fromEnvironment('FLAVOR', defaultValue: 'dev');
> }
> ```
>
> O arquivo `.env` fica apenas na máquina do desenvolvedor e nunca vai para o
> repositório (está no `.gitignore`).

---

## Como Rodar — Modo DEV

### Opção A: VS Code (recomendado)

1. Abra a pasta do projeto no VS Code
2. Conecte um dispositivo Android ou inicie um emulador
3. Pressione **F5** — o perfil `DEV` em `.vscode/launch.json` já passa `--dart-define-from-file=.env` automaticamente

### Opção B: Terminal

```bash
flutter run --dart-define-from-file=.env
```

Para escolher um dispositivo específico:

```bash
# Listar dispositivos disponíveis
flutter devices

# Rodar em dispositivo específico pelo ID
flutter run -d emulator-5554 --dart-define-from-file=.env
```

### Configurar um dispositivo físico Android

1. No celular: **Configurações → Sobre o telefone → Número da versão** (toque **7 vezes**)
2. Habilite **Depuração USB** em Configurações → Opções do desenvolvedor
3. Conecte o celular ao computador via USB e aceite a permissão de depuração
4. Confirme que aparece na lista: `flutter devices`
5. Rode: `flutter run --dart-define-from-file=.env`

---

## Como Rodar — Modo PROD (Release)

Antes de gerar o release, ajuste o `.env` para apontar para a URL de produção:

```dotenv
API_BASE_URL=https://api-producao.onrender.com
FLAVOR=prod
```

### APK de release (distribuição direta)

Gera um único APK universal que roda em qualquer dispositivo Android:

```bash
flutter build apk --release --dart-define-from-file=.env
```

Arquivo gerado em:
```
build/app/outputs/flutter-apk/app-release.apk
```

### APK separado por arquitetura (recomendado — menor tamanho)

Gera três APKs, cada um otimizado para um tipo de processador:

```bash
flutter build apk --split-per-abi --release --dart-define-from-file=.env
```

```
build/app/outputs/flutter-apk/
├── app-armeabi-v7a-release.apk   # ARM 32-bit (celulares mais antigos)
├── app-arm64-v8a-release.apk     # ARM 64-bit (maioria dos celulares modernos)
└── app-x86_64-release.apk        # x86 64-bit (emuladores Android)
```

Distribua o `.apk` correto para cada dispositivo. Se não souber a arquitetura, use o APK universal.

### App Bundle (para publicar na Google Play Store)

```bash
flutter build appbundle --release --dart-define-from-file=.env
```

O Google Play distribui automaticamente o binário correto para cada dispositivo.

### APK de debug (testes rápidos sem assinatura)

```bash
flutter build apk --debug --dart-define-from-file=.env
```

### Instalar o APK diretamente no dispositivo via USB

```bash
adb install build/app/outputs/flutter-apk/app-release.apk

# Ou usando o próprio Flutter:
flutter install --dart-define-from-file=.env
```

---

## Testes

```bash
# Rodar todos os testes
flutter test

# Rodar com relatório de cobertura de código
flutter test --coverage
```

---

## Análise de Código

```bash
# Formatar código automaticamente (corrige indentação, espaçamento)
dart format lib/ test/

# Analisar lint e erros de tipo
flutter analyze
```

O projeto deve sempre ter **0 issues** em `flutter analyze`.

---

## Backend

A API REST é construída em **Express.js + Supabase** e hospedada no **Render.com** (plano gratuito).

> ⚠️ **Cold Start:** O servidor no Render.com hiberna após 15 minutos de inatividade.
> A primeira requisição após o período inativo pode demorar **até 30 segundos**.
> Isso é comportamento esperado em ambiente de desenvolvimento — aguarde o servidor
> acordar e a requisição será concluída normalmente.

### Endpoints principais

| Método | Rota | Descrição |
|--------|------|-----------|
| `POST` | `/auth/login` | Autenticação por `id_operador` + `pin` (inteiro) |
| `GET` | `/operadores` | Lista operadores ativos |
| `GET` | `/maquinas` | Lista máquinas ativas |
| `GET` | `/itens` | Itens do checklist com categoria |
| `POST` | `/checklists` | Cria cabeçalho do checklist; retorna `id_checklist` |
| `POST` | `/checklists/:id/respostas` | Salva respostas do checklist |
| `GET` | `/checklists` | Histórico de checklists (filtro por `operador_id`) |
| `GET` | `/checklists/:id` | Detalhes completos de um checklist com todas as respostas |

---

## Paleta de Cores

| Nome | Hex | Uso |
|------|-----|-----|
| `AppColors.primary` | `#1B4332` | Cor principal — verde escuro floresta |
| `AppColors.secondary` | `#8DC63F` | Verde limão — uso geral de destaque |
| Background | Gradiente `#C8E6C9` → `#FFFFFF` | Fundo de todas as telas |
| Botão desabilitado | `#000000` com 60% de opacidade | Estado inativo do `AppButton` |
| Cancelar / Voltar | `#F28B82` | Botão de ação destrutiva ou retorno |
| Seleção nas listas | `#FFFFFF` (branco) | Item selecionado em Operador, Máquina e histórico |

#### Padrão de seleção em listas

Itens selecionados nas listas (Operador, Máquina) recebem fundo branco com bordas arredondadas e uma pequena margem lateral, evitando que o destaque ultrapasse as bordas arredondadas do container pai:

```dart
Container(
  margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
  decoration: BoxDecoration(
    color: isSelected ? Colors.white : Colors.transparent,
    borderRadius: BorderRadius.circular(12),
  ),
  child: OperatorCard(...),
)
```

Na lista de histórico (checklist feitos), o feedback de toque usa splash e highlight brancos no `InkWell` do `ActivityTile`:

```dart
InkWell(
  onTap: onTap,
  splashColor: Colors.white38,
  highlightColor: Colors.white24,
  child: ...,
)
```

---

## Tipografia

O app usa a fonte **Inter** em todos os textos. A fonte está incluída localmente no projeto (não depende de internet em tempo de execução).

| Peso Flutter | Valor numérico | Uso típico |
|-------------|---------------|------------|
| `w400` | Regular (400) | Textos secundários, descrições |
| `w500` | Medium (500) | Itens de lista, labels |
| `w600` | SemiBold (600) | Chips, badges, destaques |
| `w700` | Bold (700) | Textos de entrada, valores numéricos |
| `w900` | Black (900) | Títulos de página |

---

## Referências

- [Flutter — Arquitetura recomendada](https://docs.flutter.dev/app-architecture)
- [flutter_bloc — Cubit](https://bloclibrary.dev/flutter-bloc-concepts/#cubit)
- [go_router — Documentação oficial](https://pub.dev/packages/go_router)
- [get_it — Service Locator](https://pub.dev/packages/get_it)
- [Dio — HTTP Client](https://pub.dev/packages/dio)
- [Supabase — Backend as a Service](https://supabase.com/docs)
