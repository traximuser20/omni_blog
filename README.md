# OmniBlog

An editorial blog built with Ruby on Rails — "Stories worth reading." OmniBlog
publishes long-form essays, tutorials and field notes with a refined, print-inspired
UI, a public comment system, file attachments, and a full ActiveAdmin back office.

## Features

- **Editorial public site** — featured story, latest grid, reading-time estimates,
  progress bar, responsive Tailwind v4 theme (stone/orange, Fraunces display type).
- **Stories (Posts)** — create, edit, delete posts with title + content; JSON
  endpoints for the feed.
- **Comments** — signed-in users can comment on any post; authors can delete their
  own comments; avatars derived from account initials.
- **Attachments** — drag-and-drop multi-file upload on new/edit forms (images,
  PDFs, documents); gallery on the post page with image thumbnails and download
  links; per-file removal. Stored via Active Storage (local disk in dev/prod).
- **Authentication** — Devise for readers (`User`) and administrators (`AdminUser`).
- **Admin back office** — ActiveAdmin with dashboard (recent posts + stats), post
  management with a public-comments panel and internal "Admin notes", public
  comment moderation, admin user management, and styled theme.
- **Accessibility & UX** — semantic markup, keyboard-friendly forms, empty states,
  Turbo-driven interactions.

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Ruby on Rails 8.1 (Ruby 3.4) |
| Database | PostgreSQL |
| Auth | Devise (users + admin users) |
| Admin | ActiveAdmin 3.5 |
| Frontend | Tailwind CSS v4, Hotwire (Turbo + Stimulus), Propshaft + Importmap |
| Storage | Active Storage (local disk) |
| Jobs/Cache/Cable | Solid Queue / Solid Cache / Solid Cable |
| Deployment | Kamal + Docker + Thruster |
| Testing | Minitest (unit, controller, integration) |
| Linting | RuboCop (rails-omakase) |

## Getting Started

### Prerequisites

- Ruby 3.4+
- PostgreSQL 14+
- Node is **not** required (assets use Importmap + Tailwind CLI via gems)

### Setup

```bash
# Install gems
bundle install

# Create and migrate the database
bin/rails db:create db:migrate

# (Optional) load seed data
bin/rails db:seed

# Build assets
bin/rails tailwindcss:build
bin/rails dartsass:build
```

### Run the app

```bash
bin/rails server
# or, with asset watchers:
bin/dev
```

Visit http://localhost:3000

### Admin access

- URL: http://localhost:3000/admin
- Default seeded admin: `admin@example.com` / `password` (change in production)
- Admin navigation: Dashboard · Comments (public comments) · Admin Users · Posts · Admin Notes (internal notes)

## Development

```bash
# Run the test suite
bin/rails test

# Lint
bundle exec rubocop

# Security audit
bundle exec brakeman
bundle exec bundler-audit

# Rebuild assets after template/class changes
bin/rails tailwindcss:build
bin/rails dartsass:build
```

## Routes

| Method | Path | Purpose |
|---|---|---|
| GET | `/` | Post index (featured + grid) |
| GET | `/posts/:id` | Post show (body, attachments, comments) |
| GET | `/posts/new`, `/posts/:id/edit` | Post form (title, content, attachments) |
| POST/PATCH/DELETE | `/posts`, `/posts/:id` | Post CRUD |
| POST | `/posts/:post_id/comments` | Create comment (auth required) |
| DELETE | `/posts/:post_id/comments/:id` | Delete own comment |
| DELETE | `/posts/:post_id/attachments/:id` | Remove an attachment |
| GET | `/admin` | ActiveAdmin dashboard |
| GET | `/admin/posts`, `/admin/comments`, `/admin/admin_users`, `/admin/admin_comments` | Admin resources |

## Data Model

- **Post** — `title`, `content`; `has_many :comments`, `has_many_attached :attachments`.
- **Comment** — `body` (≤ 2000 chars); `belongs_to :post`, `belongs_to :user`.
- **User** — Devise (`database_authenticatable`, `registerable`, `recoverable`, `rememberable`, `validatable`); `has_many :comments`.
- **AdminUser** — Devise admin; `serialize_from_session` hardened for Devise 5.0.
- **ActiveStorage::Blob/Attachment/VariantRecord** — file storage.

## Project Structure

```
app/
  admin/              # ActiveAdmin resources (dashboard, posts, comments, admin_users)
  controllers/        # ApplicationController, PostsController, CommentsController, AttachmentsController
  helpers/            # ApplicationHelper, PostsHelper, CommentsHelper
  javascript/controllers/  # Stimulus: post-form, reading-progress, password-visibility, attachment-upload
  models/             # ApplicationRecord, Post, Comment, User, AdminUser
  views/
    layouts/          # application.html.erb
    posts/            # index, show, new, edit, _form, _post
    comments/         # _comment, _form
    devise/           # auth views
admin/                # (see app/admin)
config/
  routes.rb
  storage.yml         # Active Storage services
  initializers/       # active_admin, devise, assets, dartsass
db/
  migrate/            # schema migrations (incl. Active Storage)
  schema.rb
test/                 # Minitest suites + fixtures
```

## Storage

Files are stored on the local filesystem:

- Development/Production: `storage/` (see `config/storage.yml` `:local`)
- Test: `tmp/storage/` (`:test`)

`/storage/*` is gitignored. For production, configure S3/GCS in `config/storage.yml` and set
`config.active_storage.service` accordingly.

## Deployment

The app ships with a `Dockerfile` and Kamal configuration (`.kamal/`). Thruster provides
HTTP caching/compression in front of Puma. Set environment variables for the database,
`SECRET_KEY_BASE`, and the chosen storage service before deploying.

## Contributing

1. Create a feature branch.
2. Write tests first (`bin/rails test`).
3. Run `bundle exec rubocop` and `bundle exec brakeman`.
4. Open a pull request with a clear description.

## CI/CD

### Continuous Integration (GitHub Actions)

`.github/workflows/ci.yml` runs on every pull request and push to `main`:

- **Security scans** — Brakeman (static analysis), bundler-audit (gem CVEs), importmap audit (JS deps).
- **Lint** — RuboCop (rails-omakase).
- **Tests** — Minitest suite against PostgreSQL, with asset precompilation.
- **System tests** — Capybara/Selenium (currently none defined).

Concurrency cancellation is enabled to save CI minutes.

### Continuous Deployment

`.github/workflows/cd.yml` builds and pushes the Docker image to GitHub Container
Registry (`ghcr.io`) on every push to `main`. Kamal deploys are triggered manually
via `workflow_dispatch` (input `deploy: true`) and require these repository secrets:

- `RAILS_MASTER_KEY`
- `SSH_PRIVATE_KEY`
- `KAMAL_REGISTRY_PASSWORD` (if using an authenticated registry)

> **Note:** `config/deploy.yml` ships with a private target (`192.168.0.1`) and a
> local registry (`localhost:5555`). Update `servers.web` and `registry.server` to
> your real host/registry before deploying from GitHub Actions.

Run a deploy locally at any time with:

```bash
bin/kamal deploy
```

## License

MIT
