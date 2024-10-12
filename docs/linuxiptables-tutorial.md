<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/a/af/Tux.png" width="192">
</p>
<h1 align="center">TUTORIAL BYPASS DPI KOMINFO MENGGUNAKAN LINUX IPTABLES</h1>

<p align="center">
    <b>Indonesia</b> | <a href="linuxiptables-tutorial.en.md">English</a>
</p>

<p align="center">
  <b><sup>FMengikuti instruksi ini merupakan risiko anda sendiri. Kami tidak bertanggung jawab atas konten yang anda coba akses setelah mengikuti tutorial ini atau kerusakan yang anda lakukan selama proses instalasi. Harap gunakan dengan bijak dan ikuti instruksi dengan seksama.</sup></b><br><br>
</p>

### Langkah-langkah
Buka Terminal.

**(Masukkan script ini, salin dan tempel)**

```bash
# Script by BebasID Community

sudo iptables -A FORWARD -p tcp -i [INTERFACE SUMBER JARINGAN INTERNET ANDA] -m string --string "Location: http://lamanlabuh.aduankonten.id/" --algo bm -j DROP
sudo iptables -A INPUT -p tcp -i [INTERFACE SUMBER JARINGAN INTERNET ANDA] -m string --string "Location: http://lamanlabuh.aduankonten.id" --algo bm -j DROP
sudo iptables -A FORWARD  -p tcp -i [INTERFACE SUMBER JARINGAN INTERNET ANDA] -m string --string "Location: http://lamanlabuh.aduankonten.id" --algo bm -j DROP
sudo iptables -I INPUT -p tcp -i [INTERFACE SUMBER JARINGAN INTERNET ANDA] --tcp-flags ALL RST,ACK -j DROP
```

Jangan lupa untuk menyimpan aturan (rule) iptables secara permanen supaya tidak akan hilang saat melakukan restart atau mematikan (shutdown) komputernya.

<a href="https://musaamin.web.id/linux-cara-mengetahui-nama-interface-jaringan/#:~:text=Dengan%20perintah-,ifconfig,-1">Cara mengetahui nama interface jaringan internet anda.</a>

<a href="https://www.cyberciti.biz/faq/how-to-save-iptables-firewall-rules-permanently-on-linux/#:~:text=Saving%20iptables%20firewall%20rules%20permanently%20on%20Linux">Cara menyimpan aturan (rule) iptables anda.</a>

<br>
Selesai dan selamat mencoba!
