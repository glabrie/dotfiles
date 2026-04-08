<h1 align="center">
   <img src="https://github.com/Frost-Phoenix/nixos-config/blob/main/.github/assets/logo/nixos-logo.png" width="100px" /> 
   <br>
      Ghil's NixOS Dotfiles
</h1>
<p align="center">
   <img src="https://i.postimg.cc/L6t7jFpd/image.png" width="800px" /> <br>
</p>
<p align="center">
   Screenshot last updated <b>2026-04-08</b>
</p>

## The introduction

Good day! You've stumbled upon my personal playground. I've been tinkering with NixOS and a bunch of other things for a bit, but I'm learning and the process is quite messy, so please don't clone this repository expecting an amazing base config to stat. Suggestions are more than welcome though ^_^

## The stack

Here's what I use in this config, on a daily basis!

| Type            | Name                                                          | Notes                                                                              |
|-----------------|---------------------------------------------------------------|------------------------------------------------------------------------------------|
| Distribution    | [NixOS](https://nixos.org/)                                   | One word: declarative. Perfect distro for me                                       |
| Dotfile manager | [Home-manager](https://github.com/nix-community/home-manager) | Declare your whole config! Waste of time? maybe? fun? yes!                         |
| Shell           | [zsh](https://www.zsh.org/)                                   | I'm switching to nushell soon, but zsh was my favorite                             |
| Window manager  | [Niri](https://github.com/niri-wm/niri)                       | Because Hyprland switches config more often than I change my mind, and I have adhd |
| Desktop shell   | [Noctalia](https://github.com/noctalia-dev/noctalia-shell)    | It's beautiful, it's efficient, it makes things so easy.                           |
| Editor          | [Doom Emacs](https://github.com/doomemacs/doomemacs)          | After years of neovim, I fell into the dark side because evil mode is a thing      |
| Browser         | [Zen browser](https://zen-browser.app/)                       | It's sleek and beautiful, feels modern, but it's a bit slow still.                 |
| Music player    | [Spotify + Spicetify](https://spicetify.app/)                 | I'm slowly reverting back to buying music and analog if possible, but meanwhile... |

## Overview

Here's a quick top down view of the system:

``` text
.
'-- modules
    |-- hosts            # Building up the hosts, with programs only meant for that particular computer
    |-- nix              # Nix tools
    |-- programs         # Discrete, self-contained features. Like Niri, or Noctalia.
    |-- system           # Building generic desktops and settings, which are services needed by the desktops
    |-- users            # Yup, you guessed right!
```

## Dendriwhat now?
My dotfiles are currently modeled after the dendritic pattern, which is a way to organize your system from the bottom up instead of top down, designing discrete "features" (it just means standalone) that are then collected either hierarchically (into system types) or picked up by import-tree. That gives me a very flexible, scalable config that's very neat to play with.
Basically, we're using [Flake-parts](https://github.com/hercules-ci/flake-parts) to separate our config in discrete "modules" that can then be imported automatically by [import-tree](https://github.com/vic/import-tree). That leaves us with a very clean flake and a clean, well-separated config. It also allows, if done right, to scale easily with each new system you bring in the config.

It's definitely the buzz word at the moment, but it's also very cool, so hype wagon it is.

## But you have one computer...

Yeah, but I'm a tinkerer, I love it. Plus, I'll be adding to that fairly soon enough. I want to nixify a lot more than my main laptop :)

## I'm new to NixOS though, where do I start?

Not with this config that's for certain XD. Here's a few links that helped me a lot when I began this journey. I'll be adding more as I go along!

| Type      | Name                                                                                                       | Notes                                                                |
|-----------|------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------|
| Resource  | [NixOS website](https://nixos.org)                                                                         | You gotta start somewhere, and that somewhere is a download          |
| Resource  | [nixpkgs](https://search.nixos.org/packages?channel=25.11)                                                 | Search for a package in the repository                               |
| Resource  | [MyNixOS](https://mynixos.com/)                                                                            | same thing as Nixos search, but pretty! ...and searches options too! |
| Resource  | [Nix and flakes book](https://nixos-and-flakes.thiscute.world/)                                            | The bible that helped me get Nix and flakes in the beginning         |
| Resource  | [Doc Steve's dendritic tutorial](https://github.com/Doc-Steve/dendritic-design-with-flake-parts/tree/main) | My config is modeled (lifted really) from this tutorial              |
| Youtuber  | [Vimjoyer](https://www.youtube.com/@vimjoyer)                                                              | Best youtube channel for nixOS content                               |
| Community | [Official forums](https://discourse.nixos.org/)                                                           | ...Official forums. :P                                               |
| Community | [Vimjoyer's discord](https://discord.gg/5afXRWw2bq)                                                        | Best community around                                                |
| Community | [Nix cult discord](https://discord.gg/NBczpfdcD8)                                                          | Really nice community that's more about helping and broader          |


