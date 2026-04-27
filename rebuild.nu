#!/usr/bin/env nu

mut timer = []

cd ~/.dotfiles

print "/---- Adding files to git ----/ \n"
$timer ++= [{step: "git add", time: (timeit { git add . })}]
print "/---- Files added ----/ \n"

print "/---- Tangling org files ----/ \n"
$timer ++= [{step: "tangle org files", time: (timeit {
       glob **/*.org | where ($it | path basename) != "README.org" | each { |f| let eval_str = '(org-babel-tangle-file "' + ($f | str trim) + '")'
       emacs --batch -l org --eval $eval_str
       }
})}]
print "/---- Tangle done ----/ \n"

print "/---- Rebuilding NixOS ----/ \n"
$timer ++= [{step:"NixOS rebuild", time: (timeit { sudo nixos-rebuild switch --flake $".#(hostname)" })}]
print "/---- NixOS rebuilt ----/ \n"

print "/---- Committing to git ----/ \n"
let default_msg = $"NixOS (date now | format date '%Y-%m-%dT%H:%M:%S%z') Build (hostname) (readlink /nix/var/nix/profiles/system | path basename | split row '-' | get 1)"
let user_msg = (input $"Commit message \(($default_msg)\): ")
let commit_msg = if ($user_msg | str trim | is-empty) { $default_msg } else { $"($user_msg)\n($default_msg)" }
$timer ++= [{step: "Git commit", time: (timeit { git commit -m $commit_msg })}]
print "/---- Changes commited to git ----/ \n"

print "/---- Pushing to remote ----/ \n"
$timer ++= [{step: "Git push", time: (timeit { git push })}]
print "/---- Pushed to remote ----/ \n"

print "/---- Summary ----/ \n"
print ($timer | update time { |row| ($row.time / 1ms | math round) * 1ms } | table)
let total = ($timer | get time | math sum)
print $"System rebuilt in: (($total / 1ms | math round) * 1ms)"
