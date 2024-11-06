
# Production Deployment

## Why produciton build?

 - All build optimizations are enabled
 - Debug messages aren't shown
   - Debug messages don't consider security issues
   - So they need to be hidden
 - Need to manage app secrets

## Secrets?

We have some info that the app needs, but that shouldn't be public.

 - SECRET KEY BASE: This is what the app uses to sign tokens, like session cookies,
   other security tokens, XSS token, etc.
 - Database password 
 - Others: External API keys

Handling secrets:

 - Make sure your secrets never end up in your Git repository.
 - Publishing your (e.g.) Amazon AWS key to a public git repository is a good way to lose $10k.
 - In Phoenix, we usually do secrets as enviornment variables.
 - Env vars are easy to do with a ~/prod-env.sh script that you can source in your start.sh script.

# Releases

 - Bundle together app, mix deps, and Erlang/Elixir runtimes.
 - Doesn't include system library deps, so you need to run on the same OS release (e.g. Debian 12)
   with the same system packages (e.g. apt-get xxx) installed.
 - So your build system needs to be the same as your target server. That could be a docker container
   if you wanted to get clever.
