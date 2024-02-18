#!/bin/bash

# bebasit (bebasid tunnel) dependencies script uninstaller
# to uninstall powertunnel and spoof-dpi
# for Debian, Arch, or Darwin system
# haibara

loadin(){
  for (( pLoad = 0; pLoad < 101; pLoad++ )); do
    echo -ne "\\r"
    sleep $1
    if [[ $pLoad = 100 ]]; then
      echo -ne "$2    "
    else
      echo -ne "$2 $pLoad%"
    fi
  done
  echo
}
confirm(){
  [[ $1 ]] && read -p "Apakah anda yakin ingin mencopot $2 (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] && loadin 0.01 "Memulai pencopotan $2" && $3 || $4
}
uninstall_tunnel(){
  getUname=$(uname -s)
  case $getUname in
    Linux* )
      if [[ -e /etc/debian_version ]]; then
        OS=debian
      elif [[ -e /etc/arch-release ]]; then
        OS=arch
      else
        echo ""
        echo "Belum mendukung distro selain Debian dan Arch (dan Turunannya)"
        echo "Uninstall NPM dan Green-Tunnel secara manual"
        exit 1
      fi
      case $OS in
        "debian")
          confirm "-x $(command -v tmux)" "Tmux" "sudo apt -y remove tmux"
          case $1 in
            "Green Tunnel" )
              confirm "-x $(command -v gt)" "Green Tunnel" "npm un -g gt"
              sudo rm -rf /usr/bin/gt
              ;;
            "PowerTunnel" )
              confirm "-e ~/.bebasit/PowerTunnel.jar" "PowerTunnel" "rm -rf ~/.bebasit/PowerTunnel.jar"
              ;;
            "Spoof DPI")
              confirm "-e ~/.bebasit/spoof-dpi" "Spoof DPI" "rm -rf ~/.bebasit/spoof-dpi"
              ;;
          esac
          ;;
        "arch")
          confirm "-e $(command -v tmux)" "Tmux" "sudo pacman -R tmux --noconfirm"
          case $1 in
            "Green Tunnel" )
              confirm "-e $(command -v gt)" "Green Tunnel" "npm un -g gt"
              sudo rm -rf /usr/bin/gt
              ;;
            "PowerTunnel" )
              confirm "-e ~/.bebasit/PowerTunnel.jar" "PowerTunnel" "rm -rf ~/.bebasit/PowerTunnel.jar"
              confirm "-x $(command -v java)" "Java" "sudo pacman -R jre-openjdk --noconfirm"
              ;;
            "Spoof DPI")
              confirm "-e ~/.bebasit/spoof-dpi" "Spoof DPI" "rm -rf ~/.bebasit/spoof-dpi"
              ;;
          esac
          ;;
        esac
      ;;
    Darwin* )
      echo "Script ini hanya work untuk MacOS High Sierra hingga yang terbaru"
      echo "Akan mencopot : $1, Tmux, dan Java (untuk PowerTunnel)"
      echo "Tunnel yang akan dipasang : $1"
      read -p "Apakah anda yakin ingin melanjutkan pencopotan (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
      case $1 in
        "Green Tunnel" )
          confirm "-x $(command -v gt)" "Green Tunnel" "npm un -g gt"
          sudo rm -rf /usr/bin/gt
          ;;
        "PowerTunnel" )
          confirm "-e ~/.bebasit/PowerTunnel.jar" "PowerTunnel" "rm -rf ~/.bebasit/PowerTunnel.jar"
          confirm "-x $(command -v java)" "Java" "brew uninstall java"
          ;;
        "Spoof DPI")
          confirm "-e ~/.bebasit/spoof-dpi" "Spoof DPI" "rm -rf ~/.bebasit/spoof-dpi"
          ;;
      esac
      ;;
  esac
}
case $1 in
  "powertunnel" )
    uninstall_tunnel "PowerTunnel"
    exit 1
    ;;
  "spoof-dpi" )
    uninstall_tunnel "Spoof DPI"
    exit 1
    ;;
esac
