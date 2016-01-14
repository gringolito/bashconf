alias gitm='git checkout master'
alias gitb='git checkout futzig'
alias gitmm='git merge master'
alias gitmb='git merge futzig'
alias android-connect="jmtpfs -o allow_other ~/Android"
alias android-disconnect="fusermount -u ~/Android"
alias ..='cd ..'
alias myip='curl http://tnx.nl/ip && echo'
alias set_debug='source ~/Tools/debug.source'
alias set_release='source ~/Tools/release.source'
alias please='sudo'
alias apt-get='sudo apt-get'
alias hibernate='sudo test -z && mate-screensaver-command --lock && sudo pm-hibernate'
alias upgrade='sudo apt-get update && sudo apt-get dist-upgrade'
alias jessie='sudo chroot /srv/chroot/jessie /bin/su -l futzig'
alias armhf='sudo chroot /srv/chroot/armhf-build /bin/su -l futzig'
alias config-local='cp -f ~/Config/Config_local .'
alias install-autohells='cp -rf $HOME/Projects/buildroot/autohells/* tools/'
alias setup-buildroot='install-autohells && config-local'
alias home-proxy='ssh -D 8080 brewdog'
