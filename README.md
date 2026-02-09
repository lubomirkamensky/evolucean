<p align="center">
    <h1>Evolution</h1>
    <i>AI Pair Programming with Learning Workflows</i>
</p>

<p align="center">
Fork of <a href="https://github.com/Aider-AI/aider">Aider</a> - AI pair programming in your terminal
</p>

<p align="center">
Evolution rozšiřuje Aider o learning workflows: WOOP, Knowledge Base, Blueprinting a Reflexe
</p>

---

## Features

### ✅ Aider Core Features
- Cloud and local LLMs (Claude, OpenAI, DeepSeek, Ollama...)
- Codebase mapping with repomap
- 100+ programming languages
- Git integration
- IDE integration
- Linting & testing

### 🆕 Evolution Learning Features

#### WOOP Workflow
- **Wish → Outcome → Obstacle → Plan**
- Cílevědomé dosahování osobních i profesních cílů
- Interaktivní workflow s LLM

#### Knowledge Base
- Wiki KB integrace (my.wiki)
- Automatické načítání kontextových souborů
- Externí mozek pro LLM

#### Blueprinting
- Dokumentované postupy pro LLM
- Opakovatelné workflow
- Znalostní báze best practices

#### Reflexe
- Zachycování insightů
- Učení se z praxe
- Kontinuální růst

---

## Installation

```bash
# Z GitHubu
pip install git+https://github.com/lubomirkamensky/evolution

# Nebo lokálně
cd evolution
pip install -e .
```

## Configuration

Vytvoř `.evolution.conf.yml`:

```yaml
# Model settings
model: claude-sonnet
api-key: env

# Learning features
learning:
  mode: interactive
  context:
    auto-load: true
    wiki-sync: true
  workflows:
    woop: enabled
    blueprint: enabled
    reflekse: enabled

# Git
auto-commits: false
```

## Usage

```bash
# Start Evolution
evolution

# S konkrétním modelem
evolution --model ollama/deepseek-coder

# S WOOP workflow
evolution --woop

# S wiki sync
evolution --wiki-sync
```

## Architecture

```
Evolution = Aider Core + Learning Layer
├── aider/           # Core Aider functionality
├── evolution/       # Naše přidaná hodnota
│   ├── workflows/   # WOOP, Blueprinting, Reflekse
│   ├── knowledge/   # Wiki KB integrace
│   └── config/      # Multi-provider config
└── scripts/         # Utilities
```

## License

Apache 2.0 (stejně jako Aider)

## Links

- **Originální Aider:** https://github.com/Aider-AI/aider
- **Evolucean Wiki:** http://my:3001/#evolucean
- **Evolucean Plugin:** https://github.com/lubomirkamensky/evolucean-plugin

## Acknowledgments

Díky **Aider-AI** za skvělý foundation! Evolution je fork s učícími se workflow pro osobní růst.
