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
gems:
  - jemoji
```

In any page or post, use emoji as you would normally, e.g.

```markdown
I give this plugin two :+1:!
```

## Customizing

If you'd like to serve emoji images locally, or use a custom emoji source, you can specify so in your `_config.yml` file:

```yml
emoji:
  src: "/assets/images/emoji"
```

See the [Gemoji](https://github.com/github/gemoji) documentation for generating image files.
