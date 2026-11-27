---
name: omni_blog_agents
description: Agents for the omni_blog project — a Rails 8 editorial blog MVP with Devise auth, ActiveAdmin, categories, tags, search, comments, likes, bookmarks, Active Storage attachments, SEO and dark mode
metadata:
  type: agents
---

# Agents for omni_blog

OmniBlog is a Ruby on Rails 8.1 application: an editorial blog ("Stories worth
reading") MVP with Devise authentication (users + admin users), ActiveAdmin
administration, categories, tags, PostgreSQL search (ILIKE), public comments
with moderation status, Active Storage attachments and cover images, post likes
and bookmarks, Tailwind v4 + Hotwire (Turbo/Stimulus), Propshaft asset
pipeline, SEO (meta tags, sitemap, RSS, JSON-LD), dark mode, and PostgreSQL.

Core stack: Rails 8.1 · Ruby 3.4 · PostgreSQL · Devise · ActiveAdmin 3.5 ·
Tailwind v4 · Hotwire (Turbo + Stimulus) · Propshaft · Importmap · Active
Storage · Solid Cache/Queue/Cable · Kamal/Thruster deployment.

## Core Agents

Use these for everyday work on this codebase.

- planner: Implementation planning for new features and refactors.
- tdd-guide: Test-driven development with Minitest.
- code-reviewer: Code quality, maintainability, and Rails conventions review.
- security-reviewer: Security review — auth, input handling, file uploads, ActiveAdmin permissions, CSRF, strong params.
- build-error-resolver: Fix Rails/boot/test/build errors (migrations, asset builds, importmap).
- refactor-cleaner: Dead code and consolidation cleanup.
- doc-updater: Keep README/docs/codemaps in sync with code changes.

## Rails-Specific Agents

- rails-reviewer: Rails 8 idioms.
- rails-architecture: MVC boundaries, associations, query optimization.
- rails-security: Devise auth flows, ActiveAdmin authorization, Ransack allowlists, file upload validation, CSP.
- rails-performance: N+1 queries, eager loading, indexing, caching, asset pipeline.
- rails-migration-reviewer: Safe, reversible migrations.
- activeadmin-reviewer: ActiveAdmin resources, filters, Ransack integration.
- devise-reviewer: User/AdminUser auth, sessions, registrations, password flows.
- active-storage-reviewer: Attachments, cover images, purge, validation, upload UI.

## Frontend Agents

- frontend-reviewer: ERB views, Tailwind v4, accessibility, responsive layout, dark mode.
- stimulus-reviewer: Stimulus controllers.
- hotwire-reviewer: Turbo frames/streams, form submissions, navigation.
- css-reviewer: Tailwind build, custom CSS, ActiveAdmin SCSS, theme tokens.

## Testing Agents

- test-reviewer: Minitest coverage, fixtures, integration tests.
- e2e-runner: Critical user flows (post CRUD, comments, attachments, categories, tags, likes, bookmarks, search, admin).
- fixture-reviewer: Fixture data consistency.

## Specialized Agents

- a11y-reviewer: Accessibility (WCAG 2.2).
- seo-reviewer: Meta tags, structured data (BlogPosting), sitemap, RSS feed.
- dependency-reviewer: Gemfile audit (bundler-audit, brakeman).
- deployment-reviewer: Kamal/Docker/Thruster, production config, secrets.

## Agent Usage Guidelines

- Use tdd-guide for all new features and bug fixes; tests live in `test/` (Minitest).
- Use code-reviewer immediately after writing or modifying code.
- Use security-reviewer for auth, admin, upload, or input-handling changes.
- Use rails-reviewer for any controller/model/route/migration change.
- Use activeadmin-reviewer when touching `app/admin/`.
- Use stimulus-reviewer when touching `app/javascript/controllers/`.
- Use rails-migration-reviewer for any new migration.
- Run `bin/rails test` and `bundle exec rubocop` before declaring work done.
- Run `bin/rails db:migrate` and keep `db/schema.rb` in sync.
- Keep changes consistent with the editorial Tailwind theme (stone/orange, Fraunces).

## MVP Status (completed)

- Database: posts (slug, subtitle, excerpt, status, published_at, seo_*, user_id, category_id), categories, tags, post_tags, post_likes, bookmarks, comments (status).
- Models: Post, Category, Tag, PostTag, PostLike, Bookmark, User, Comment.
- Routes: `/`, `/blog`, `/blog/:slug`, `/categories`, `/category/:slug`, `/tags`, `/tag/:slug`, `/search`, `/about`, `/contact`, `/bookmarks`.
- Admin: `/admin` dashboard, posts, categories, tags, comments, media.
- Features: draft/publish, cover image upload, reading time, likes, bookmarks, comments moderation, SEO, dark mode (Light/Dark/System), responsive UI.
- Tests: 52 runs, 147 assertions, 0 failures; RuboCop clean.

## Phase 2 (not yet built)

Advanced roles/RBAC, review workflow, scheduled publishing, revision history,
audit logs, advanced media library, notifications, newsletter, analytics,
recommendations, AI. Do not implement unless explicitly instructed.
