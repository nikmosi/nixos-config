function gs --wraps gs

end
if type -q tmux
    function t --wraps sesh
        sesh connect .
    end
end
# docker.fish
if type -q docker
    function dbl --wraps "docker build"
        docker build $argv
    end
    function dcb --wraps "docker-compose build"
        docker-compose build $argv
    end
    function dcdn --wraps "docker-compose down"
        docker-compose down $argv
    end
    function dce --wraps "docker-compose exec"
        docker-compose exec $argv
    end
    function dcin --wraps "docker container inspect"
        docker container inspect $argv
    end
    function dck --wraps "docker compose kill"
        docker compose kill $argv
    end
    function dcl --wraps "docker compose logs"
        docker compose logs $argv
    end
    function dclF --wraps "docker compose logs -f --tail 0"
        docker compose logs -f --tail 0 $argv
    end
    function dclf --wraps "docker compose logs -f"
        docker compose logs -f $argv
    end
    function dcls --wraps "docker container ls"
        docker container ls $argv
    end
    function dclsa --wraps "docker container ls -a"
        docker container ls -a $argv
    end
    function dco --wraps "docker compose"
        docker compose $argv
    end
    function dcps --wraps "docker compose ps"
        docker compose ps $argv
    end
    function dcpull --wraps "docker compose pull"
        docker compose pull $argv
    end
    function dcr --wraps "docker compose run"
        docker compose run $argv
    end
    function dcrestart --wraps "docker compose restart"
        docker compose restart $argv
    end
    function dcrm --wraps "docker compose rm"
        docker compose rm $argv
    end
    function dcstart --wraps "docker compose start"
        docker compose start $argv
    end
    function dcstop --wraps "docker compose stop"
        docker compose stop $argv
    end
    function dcup --wraps "docker compose up"
        docker compose up $argv
    end
    function dcupb --wraps "docker compose up --build"
        docker compose up --build $argv
    end
    function dcupd --wraps "docker compose up -d"
        docker compose up -d $argv
    end
    function dcupdb --wraps "docker compose up -d --build"
        docker compose up -d --build $argv
    end
    function dib --wraps "docker image build"
        docker image build $argv
    end
    function dii --wraps "docker image inspect"
        docker image inspect $argv
    end
    function dils --wraps "docker image ls"
        docker image ls $argv
    end
    function dipu --wraps "docker image push"
        docker image push $argv
    end
    function dirm --wraps "docker image rm"
        docker image rm $argv
    end
    function dit --wraps "docker image tag"
        docker image tag $argv
    end
    function dlo --wraps "docker container logs"
        docker container logs $argv
    end
    function dn --wraps "dotnet new"
        dotnet new $argv
    end
    function dnc --wraps "docker network create"
        docker network create $argv
    end
    function dncn --wraps "docker network connect"
        docker network connect $argv
    end
    function dndcn --wraps "docker network disconnect"
        docker network disconnect $argv
    end
    function dng --wraps "dotnet nuget"
        dotnet nuget $argv
    end
    function dni --wraps "docker network inspect"
        docker network inspect $argv
    end
    function dnls --wraps "docker network ls"
        docker network ls $argv
    end
    function dnrm --wraps "docker network rm"
        docker network rm $argv
    end
    function dp --wraps "dotnet pack"
        dotnet pack $argv
    end
    function dpo --wraps "docker container port"
        docker container port $argv
    end
    function dps --wraps "docker ps"
        docker ps $argv
    end
    function dpsa --wraps "docker ps -a"
        docker ps -a $argv
    end
    function dpu --wraps "docker pull"
        docker pull $argv
    end
    function dr --wraps "docker container run"
        docker container run $argv
    end
    function drit --wraps "docker container run -it"
        docker container run -it $argv
    end
    function drm --wraps "docker container rm"
        docker container rm $argv
    end
    function 'drm!' --wraps "docker container rm -f"
        docker container rm -f $argv
    end
    function drs --wraps "docker container restart"
        docker container restart $argv
    end
    function dst --wraps "docker container start"
        docker container start $argv
    end
    function dsta --wraps "docker stop (docker ps -q)"
        docker stop (docker ps -q) $argv
    end
    function dstp --wraps "docker container stop"
        docker container stop $argv
    end
    function dtop --wraps "docker top"
        docker top $argv
    end
    function dvi --wraps "docker volume inspect"
        docker volume inspect $argv
    end
    function dvls --wraps "docker volume ls"
        docker volume ls $argv
    end
    function dvprune --wraps "docker volume prune"
        docker volume prune $argv
    end
    function dxc --wraps "docker container exec"
        docker container exec $argv
    end
    function dxcit --wraps "docker container exec -it"
        docker container exec -it $argv
    end
