---
name: omni_blog_agents
description: Agents for omni_blog project
metadata:
  type: agents
---

# Agents for omni_blog

## Core Agents

- planner: Implementation planning for complex features and refactoring
- architect: System design and scalability decisions
- tdd-guide: Test-driven development for new features and bug fixes
- code-reviewer: Code quality and maintainability review
- security-reviewer: Security vulnerability detection before commits
- spec-miner: Brownfield spec extraction for onboarding to spec-driven development
- build-error-resolver: Fix build and type errors when build fails
- e2e-runner: End-to-end Playwright testing for critical user flows
- refactor-cleaner: Dead code cleanup and consolidation
- doc-updater: Documentation and codemaps updates
- cpp-reviewer: C/C++ code review
- cpp-build-resolver: C/C++ build error resolution
- fsharp-reviewer: F# functional code review
- docs-lookup: Documentation lookup via Context7
- go-reviewer: Go code review
- go-build-resolver: Go build error resolution
- kotlin-reviewer: Kotlin code review
- kotlin-build-resolver: Kotlin/Gradle build error resolution
- database-reviewer: PostgreSQL/Supabase specialist for schema and query optimization
- python-reviewer: Python code review
- django-reviewer: Django code review
- django-build-resolver: Django build, migration, and setup error resolution
- java-reviewer: Java and Spring Boot code review
- java-build-resolver: Java/Maven/Gradle build error resolution
- loop-operator: Autonomous loop execution and monitoring
- harness-optimizer: Harness configuration tuning for reliability and cost
- rust-reviewer: Rust code review
- rust-build-resolver: Rust build error resolution
- gdscript-reviewer: GDScript and Godot 4 code review
- pytorch-build-resolver: PyTorch runtime and training error resolution
- mle-reviewer: Production ML pipeline review
- rag-pipeline-reviewer: RAG pipeline review for retrieval quality
- typescript-reviewer: TypeScript/JavaScript code review
- react-reviewer: React/JSX code review
- react-build-resolver: React build error resolution
- vue-reviewer: Vue.js Composition API and reactivity review
- swift-reviewer: Swift/iOS code review
- swift-build-resolver: Swift/Xcode/SPM build error resolution
- flutter-reviewer: Flutter/Dart widget and state review
- dart-build-resolver: Dart/Flutter build and dependency error resolution
- csharp-reviewer: C#/.NET code review
- fastapi-reviewer: FastAPI async correctness and OpenAPI review
- php-reviewer: PHP/PSR-12 and Eloquent security review
- harmonyos-app-resolver: HarmonyOS ArkTS/ArkUI code and API review
- healthcare-reviewer: Clinical safety and PHI compliance review
- a11y-architect: WCAG 2.2 accessibility architecture
- code-architect: Feature architecture blueprints from codebase patterns
- code-explorer: Execution path tracing and architecture mapping
- code-simplifier: Clarity-focused code refinement without behavior change
- comment-analyzer: Code comment accuracy and rot risk analysis
- commit-reviewer: Conventional Commits message drafting for staged diffs
- conversation-analyzer: Extract hook behaviors from session transcripts
- chief-of-staff: Multi-channel communication triage and drafting
- marketing-agent: Marketing strategist and copywriter for campaigns
- seo-specialist: Technical SEO audit and optimization
- opensource-forker: Fork projects and strip secrets for open-sourcing
- opensource-sanitizer: Verify open-source fork is fully sanitized
- opensource-packager: Generate OSS packaging boilerplate
- gan-planner: Expand prompt into full product specification
- gan-generator: Implement features per spec with evaluator feedback
- gan-evaluator: Test application via Playwright and score it
- plan: Software architect agent for implementation plans
- plan-orchestrate: Multi-agent orchestration for complex features
- pr-test-analyzer: Pull request test coverage quality and completeness
- python-review: Python code review
- quality-gate: General quality gate for all code
- react-build: React build failure resolution
- react-review: React/JSX code review
- react-test: React testing
- refactor-clean: Dead code cleanup
- resume-session: Resume session after interruption
- review-pr: Pull request review
- rust-build: Rust build failure resolution
- rust-review: Rust code review
- rust-test: Rust testing
- santa-loop: Autonomous loop execution

## Specialized Agents

- bengali-reviewer: Bengali text Unicode and locale correctness
- healthcare-reviewer: Clinical safety and PHI compliance
- a11y-architect: WCAG 2.2 accessibility architecture
- code-architect: Feature architecture blueprints
- code-explorer: Codebase execution path tracing
- commit-reviewer: Conventional Commits message drafting
- conversation-analyzer: Hook behavior extraction from transcripts
- chief-of-staff: Multi-channel communication management
- marketing-agent: Marketing campaign planning and copywriting
- seo-specialist: Technical SEO audit and optimization
- opensource-forker: Open-source project forking and sanitization
- opensource-sanitizer: Open-source fork verification
- opensource-packager: Open-source packaging generation
- gan-planner: GAN harness specification planning
- gan-generator: GAN harness feature implementation
- gan-evaluator: GAN harness evaluation via Playwright
- plan-orchestrate: Multi-agent orchestration for complex features

## Agent Usage Guidelines

- Use planner for complex features and refactoring
- Use code-reviewer immediately after writing or modifying code
- Use tdd-guide for new features and bug fixes
- Use security-reviewer for security-sensitive code
- Use spec-miner for brownfield project onboarding
- Use build-error-resolver when build fails
- Use e2e-runner for critical user flows
- Use refactor-cleaner for dead code cleanup
- Use doc-updater for documentation updates
- Use the appropriate language-specific reviewer for language-specific code
- Use loop-operator for autonomous loops
- Use harness-optimizer for harness configuration tuning