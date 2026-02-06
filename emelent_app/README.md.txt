```md
# 🚀 EVOLV – Flutter Basic Starter Kit V0.3.0

**EVOLV** is a Flutter **basic starter kit** built to help developers create scalable applications using **Clean Architecture** with minimal boilerplate.  
It includes a **powerful CLI helper** that automates BLoC creation, Dependency Injection wiring, use cases, and data/domain layers — so you can focus on building features faster.

---

## ✨ Features

| Category | Stack |
|--------|------|
| **Architecture** | Basic Clean Architecture |
| **State Management** | BLoC (Basic) |
| **Dependency Injection** | GetIt + Injectable |
| **Authentication** | Email Only |
| **Roles** | 2 Roles |
| **Automation** | CLI for feature & code generation |

---

## 🧱 Project Structure

```

lib/
│
├── core/
│   ├── di/
│   ├── error/
│   ├── usecase/
│   └── utils/
│
├── features/
│   └── <feature_name>/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       │
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       │
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
│
└── main.dart

````

---

## 🔄 State Management – BLoC

- Uses `flutter_bloc`
- Clear **Event → State** flow
- Keeps UI and business logic separated
- Lightweight and beginner-friendly

---

## 🔌 Dependency Injection

- **GetIt** for service locating
- **Injectable** for automatic DI generation
- All DI wiring can be automated using the CLI

---

## 🔐 Authentication

- Email-based authentication
- Cleanly structured for future providers
- Role-aware authentication flow

---

## 👥 Roles

- Supports **2 user roles**
- Role-based navigation and access
- Easy to extend for additional roles

---

## ⚡ EVOLV CLI Helper

The EVOLV CLI dramatically reduces boilerplate by automating:

- Feature scaffolding
- BLoC generation
- Use case creation
- Data & domain layer setup
- Dependency Injection wiring
- Route integration

---

## 📦 Install CLI

Install the CLI globally using:

```bash
dart pub global activate --source git https://github.com/JerinJamesDeveloper/embitCli.git
````

**Current Version:** `v1.0.0`

---

## 🛠 CLI Usage

### Create a Feature

```bash
embit feature --name auth
```

Automatically generates:

* Data, Domain, Presentation layers
* Repository interfaces & implementations
* Use cases
* BLoC (event, state, bloc)
* Dependency Injection setup
* Route wiring

---

### Generate BLoC

```bash
embit bloc --name login
```

Generates:

* `login_bloc.dart`
* `login_event.dart`
* `login_state.dart`

---

### Generate Use Case

```bash
embit usecase --name login_user
```

Generates:

* Use case class
* Proper domain-layer wiring

---

### Generate Data & Domain Modules

```bash
embit module --name profile
```

Generates:

* Entities
* Models
* Repository interfaces
* Repository implementations
* Datasources

---

## 🎯 Why EVOLV?

* 🚀 Faster development with less boilerplate
* 🧠 Clean Architecture without complexity
* 🛠 CLI-powered automation
* 📈 Scales well from MVP to production
* 👶 Beginner-friendly structure

---

## 🧑‍💻 Who Should Use This?

* Flutter developers
* Clean Architecture learners
* Indie hackers
* Startup teams
* Developers who want speed + structure

---

## 📌 Versioning

* **EVOLV Kit** – Stable
* **EVOLV CLI** – `v1.0.0`

---

## 🌱 Roadmap

* Firebase & REST templates
* Additional authentication providers
* Advanced role management
* Test generation via CLI
* Modular CLI extensions

---

## 💬 Feedback & Contributions

Contributions, ideas, and feedback are always welcome!
Feel free to open issues or pull requests 🚀

---

**EVOLV** – *Build faster. Scale smarter. Code cleaner.* ✨

```
```
