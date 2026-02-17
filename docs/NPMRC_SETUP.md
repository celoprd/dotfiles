# NPM Configuration Template

This is a template for `.npmrc` configuration.

## GitHub Packages Authentication

To authenticate with GitHub Packages, you need to add your GitHub token to your `.npmrc`:

1. Create a Personal Access Token on GitHub:
   - Go to https://github.com/settings/tokens
   - Click "Generate new token (classic)"
   - Select scopes: `repo`, `read:packages`, `write:packages`
   - Copy the token

2. Set the token in your environment:
   ```bash
   # Add to ~/dotfiles/config/.env.zsh
   export GITHUB_TOKEN="ghp_your_token_here"
   ```

3. Add authentication to `.npmrc`:
   ```bash
   echo "//npm.pkg.github.com/:_authToken=\${GITHUB_TOKEN}" >> ~/.npmrc
   ```

Or manually add this line to your `.npmrc`:
```
//npm.pkg.github.com/:_authToken=${GITHUB_TOKEN}
```

## Verify Configuration

Test that you can access GitHub Packages:

```bash
npm login --scope=@skelloapp --registry=https://npm.pkg.github.com

# Or test with pnpm
pnpm config get @skelloapp:registry
```

## Troubleshooting

If you get authentication errors:
1. Make sure `GITHUB_TOKEN` is set in `.env.zsh`
2. Make sure the token has the correct scopes
3. Reload your shell: `source ~/.zshrc`
4. Try again

For more information, see:
- [GitHub Packages Documentation](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-npm-registry)