end



# exa.fish
if type -q exa
    function tree --wraps "exa --tree"
        exa --tree
    end
    function l --wraps "exa -lhF"
        exa -lhF $argv
    end
    function lS --wraps "exa -1SshF"
        exa -1SshF $argv
    end
    function la --wraps "exa -lAhF"
        exa -lAhF $argv
    end
    function lart --wraps "exa -1cartF"
        exa -1cartF $argv
    end
    function ldot --wraps "exa -ld .*"
        exa -ld .* $argv
    end
    function ll --wraps "exa -l"
        exa -l $argv
    end
    function lr --wraps "exa -tRhF"
        exa -tRhF $argv
    end
    function lrt --wraps "exa -1crtF"
        exa -1crtF $argv
    end
    function ls --wraps "ls --color=tty"
        ls --color=tty $argv
    end
    function lsa --wraps "ls -lah"
        ls -lah $argv
    end
    function lsn --wraps "exa -1"
        exa -1 $argv
    end
    function lsr --wraps "exa -lARhF"
        exa -lARhF $argv
    end
    function lt --wraps "exa -lthF"
        exa -lthF $argv
    end
end



# gh.fish
if type -q gh
    function gh-create
        gh repo create --public --source=. --remote=origin && git push -u --all && gh browse $argv
    end
    function gh-create-private
        gh repo create --private --source=. --remote=origin && git push -u --all && gh browse $argv
    end
end



