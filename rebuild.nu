#!/usr/bin/env nu

def step [label: string] {
    print $"\n(ansi cyan_bold)▶(ansi reset) (ansi white_bold)($label)(ansi reset)"
}

def tangle-all [] {
    glob ~/.dotfiles/**/*.org
    | where ($it | path basename) != "README.org"
    | each { |f|
        let eval_str = '(org-babel-tangle-file "' + ($f | str trim) + '")'
        emacs --batch -l org --eval $eval_str
    }
}

def get-commit-msg [default: string] {
    let user_msg = (input $"(ansi green_bold)Commit message(ansi reset) [($default)]: ")
    if ($user_msg | str trim | is-empty) { $default } else { $"($user_msg)\n($default)" }
}

def "deploy theseus" [] {
    cd ~/.dotfiles
    mut timer = []

    step "Tangling org files"
    $timer ++= [{step: "tangle org files", time: (timeit { tangle-all })}]

    step "Working copy changes"
    jj diff --stat

    let commit_msg = get-commit-msg $"NixOS (date now | format date '%Y-%m-%dT%H:%M:%S%z') Build (hostname) (readlink /nix/var/nix/profiles/system | path basename | split row '-' | get 1)"

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
}

def "deploy zeno" [] {
    cd ~/.dotfiles

    step "Working copy changes"
    jj diff --stat

    let commit_msg = get-commit-msg $"NixOS (date now | format date '%Y-%m-%dT%H:%M:%S%z') Deploy zeno"

    step "Tangling org files"
    tangle-all

    step "Committing"
    jj commit -m $commit_msg
    jj bookmark move main --to @-
    jj git push

    step "Deploying to Zeno"
    nixos-rebuild switch --flake path:/home/ghil/.dotfiles#zeno --target-host ghil@100.106.158.125 --sudo
}
