# Jemoji

GitHub-flavored Emoji plugin for Jekyll

[![Gem Version](https://badge.fury.io/rb/jemoji.svg)](http://badge.fury.io/rb/jemoji)
[![Build Status](https://travis-ci.org/jekyll/jemoji.svg?branch=master)](https://travis-ci.org/jekyll/jemoji)

## Usage

Add the following to your site's `Gemfile`

```
gem 'jemoji'
```

And add the following to your site's `_config.yml`

```yml
plugins:
  - jemoji
```

💡 If you are using a Jekyll version less than 3.5.0, use the `gems` key instead of `plugins`.

In any page or post, use emoji as you would normally, e.g.

```markdown
I give this plugin two :+1:!
```

## Emoji images

For GitHub Pages sites built on GitHub.com, emoji images are served from the GitHub.com CDN, with a base URL of `https://github.githubassets.com`, which results in emoji image URLs like `https://github.githubassets.com/images/icons/emoji/unicode/1f604.png`.

On GitHub Enterprise installs, page builds receive the `ASSET_HOST_URL` environment variable, which contain a value like `https://assets.ghe.my-company.com`. This results in emoji images for GitHub Pages sites built on a GitHub Enterprise install being served at URLs like `https://assets.ghe.my-company.com/images/icons/emoji/unicode/1f604.png`.

## Customizing

If you'd like to serve emoji images locally, or use a custom emoji source, you can specify so in your `_config.yml` file:

```yml
emoji:
  src: "/assets/images/emoji"
```

See the [Gemoji](https://github.com/github/gemoji) documentation for generating image files.
