#!/usr/bin/env bash

cd $(dirname "$0") &&

printf "== Adding files to git... \n" &&
git add . &&

printf "== Tangling org files... \n" &&
find . -name "*.org" ! -name "README.org" -exec emacs --batch -l org --eval '(org-babel-tangle-file "{}")' \; &&

printf "== Building NixOS... \n" &&
sudo nixos-rebuild switch --flake .#$(hostname) &&

printf "== Commiting to git... \n" &&
DEFAULT_COMMIT_MSG="NixOS $(date -u --iso-8601=seconds) Build $(hostname) $(readlink /nix/var/nix/profiles/system | cut -d- -f2)" &&
read -ep "Commit message ($DEFAULT_COMMIT_MSG): " PROMPT_COMMIT_MSG &&
COMMIT_MSG=$([[ -z "${PROMPT_COMMIT_MSG// /}" ]] && printf "$DEFAULT_COMMIT_MSG" || printf "$PROMPT_COMMIT_MSG\n$DEFAULT_COMMIT_MSG")
git commit -m "$COMMIT_MSG" && 

printf "== Pushing to remote...\n" &&
git push
