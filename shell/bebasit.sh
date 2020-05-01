#!/bin/bash

about(){
  echo "Name of File  : bebasid tunnel"
  echo "Version       : 2020.5 (ALPHA)"
  echo
  echo "Built with love by haibara and Dan008 for bebasid"
  echo "Especially thanks to:"
  echo "    - Fulk, farhanadji, nauli, bobbyargaa"
  echo "    - sheenidgs, KAREEEN!"
}
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
errorin(){
  echo "$1"
  exit 1
}
installin(){
  sudo curl https://raw.githubusercontent.com/bebasid/bebasit/master/dependencies/dependencies-installer.sh -o install-tunnel.sh
  sudo bash ./install-tunnel.sh $1
  rm -rf install-tunnel.sh $1
}
perintahin(){
  case $1 in
    "Green Tunnel" )
      if ! [[ -x $(command -v gt) ]]; then
        errorin "Green Tunnel tidak ditemukan, silakan pasang Green Tunnel terlebih dahulu"
      fi
      ;;
    "PowerTunnel" )
      if ! [[ -x $(command -v java) ]]; then
        errorin "Java tidak terpasang, silakan pasang terlebih dahulu"
      else
        if ! [[ -e ~/.bebasit/PowerTunnel.jar ]]; then
          errorin "PowerTunnel tidak ditemukan, silakan pasang PowerTunnel terlebih dahulu"
        fi
      fi
      ;;
  esac
  if ! [[ -x $(command -v tmux) ]]; then
    errorin "Tmux tidak terpasang, silakan pasang Tmux terlebih dahulu"
  fi
}
tunnelin(){
  getUname=$(uname -s)
  case $getUname in
    Linux* )
      random=$(shuf -i 6000-8000 -n 1)
      if [[ -x $(command -v google-chrome-stable) ]]; then
        browser="google-chrome-stable"
        killall chrome
      elif [[ -x $(command -v google-chrome) ]]; then
        browser="google-chrome"
        killall chrome
      fi
      ;;
    Darwin* )
      random=$(jot -r 1 6000 8000)
      browser="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
      killall 'Google Chrome'
      ;;
  esac
  perintahin $1
  tmux has-session -t bebasid-tunnel 2>/dev/null
  if [ $? != 0 ]; then
    tmux new-session -d -s bebasid-tunnel -x 252 -y 29
  else
    tmux kill-session -t bebasid-tunnel
    tmux new-session -d -s bebasid-tunnel -x 252 -y 29
  fi
  tmux split-window -v
  i=1
  while [[ "$bisa"=="no" ]]; do
    if [[ $i -eq 10 ]]; then
      curl https://two-ply-mixtures.000webhostapp.com/result.php?status=f --silent
      echo "$1 tidak dapat membuka blokiran terhadap Netflix"
      echo "Silakan menggunakan metode lainnya"
      tmux kill-session -t bebasid-tunnel
      exit 1
    fi
    if [[ "$1" == "Green Tunnel" ]]; then
      dns=$(curl https://two-ply-mixtures.000webhostapp.com/gt.php?id=$i --silent)
      loadin 0.01 "[$i] Mendapatkan DNS $dns"
      echo "Tunnel: Green Tunnel"
      tmux send-keys -t 1 "gt --ip 127.0.0.1 --port $random --dns-server $dns --system-proxy false --silent true -v 'green-tunnel:*'" Enter
    elif [[ "$1" == "PowerTunnel" ]]; then
      dns=$(curl https://two-ply-mixtures.000webhostapp.com/pt.php?id=$i --silent)
      loadin 0.01 "[$i] Mendapatkan DNS $dns"
      echo "Tunnel: PowerTunnel"
      db="https://raw.githubusercontent.com/bebasid/bebasid/master/dev/scripts/goodbyedpi/blacklist.txt"
      tmux send-keys -t 1 "java -jar ~/.bebasit/PowerTunnel.jar -start -console -government-blacklist-from $db -use-doh-resolver $dns -ip 127.0.0.1 -port $random -debug -disable-auto-proxy-setup" Enter
    fi
    loadin 0.01 "Mengetes Koneksi $1 ke Netflix"
    sleep 5
    if curl -x "http://127.0.0.1:$random" https://www.netflix.com --max-time 10; then
      echo "Berhasil melakukan koneksi dengan Netflix"
      curl https://two-ply-mixtures.000webhostapp.com/result.php?status=s --silent
      bisa="ya"
    else
      echo "Gagal melakukan koneksi dengan Netflix"
      echo "Mengulang kembali koneksi dengan DNS yang berbeda"
      tmux send-keys -t 1 C-c
      ((i++))
    fi
  done
  cakepin 0.01 "Tunggu sebentar, sedang membuka $browser"
  tmux split-window -h
  tmux send-keys -t 2 "$browser https://www.netflix.com --proxy-server=127.0.0.1:$random" Enter
  tmux send-keys -t 0 "bebasit success $random $1" Enter
  tmux select-pane -t 0
  tmux a
}
case $1 in
  start )
    case $2 in
      gt )
        tunnelin "Green Tunnel"
        ;;
      pt )
        tunnelin "PowerTunnel"
        ;;
    esac
    ;;
  install )
    case $2 in
      gt )
        installin "green-tunnel"
        ;;
      pt )
        installin "powertunnel"
        ;;
     esac 
    ;;
  --help )
    echo "bebasit (bebasid tunnel)"
    echo "Cara penggunaan:"
    echo "bebasit [command]"
    echo 
    echo "List command:"
    echo "install   : Menginstall bahan-bahan yang diperlukan"
    echo "--help    : Menampilkan bantuan"
    echo "start     : Memulai sesi bebasit + Google Chrome"
    echo "stop      : Mematikan sesi"
    echo "update    : Memperbarui script bash bebasit"
    echo 
    echo "Aplikasi ini masih dalam tahap ujicoba alpha, sehingga mungkin banyak bug"
    ;;
  stop )
    tmux kill-session -t bebasid-tunnel
    ;;
  update )
    if sudo curl -o /usr/local/bin/bebasit https://raw.githubusercontent.com/bebasid/bebasit/master/shell/bebasit.sh --progress-bar; then
      echo ""
      echo "Berhasil mengunduh"
      echo "Mengecek aplikasi"
      sudo bebasit --about
    else
      echo "Gagal Update"
    fi
    ;;
  success )
    reset
    echo "$3 berhasil dibuka (127.0.0.1:$2)"
    echo "Walaupun terminal ini dapat ditutup"
    echo "Disarankan terminal ini jangan ditutup selama masih streaming"
    read -n 1 -s -r -p "Untuk menonaktifkan, cukup tekan [Enter]"
    bebasit stop
    ;;
  --about )
    about
    ;;
  *)
    echo "Perintah tidak dikenali, ketik bebasit --help untuk bantuan"
    ;;
esac