# git.fish
if type -q git
    function g --wraps git
        git $argv
    end
    function ga --wraps "git add"
        git add $argv
    end
    function gaa --wraps "git add --all"
        git add --all $argv
    end
    function gam --wraps "git am"
        git am $argv
    end
    function gama --wraps "git am --abort"
        git am --abort $argv
    end
    function gamc --wraps "git am --continue"
        git am --continue $argv
    end
    function gams --wraps "git am --skip"
        git am --skip $argv
    end
    function gamscp --wraps "git am --show-current-patch"
        git am --show-current-patch $argv
    end
    function gap --wraps "git apply"
        git apply $argv
    end
    function gapa --wraps "git add --patch"
        git add --patch $argv
    end
    function gapt --wraps "git apply --3way"
        git apply --3way $argv
    end
    function gau --wraps "git add --update"
        git add --update $argv
    end
    function gav --wraps "git add --verbose"
        git add --verbose $argv
    end
    function gb --wraps "git branch"
        git branch $argv
    end
    function gbD --wraps "git branch --delete --force"
        git branch --delete --force $argv
    end
    function gba --wraps "git branch --all"
        git branch --all $argv
    end
    function gbd --wraps "git branch --delete"
        git branch --delete $argv
    end
    function gbl --wraps "git blame -w"
        git blame -w $argv
    end
    function gbm --wraps "git branch --move"
        git branch --move $argv
    end
    function gbnm --wraps "git branch --no-merged"
        git branch --no-merged $argv
    end
    function gbr --wraps "git branch --remote"
        git branch --remote $argv
    end
    function gbs --wraps "git bisect"
        git bisect $argv
    end
    function gbsb --wraps "git bisect bad"
        git bisect bad $argv
    end
    function gbsg --wraps "git bisect good"
        git bisect good $argv
    end
    function gbsn --wraps "git bisect new"
        git bisect new $argv
    end
    function gbso --wraps "git bisect old"
        git bisect old $argv
    end
    function gbsr --wraps "git bisect reset"
        git bisect reset $argv
    end
    function gbss --wraps "git bisect start"
        git bisect start $argv
    end
    function gc --wraps "git commit --verbose"
        git commit --verbose $argv
    end
    function 'gc!' --wraps "git commit --verbose --amend"
        git commit --verbose --amend $argv
    end
    function gcB --wraps "git checkout -B"
        git checkout -B $argv
    end
    function gca --wraps "git commit --verbose --all"
        git commit --verbose --all $argv
    end
    function 'gca!' --wraps "git commit --verbose --all --amend"
        git commit --verbose --all --amend $argv
    end
    function gcam --wraps "git commit --all --message"
        git commit --all --message $argv
    end
    function 'gcan!' --wraps "git commit --verbose --all --no-edit --amend"
        git commit --verbose --all --no-edit --amend $argv
    end
    function 'gcann!' --wraps "git commit --verbose --all --date=now --no-edit --amend"
        git commit --verbose --all --date=now --no-edit --amend $argv
    end
    function 'gcans!' --wraps "git commit --verbose --all --signoff --no-edit --amend"
        git commit --verbose --all --signoff --no-edit --amend $argv
    end
    function gcas --wraps "git commit --all --signoff"
        git commit --all --signoff $argv
    end
    function gcasm --wraps "git commit --all --signoff --message"
        git commit --all --signoff --message $argv
    end
    function gcb --wraps "git checkout -b"
        git checkout -b $argv
    end
    function gcf --wraps "git config --list"
        git config --list $argv
    end
    function gcl --wraps "git clone --recurse-submodules"
        git clone --recurse-submodules $argv
    end
    function gclean --wraps "git clean --interactive -d"
        git clean --interactive -d $argv
    end
    function gcmsg --wraps "git commit --message"
        git commit --message $argv
    end
    function 'gcn!' --wraps "git commit --verbose --no-edit --amend"
        git commit --verbose --no-edit --amend $argv
    end
    function gco --wraps "git checkout"
        git checkout $argv
    end
    function gcor --wraps "git checkout --recurse-submodules"
        git checkout --recurse-submodules $argv
    end
    function gcount --wraps "git shortlog --summary --numbered"
        git shortlog --summary --numbered $argv
    end
    function gcp --wraps "git cherry-pick"
        git cherry-pick $argv
    end
    function gcpa --wraps "git cherry-pick --abort"
        git cherry-pick --abort $argv
    end
    function gcpc --wraps "git cherry-pick --continue"
        git cherry-pick --continue $argv
    end
    function gcs --wraps "git commit --gpg-sign"
        git commit --gpg-sign $argv
    end
    function gcsm --wraps "git commit --signoff --message"
        git commit --signoff --message $argv
    end
    function gcss --wraps "git commit --gpg-sign --signoff"
        git commit --gpg-sign --signoff $argv
    end
    function gcssm --wraps "git commit --gpg-sign --signoff --message"
        git commit --gpg-sign --signoff --message $argv
    end
    function gd --wraps "git diff"
        git diff $argv
    end
    function gdca --wraps "git diff --cached"
        git diff --cached $argv
    end
    function gdct --wraps "git describe --tags (git rev-list --tags --max-count=1)"
        git describe --tags (git rev-list --tags --max-count=1) $argv
    end
    function gdcw --wraps "git diff --cached --word-diff"
        git diff --cached --word-diff $argv
    end
    function gds --wraps "git diff --staged"
        git diff --staged $argv
    end
    function gdt --wraps "git diff-tree --no-commit-id --name-only -r"
        git diff-tree --no-commit-id --name-only -r $argv
    end
    function gdup --wraps "git diff @{upstream}"
        git diff @{upstream} $argv
    end
    function gdw --wraps "git diff --word-diff"
        git diff --word-diff $argv
    end
    function gf --wraps "git fetch"
        git fetch $argv
    end
    function gfa --wraps "git fetch --all --prune --jobs=10"
        git fetch --all --prune --jobs=10 $argv
    end
    function gfg --wraps "git ls-files | grep"
        git ls-files | grep $argv
    end
    function gfo --wraps "git fetch origin"
        git fetch origin $argv
    end
    function gg --wraps "git gui citool"
        git gui citool $argv
    end
    function gga --wraps "git gui citool --amend"
        git gui citool --amend $argv
    end
    function ggpull --wraps "git pull origin"
        git pull origin "(git branch --show-current)" $argv
    end
    function ggpur --wraps ggu
        ggu $argv
    end
    function ggpush --wraps "git push origin"
        git push origin "(git branch --show-current)" $argv
    end
    function ggsup --wraps "git branch --set-upstream-to=origin/(git branch --show-current)"
        git branch --set-upstream-to=origin/(git branch --show-current) $argv
    end
    function ghh --wraps "git help"
        git help $argv
    end
    function gi --wraps git-ignore
        git-ignore $argv
    end
    function gignore --wraps "git update-index --assume-unchanged"
        git update-index --assume-unchanged $argv
    end
    function gignored --wraps "git ls-files -v | rg "
        git ls-files -v | rg "^[[:lower:]]" $argv
    end
    function gl --wraps "git pull"
        git pull $argv
    end
    function glg --wraps "git log --stat"
        git log --stat $argv
    end
    function glgg --wraps "git log --graph"
        git log --graph $argv
    end
    function glgga --wraps "git log --graph --decorate --all"
        git log --graph --decorate --all $argv
    end
    function glgm --wraps "git log --graph --max-count=10"
        git log --graph --max-count=10 $argv
    end
    function glgp --wraps "git log --stat --patch"
        git log --stat --patch $argv
    end
    function glo --wraps "git log --oneline --decorate"
        git log --oneline --decorate $argv
    end
    function globurl --wraps "noglob urlglobber"
        noglob urlglobber $argv
    end
    function glod --wraps "git log --graph"
        git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" $argv
    end
    function glods --wraps "git log --graph  --date=short"
        git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short $argv
    end
    function glog --wraps "git log --oneline --decorate --graph"
        git log --oneline --decorate --graph $argv
    end
    function gloga --wraps "git log --oneline --decorate --graph --all"
        git log --oneline --decorate --graph --all $argv
    end
    function glol --wraps "git log --graph"
        git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" $argv
    end
    function glola --wraps "git log --graph  --all"
        git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all $argv
    end
    function glols --wraps "git log --graph --stat"
        git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat $argv
    end
    function glp --wraps _git_log_prettily
        _git_log_prettily $argv
    end
    function gluc --wraps "git pull upstream (git branch --show-current)"
        git pull upstream (git branch --show-current) $argv
    end
    function gm --wraps "git merge"
        git merge $argv
    end
    function gma --wraps "git merge --abort"
        git merge --abort $argv
    end
    function gmc --wraps "git merge --continue"
        git merge --continue $argv
    end
    function gms --wraps "git merge --squash"
        git merge --squash $argv
    end
    function gmtl --wraps "git mergetool --no-prompt"
        git mergetool --no-prompt $argv
    end
    function gmtlvim --wraps "git mergetool --no-prompt --tool=vimdiff"
        git mergetool --no-prompt --tool=vimdiff $argv
    end
    function gp --wraps "git push"
        git push $argv
    end
    function gpd --wraps "git push --dry-run"
        git push --dry-run $argv
    end
    function gpf --wraps "git push --force-with-lease --force-if-includes"
        git push --force-with-lease --force-if-includes $argv
    end
    function 'gpf!' --wraps "git push --force"
        git push --force $argv
    end
    function gpoat --wraps "git push origin --all && git push origin --tags"
        git push origin --all && git push origin --tags $argv
    end
    function gpod --wraps "git push origin --delete"
        git push origin --delete $argv
    end
    function gpr --wraps "git pull --rebase"
        git pull --rebase $argv
    end
    function gpra --wraps "git pull --rebase --autostash"
        git pull --rebase --autostash $argv
    end
    function gprav --wraps "git pull --rebase --autostash -v"
        git pull --rebase --autostash -v $argv
    end
    function gpristine --wraps "git reset --hard && git clean --force -dfx"
        git reset --hard && git clean --force -dfx $argv
    end
    function gprv --wraps "git pull --rebase -v"
        git pull --rebase -v $argv
    end
    function gpsup --wraps "git push --set-upstream origin (git branch --show-current)"
        git push --set-upstream origin (git branch --show-current) $argv
    end
    function gpsupf --wraps "git push --set-upstream origin (git branch --show-current) --force-with-lease --force-if-includes"
        git push --set-upstream origin (git branch --show-current) --force-with-lease --force-if-includes $argv
    end
    function gpu --wraps "git push upstream"
        git push upstream $argv
    end
    function gpv --wraps "git push --verbose"
        git push --verbose $argv
    end
    function gr --wraps "git remote"
        git remote $argv
    end
    function gra --wraps "git remote add"
        git remote add $argv
    end
    function grb --wraps "git rebase"
        git rebase $argv
    end
    function grba --wraps "git rebase --abort"
        git rebase --abort $argv
    end
    function grbc --wraps "git rebase --continue"
        git rebase --continue $argv
    end
    function grbi --wraps "git rebase --interactive"
        git rebase --interactive $argv
    end
    function grbo --wraps "git rebase --onto"
        git rebase --onto $argv
    end
    function grbs --wraps "git rebase --skip"
        git rebase --skip $argv
    end
    function grep --wraps rg
        rg $argv
    end
    function grev --wraps "git revert"
        git revert $argv
    end
    function greva --wraps "git revert --abort"
        git revert --abort $argv
    end
    function grevc --wraps "git revert --continue"
        git revert --continue $argv
    end
    function grf --wraps "git reflog"
        git reflog $argv
    end
    function grh --wraps "git reset"
        git reset $argv
    end
    function grhh --wraps "git reset --hard"
        git reset --hard $argv
    end
    function grhk --wraps "git reset --keep"
        git reset --keep $argv
    end
    function grhs --wraps "git reset --soft"
        git reset --soft $argv
    end
    function grm --wraps "git rm"
        git rm $argv
    end
    function grmc --wraps "git rm --cached"
        git rm --cached $argv
    end
    function grmv --wraps "git remote rename"
        git remote rename $argv
    end
    function groh --wraps "git reset origin/(git branch --show-current) --hard"
        git reset origin/(git branch --show-current) --hard $argv
    end
    function grrm --wraps "git remote remove"
        git remote remove $argv
    end
    function grs --wraps "git restore"
        git restore $argv
    end
    function grset --wraps "git remote set-url"
        git remote set-url $argv
    end
    function grss --wraps "git restore --source"
        git restore --source $argv
    end
    function grst --wraps "git restore --staged"
        git restore --staged $argv
    end
    function grt
        cd (git rev-parse --show-toplevel || echo .)
    end
    function gru --wraps "git reset --"
        git reset -- $argv
    end
    function grup --wraps "git remote update"
        git remote update $argv
    end
    function grv --wraps "git remote --verbose"
        git remote --verbose $argv
    end
    function gsb --wraps "git status --short --branch"
        git status --short --branch $argv
    end
    function gsd --wraps "git svn dcommit"
        git svn dcommit $argv
    end
    function gsh --wraps "git show"
        git show $argv
    end
    function gsi --wraps "git submodule init"
        git submodule init $argv
    end
    function gsps --wraps "git show --pretty=short --show-signature"
        git show --pretty=short --show-signature $argv
    end
    function gsr --wraps "git svn rebase"
        git svn rebase $argv
    end
    function gss --wraps "git status --short"
        git status --short $argv
    end
    function gst --wraps "git status"
        git status $argv
    end
    function gsta --wraps "git stash push"
        git stash push $argv
    end
    function gstaa --wraps "git stash apply"
        git stash apply $argv
    end
    function gstall --wraps "git stash --all"
        git stash --all $argv
    end
    function gstc --wraps "git stash clear"
        git stash clear $argv
    end
    function gstd --wraps "git stash drop"
        git stash drop $argv
    end
    function gstl --wraps "git stash list"
        git stash list $argv
    end
    function gstp --wraps "git stash pop"
        git stash pop $argv
    end
    function gsts --wraps "git stash show --patch"
        git stash show --patch $argv
    end
    function gstu --wraps "gsta --include-untracked"
        gsta --include-untracked $argv
    end
    function gsu --wraps "git submodule update"
        git submodule update $argv
    end
    function gsw --wraps "git switch"
        git switch $argv
    end
    function gswc --wraps "git switch --create"
        git switch --create $argv
    end
    function gta --wraps "git tag --annotate"
        git tag --annotate $argv
    end
    function gtas --wraps "git tag --annotate --sign"
        git tag --annotate --sign $argv
    end
    function gtl --description 'List git tags sorted by version' --wraps "git tag --sort=-v:refname -n --list "
        git tag --sort=-v:refname -n --list $argv
    end
    function gts --wraps "git tag --sign"
        git tag --sign $argv
    end
    function gtv --wraps "git tag | sort -V"
        git tag | sort -V $argv
    end
    function gunignore --wraps "git update-index --no-assume-unchanged"
        git update-index --no-assume-unchanged $argv
    end
    function gunwip
        git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1 $argv
    end
    function gwch --wraps "git whatchanged -p --abbrev-commit --pretty=medium"
        git whatchanged -p --abbrev-commit --pretty=medium $argv
    end
    function gwipe --wraps "git reset --hard && git clean --force -df"
        git reset --hard && git clean --force -df $argv
    end
    function gwt --wraps "git worktree"
        git worktree $argv
    end
    function gwta --wraps "git worktree add"
        git worktree add $argv
    end
    function gwtls --wraps "git worktree list"
        git worktree list $argv
    end
    function gwtmv --wraps "git worktree move"
        git worktree move $argv
    end
    function gwtrm --wraps "git worktree remove"
        git worktree remove $argv
    end
