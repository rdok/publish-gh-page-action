# Publish GitHub Page

[![build-status](https://github.com/rdok/publish-gh-page-action/workflows/build-status/badge.svg)](https://github.com/rdok/publish-gh-page-action/actions?query=workflow%3Abuild-status)

This GitHub action publishes a GitHub page.

It will publish a given directory to the `gh-pages` branch, on the `docs` folder.  

You'll have to modify your repo settings as per [Choosing a publishing source](https://docs.github.com/en/github/working-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site)

## Usage

```yml
    - name: Publish GitHub Page
      uses: rdok/publish-gh-page-action@v1.0.3
      with:
        directory: build
        github-actor: ${{ github.actor }}
        github-token: ${{ github.token }}
        github-repository: ${{ github.repository }}
```

### Project example
- [rdok/space-explorer](https://github.com/rdok/space-explorer/blob/master/.github/workflows/deploy-react.yml#L20)
