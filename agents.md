---
name: omni_blog_agents
description: Agents for the omni_blog project — a Rails 8 editorial blog with Devise auth, ActiveAdmin, comments and Active Storage attachments
metadata:
  type: agents
---

# Agents for omni_blog

OmniBlog is a Ruby on Rails 8.1 application: an editorial blog ("Stories worth
reading") with Devise authentication (users + admin users), ActiveAdmin
administration, public comments, Active Storage attachments, Tailwind v4 +
Hotwire (Turbo/Stimulus), Propshaft asset pipeline, and PostgreSQL.

Core stack: Rails 8.1 · Ruby 3.4 · PostgreSQL · Devise · ActiveAdmin 3.5 ·
Tailwind v4 · Hotwire (Turbo + Stimulus) · Propshaft · Importmap · Active
Storage · Solid Cache/Queue/Cable · Kamal/Thruster deployment.

## Core Agents

Use these for everyday work on this codebase.

- planner: Implementation planning for new features and refactors (e.g. adding a new resource, a new Stimulus controller).
- tdd-guide: Test-driven development with Minitest (this project uses Minitest, not RSpec). Write failing tests first, then implement.
- code-reviewer: Code quality, maintainability, and Rails conventions review.
- security-reviewer: Security review — auth, input handling, file uploads, ActiveAdmin permissions, CSRF, strong params.
- build-error-resolver: Fix Rails/boot/test/build errors (migrations, asset builds, importmap).
- refactor-cleaner: Dead code and consolidation cleanup.
- doc-updater: Keep README/docs/codemaps in sync with code changes.

## Rails-Specific Agents

- rails-reviewer: Rails 8 idioms — controllers, models, routes, helpers, views, migrations, strong params.
- rails-architecture: MVC boundaries, service objects, concerns, Active Record associations, query optimization.
- rails-security: Devise auth flows, ActiveAdmin authorization, Ransack allowlists, file upload validation, CSP.
- rails-performance: N+1 queries, eager loading, indexing, caching, asset pipeline.
- rails-migration-reviewer: Safe, reversible migrations, zero-downtime changes, index/constraint correctness.
- activeadmin-reviewer: ActiveAdmin resources, filters, Ransack integration, menu structure, admin styling.
- devise-reviewer: User/AdminUser auth, sessions, registrations, password flows, scopes.
- active-storage-reviewer: Attachments, purge, storage services, validation, upload UI.

## Frontend Agents

- frontend-reviewer: ERB views, Tailwind v4 classes, accessibility, responsive layout.
- stimulus-reviewer: Stimulus controllers (post-form, reading-progress, password-visibility, attachment-upload).
- hotwire-reviewer: Turbo frames/streams, form submissions, navigation.
- css-reviewer: Tailwind build, custom CSS, ActiveAdmin SCSS, theme tokens.

## Testing Agents

- test-reviewer: Minitest coverage, fixtures, integration tests, system tests (Capybara/Selenium).
- e2e-runner: Critical user flows (post CRUD, comments, attachments, admin).
- fixture-reviewer: Fixture data consistency (posts, users, comments, admin_users).

## Specialized Agents

- a11y-reviewer: Accessibility (WCAG 2.2) for forms, modals, keyboard navigation.
- seo-reviewer: Meta tags, structured data, Core Web Vitals.
- dependency-reviewer: Gemfile audit (bundler-audit, brakeman).
- deployment-reviewer: Kamal/Docker/Thruster, production config, secrets.

## Agent Usage Guidelines

- Use tdd-guide for all new features and bug fixes; this project's tests live in `test/` (Minitest).
- Use code-reviewer immediately after writing or modifying code.
- Use security-reviewer for auth, admin, upload, or input-handling changes.
- Use rails-reviewer for any controller/model/route/migration change.
- Use activeadmin-reviewer when touching `app/admin/` or ActiveAdmin config.
- Use stimulus-reviewer when touching `app/javascript/controllers/`.
- Use rails-migration-reviewer for any new migration.
- Run `bin/rails test` and `bundle exec rubocop` before declaring work done.
- Run `bin/rails db:migrate` and keep `db/schema.rb` in sync when adding migrations.
- Keep changes consistent with the editorial Tailwind theme (stone/orange, Fraunces display font).

## Recent Professionalization
- Enabled Devise `:trackable` for `AdminUser` (session tracking).
- Added `Post` validations (title/content presence and title length).
- Added performance indexes on `posts.created_at` and `comments(post_id, created_at)`.
- Hardened Stimulus `reading-progress` controller lifecycle.
- Expanded Minitest coverage for `Post`, `User`, and `AdminUser`.
