# OmniBlog

An editorial blog built with Ruby on Rails — "Stories worth reading." OmniBlog is a
production-quality MVP blog platform with a refined, print-inspired public UI, a full
ActiveAdmin back office, categories, tags, search, comments, likes, bookmarks, SEO,
dark mode, and PostgreSQL.

## Features (MVP)

- **Public website** — `/`, `/blog`, `/blog/:slug`, `/categories`, `/category/:slug`, `/tags`, `/tag/:slug`, `/search`, `/about`, `/contact`, `/bookmarks`.
- **Homepage** — featured post, latest grid, reading-time estimates, responsive Tailwind v4 theme (stone/orange, Fraunces display type).
- **Article page** — title, subtitle, cover image, author, published/updated dates, reading time, category, tags, content, table of contents, reading progress, social sharing, like, bookmark, comments, related posts.
- **Blog listing** — post cards, cover image, title, excerpt, author, category, tags, published date, reading time, pagination, category/tag filtering, sorting by latest.
- **Search** — PostgreSQL ILIKE search across title, excerpt, content, tags, categories with pagination and empty state.
- **Admin authentication** — Devise for readers (`User`) and administrators (`AdminUser`); secure sessions, password hashing.
- **Admin back office** (`/admin`) — Dashboard, Posts, Categories, Tags, Media, Comments, Settings. Draft/publish/unpublish, preview, slug auto-generation, reading time.
- **Post management** — create, edit, delete, save draft, publish, unpublish, preview. Statuses: `DRAFT`, `PUBLISHED`.
- **Categories & Tags** — full CRUD, public pages, assignment/removal.
- **Media** — Active Storage cover images and inline attachments, file type/size validation, preview, deletion.
- **Comments** — add, delete own, admin delete, `APPROVED`/`PENDING` moderation.
- **Likes** — like/unlike, count, duplicate prevention.
- **Bookmarks** — bookmark/remove, "My bookmarks" page.
- **SEO** — title, meta description, canonical URL, Open Graph tags, robots.txt, XML sitemap, RSS feed, `BlogPosting` JSON-LD.
- **Dark mode** — Light/Dark/System, persisted preference.
- **Accessibility** — semantic HTML, keyboard navigation, form labels, focus states, contrast.
- **Performance** — pagination, database indexes, eager loading, lazy-loaded images.

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

### Setup

```bash
# Install gems
bundle install

# Create and migrate the database
bin/rails db:create db:migrate

# Load seed data (optional)
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
- Admin navigation: Dashboard · Posts · Categories · Tags · Media · Comments · Settings

## Development

```bash
# Run the test suite
bin/rails test

# Lint
bundle exec rubocop

# Security audit
bundle exec brakeman

# Rebuild assets after template/class changes
bin/rails tailwindcss:build
bin/rails dartsass:build
```

## Routes

| Method | Path | Purpose |
|---|---|---|
| GET | `/` | Homepage (featured + latest) |
| GET | `/blog` | Blog listing |
| GET | `/blog/:slug` | Article page |
| GET | `/categories` | Categories index |
| GET | `/category/:slug` | Category page |
| GET | `/tags` | Tags index |
| GET | `/tag/:slug` | Tag page |
| GET | `/search` | Search |
| GET | `/about` | About page |
| GET | `/contact` | Contact page |
| GET | `/bookmarks` | My bookmarks (auth required) |
| POST/DELETE | `/posts/:slug/like` | Like/unlike |
| POST/DELETE | `/posts/:slug/bookmark` | Bookmark/remove |
| POST/DELETE | `/posts/:post_slug/comments` | Comments |
| GET | `/sitemap.xml` | XML sitemap |
| GET | `/feed.xml` / `/rss.xml` | RSS feed |
| GET | `/admin` | ActiveAdmin dashboard |

## Data Model

- **Post** — `title`, `slug`, `subtitle`, `excerpt`, `content`, `cover_image`, `status`, `published_at`, `seo_title`, `seo_description`; belongs to `user`/`category`; has many `comments`, `tags` (via `post_tags`), `post_likes`, `bookmarks`, `attachments`.
- **Category** — `name`, `slug`, `description`; has many `posts`.
- **Tag** — `name`, `slug`; has many `posts` (via `post_tags`).
- **Comment** — `body`, `status` (`approved`/`pending`); belongs to `post`, `user`.
- **PostLike** — unique `(user_id, post_id)`.
- **Bookmark** — unique `(user_id, post_id)`.
- **User** — Devise reader; has many comments, posts, likes, bookmarks.
- **AdminUser** — Devise admin.
- **ActiveStorage::Blob/Attachment/VariantRecord** — file storage.

## Project Structure

```
app/
  admin/              # ActiveAdmin resources (dashboard, posts, categories, tags, comments)
  controllers/        # Posts, Comments, Attachments, Categories, Tags, Search, Pages, Feeds, PostLikes, Bookmarks
  helpers/            # ApplicationHelper, PostsHelper, CommentsHelper
  javascript/controllers/  # Stimulus: post-form, reading-progress, password-visibility, attachment-upload
  models/             # Post, Category, Tag, PostTag, PostLike, Bookmark, Comment, User, AdminUser
  views/              # layouts, posts, comments, categories, tags, search, pages, bookmarks, feeds
config/
  routes.rb
  storage.yml
db/
  migrate/
  schema.rb
test/                 # Minitest suites + fixtures
```

## Storage

Files are stored on the local filesystem:

- Development/Production: `storage/` (see `config/storage.yml` `:local`)
- Test: `tmp/storage/` (`:test`)

`/storage/*` is gitignored. For production, configure S3/GCS in `config/storage.yml`.

## Deployment

The app ships with a `Dockerfile` and Kamal configuration (`.kamal/`). Thruster provides HTTP caching/compression in front of Puma. Set environment variables for the database, `SECRET_KEY_BASE`, and the chosen storage service before deploying.

## Contributing

1. Create a feature branch.
2. Write tests first (`bin/rails test`).
3. Run `bundle exec rubocop` and `bundle exec brakeman`.
4. Open a pull request with a clear description.

## CI/CD

### Continuous Integration (GitHub Actions)

`.github/workflows/ci.yml` runs on every pull request and push to `main`:

- **Security scans** — Brakeman, bundler-audit, importmap audit.
- **Lint** — RuboCop (rails-omakase).
- **Tests** — Minitest suite against PostgreSQL, with asset precompilation.

### Continuous Deployment

`.github/workflows/cd.yml` builds and pushes the Docker image to GHCR on every push to `main`, then deploys with Kamal (self-hosted runner).

Run a deploy locally at any time with:

```bash
bin/kamal deploy
```

## Phase 2 (not in MVP)

Advanced roles/RBAC, review workflow, scheduled publishing, revision history,
audit logs, advanced media library, notifications, newsletter, analytics,
recommendations, AI. Not implemented; code is structured to allow them later.
