# 🌿🪶 Fernquill

A writing app for novelists that keeps the words yours. AI helps in small, specific ways (finding a word, diagnosing a clunky sentence, critiquing rhythm, asking questions about plot) but never writes your prose for you.

Fernquill treats audio as a first-class output: you'll be able to hear your manuscript in the voices your listeners will hear.

## Stack

Rails 8.1, Postgres, Hotwire, Vite, Tailwind CSS. Sign-in is Google OAuth via OmniAuth on top of Rails' built-in session authentication.

## Development

Requires [mise](https://mise.jdx.dev) and Docker.

```sh
mise install
cp .env.example .env   # add your Google OAuth client ID and secret
mise run setup         # start Postgres, install gems and packages, prepare the database
mise run dev           # Rails on http://localhost:3000 plus the Vite dev server
```

Postgres runs in Docker on port 5433 so it can coexist with other local apps on 5432.

### Google OAuth

Create an OAuth client of type "Web application" at https://console.cloud.google.com/apis/credentials and add `http://localhost:3000/auth/google_oauth2/callback` as an authorized redirect URI.

### Checks

```sh
mise run spec    # RSpec
mise run lint    # RuboCop
mise run check   # both
```

## License

MIT
