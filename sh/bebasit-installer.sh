#!/bin/bash

# bebasit (bebasid tunnel) dependencies script installer
# to install powertunnel or spoof-dpi
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
install_tunnel(){
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
        echo "Install NPM dan Green-Tunnel secara manual"
        exit 1
      fi
      case $OS in
        "debian")
          if ! [[ -x $(command -v tmux) ]]; then
            sudo apt -y update && sudo apt -y install curl tmux
          fi
          case $1 in
            "PowerTunnel" )
              mkdir ~/.bebasit
              if curl -L -o ~/.bebasit/PowerTunnel.jar https://raw.githubusercontent.com/bebasid/bebasit/master/dependencies/PowerTunnel.jar; then
                echo "Sukses memasang PowerTunnel"
              else
                echo "Tidak dapat mengambil file PowerTunnel"
                exit 1
              fi
              ;;
            "Spoof DPI" )
              mkdir ~/.bebasit
              if curl -L -o ~/.bebasit/spoof-dpi https://raw.githubusercontent.com/bebasid/bebasit/master/dependencies/spoofdpi/linux/spoof-dpi; then
                echo "Sukses memasang Spoof DPI"
              else
                echo "Tidak dapat mengambil file Spoof DPI"
                exit 1
              fi
              ;;
          esac
          ;;
        "arch")
          sudo pacman -Syy
          sudo pacman -S tmux curl
          case $1 in
            "PowerTunnel" )
              sudo pacman -S jre-openjdk
              mkdir ~/.bebasit
              if curl -L -o ~/.bebasit/PowerTunnel.jar https://raw.githubusercontent.com/bebasid/bebasit/master/dependencies/PowerTunnel.jar; then
                echo "Sukses memasang PowerTunnel"
              else
                echo "Tidak dapat mengambil file PowerTunnel"
                exit 1
              fi
              ;;
            "Spoof DPI" )
              mkdir ~/.bebasit
              if curl -L -o ~/.bebasit/spoof-dpi https://raw.githubusercontent.com/bebasid/bebasit/master/dependencies/spoofdpi/linux/spoof-dpi; then
                echo "Sukses memasang Spoof DPI"
              else
                echo "Tidak dapat mengambil file Spoof DPI"
                exit 1
              fi
              ;;
          esac
          ;;
        esac
      ;;
    Darwin* )
      echo "Script ini hanya work untuk MacOS High Sierra hingga yang terbaru"
      echo "App: Homebrew, tmux, cURL, Java (PowerTunnel) / Spoof DPI"
      echo "Tunnel yang akan dipasang : $1"
      read -p "Apakah anda yakin ingin melanjutkan pemasangan (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
      if ! [[ -x $(command -v brew) ]]; then
        loadin 0.01 "Memulai pemasangan Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
      elif ! [[ -x $(command -v tmux) ]]; then
        loadin 0.01 "Memulai pemasangan tmux"
        brew install tmux
      fi
      case $1 in
        "PowerTunnel" )
          #if ! [[ -x $(command -v java) ]]; then
            brew tap caskroom/cask
            brew tap caskroom/versions
            brew cask install java
          if ! [[ -e ~/.bebasit/PowerTunnel.jar ]]; then
            mkdir .bebasit
            if curl -L -o ~/.bebasit/PowerTunnel.jar https://raw.githubusercontent.com/bebasid/bebasit/master/dependencies/PowerTunnel.jar; then
              echo "Sukses memasang PowerTunnel"
            else
              echo "Tidak dapat mengambil file PowerTunnel"
              exit 1
            fi
          fi
          ;;
        "Spoof DPI" )
          mkdir ~/.bebasit
          if curl -L -o ~/.bebasit/spoof-dpi https://raw.githubusercontent.com/bebasid/bebasit/master/dependencies/spoofdpi/darwin/spoof-dpi; then
            chmod +x ~/.bebasit/spoof-dpi
            echo "Sukses memasang Spoof DPI"
          else
            echo "Tidak dapat mengambil file Spoof DPI"
            exit 1
          fi
          ;;
      esac
      ;;
  esac
}
case $1 in
  "powertunnel" )
    install_tunnel "PowerTunnel"
    exit 1
    ;;
  "spoof-dpi" )
    install_tunnel "Spoof DPI"
    exit 1
    ;;
esac