end



# pacman.fish
if type -q pacman
    function pacfiles --wraps "pacman -F"
        pacman -F $argv
    end
    function pacfileupg --wraps "sudo pacman -Fy"
        sudo pacman -Fy $argv
    end
    function pacin --wraps "sudo pacman -S"
        sudo pacman -S $argv
    end
    function pacins --wraps "sudo pacman -U"
        sudo pacman -U $argv
    end
    function pacinsd --wraps "sudo pacman -S --asdeps"
        sudo pacman -S --asdeps $argv
    end
    function paclean --wraps "sudo pacman -Sc"
        sudo pacman -Sc $argv
    end
    function pacloc --wraps "pacman -Qi"
        pacman -Qi $argv
    end
    function paclocs --wraps "pacman -Qs"
        pacman -Qs $argv
    end
    function paclr --wraps "sudo pacman -Scc"
        sudo pacman -Scc $argv
    end
    function pacls --wraps "pacman -Ql"
        pacman -Ql $argv
    end
    function paclsorphans --wraps "sudo pacman -Qdt"
        sudo pacman -Qdt $argv
    end
    function pacmanallkeys --wraps "sudo pacman-key --refresh-keys"
        sudo pacman-key --refresh-keys $argv
    end
    function pacmir --wraps "sudo pacman -Syy"
        sudo pacman -Syy $argv
    end
    function pacown --wraps "pacman -Qo"
        pacman -Qo $argv
    end
    function pacre --wraps "sudo pacman -R"
        sudo pacman -R $argv
    end
    function pacrem --wraps "sudo pacman -Rns"
        sudo pacman -Rns $argv
    end
    function pacrep --wraps "pacman -Si"
        pacman -Si $argv
    end
    function pacreps --wraps "pacman -Ss"
        pacman -Ss $argv
    end
    function pacrmorphans --wraps "sudo pacman -Rs (pacman -Qtdq)"
        sudo pacman -Rs (pacman -Qtdq) $argv
    end
    function pacupd --wraps "sudo pacman -Sy"
        sudo pacman -Sy $argv
    end
    function pacupg --wraps "sudo pacman -Syu"
        sudo pacman -Syu $argv
    end
