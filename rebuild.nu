#!/usr/bin/env nu

def step [label: string] {
    print $"\n(ansi cyan_bold)▶(ansi reset) (ansi white_bold)($label)(ansi reset)"
}

mut timer = []

cd ~/.dotfiles

step "Tangling org files"
$timer ++= [{step: "tangle org files", time: (timeit {
       glob **/*.org | where ($it | path basename) != "README.org" | each { |f| let eval_str = '(org-babel-tangle-file "' + ($f | str trim) + '")'
       emacs --batch -l org --eval $eval_str
       }
})}]

step "Working copy changes"
jj diff --stat

let default_msg = $"NixOS (date now | format date '%Y-%m-%dT%H:%M:%S%z') Build (hostname) (readlink /nix/var/nix/profiles/system | path basename | split row '-' | get 1)"
let user_msg = (input $"(ansi green_bold)Commit message(ansi reset) [($default_msg)]: ")
let commit_msg = if ($user_msg | str trim | is-empty) { $default_msg } else { $"($user_msg)\n($default_msg)" }

step "Rebuilding NixOS"
$timer ++= [{step: "NixOS rebuild", time: (timeit { sudo nixos-rebuild switch --flake $".#(hostname)" })}]

step "Committing"
$timer ++= [{step: "jj commit", time: (timeit {
    jj commit -m $commit_msg
    jj bookmark move main --to @-
})}]

step "Pushing to remote"
$timer ++= [{step: "jj push", time: (timeit { jj git push })}]

step "Summary"
print ($timer | update time { |row| ($row.time / 1ms | math round) * 1ms } | table --theme rounded)
let total = ($timer | get time | math sum)
print $"System rebuilt in: (($total / 1ms | math round) * 1ms)"