end



# pre_commit.fish
if type -q pre-commit
    function prc --wraps pre-commit
        pre-commit $argv
    end
    function prcau --wraps "pre-commit autoupdate"
        pre-commit autoupdate $argv
    end
    function prcr --wraps "pre-commit run"
        pre-commit run $argv
    end
    function prcra --wraps "pre-commit run --all-files"
        pre-commit run --all-files $argv
    end
    function prcrf --wraps "pre-commit run --files"
        pre-commit run --files $argv
    end
end



# rsync.fish
if type -q rsync
    function rsync-copy --wraps "rsync -avz --progress -h"
        rsync -avz --progress -h $argv
    end
    function rsync-move --wraps "rsync -avz --progress -h --remove-source-files"
        rsync -avz --progress -h --remove-source-files $argv
    end
    function rsync-synchronize --wraps "rsync -avzu --delete --progress -h"
        rsync -avzu --delete --progress -h $argv
    end
    function rsync-update --wraps "rsync -avzu --progress -h"
        rsync -avzu --progress -h $argv
    end
end



# yay.fish
if type -q yay
    function yaclean --wraps "yay -Sc"
        yay -Sc $argv
    end
    function yaclr --wraps "yay -Scc"
        yay -Scc $argv
    end
    function yaconf --wraps "yay -Pg"
        yay -Pg $argv
    end
    function yain --wraps "yay -S"
        yay -S $argv
    end
    function yains --wraps "yay -U"
        yay -U $argv
    end
    function yainsd --wraps "yay -S --asdeps"
        yay -S --asdeps $argv
    end
    function yaloc --wraps "yay -Qi"
        yay -Qi $argv
    end
    function yalocs --wraps "yay -Qs"
        yay -Qs $argv
    end
    function yalst --wraps "yay -Qe"
        yay -Qe $argv
    end
    function yamir --wraps "yay -Syy"
        yay -Syy $argv
    end
    function yaorph --wraps "yay -Qtd"
        yay -Qtd $argv
    end
    function yare --wraps "yay -R"
        yay -R $argv
    end
    function yarem --wraps "yay -Rns"
        yay -Rns $argv
    end
    function yarep --wraps "yay -Si"
        yay -Si $argv
    end
    function yareps --wraps "yay -Ss"
        yay -Ss $argv
    end
    function yasu --wraps "yay -Syu --noconfirm"
        yay -Syu --noconfirm $argv
    end
    function yaupd --wraps "yay -Sy"
        yay -Sy $argv
    end
    function yaupg --wraps "yay -Syu"
        yay -Syu $argv
    end
end
