<p align="center">
  <img src="https://user-images.githubusercontent.com/115700386/234646779-cf6c4264-4e8d-4aba-aa19-40f088b3e825.png#gh-white-mode-only" width="300px" height="80px">
  <img src="https://github.com/bebasid/bebasit/assets/115700386/2a92dfdf-479e-47bc-a063-3e5b61fed001#gh-dark-mode-only" width="300px" height="80px">
</p>

<h1 align="center">TUTORIAL BYPASS DPI KOMINFO MENGGUNAKAN MIKROTIK</h1>

<p align="center">
    <b>Indonesia</b> | <a href="mikrotik-tutorial.en.md">English</a>
</p>

<p align="center">
  <b><sup>Following this instruction is in your own risk. I'm not responsible for content you are trying to access after following this tutorial or the damage you done during the installation process. Please use it wisely and follow the instruction carefully</sup></b><br><br>
</p>

### Langkah-langkah

1. Login ke RouterOS anda dan buka Terminal
2. Jalankan perintah ini untuk membypass DNS Nasional:
**(Pilih salah satu)**

**[ BLOKIR IKLAN ]**
```
# Script by BebasID Community

/ip firewall nat add action=dst-nat chain=dstnat comment="DNS BebasID" dst-port=53 protocol=tcp to-addresses=103.87.68.194 to-ports=1753
/ip firewall nat add action=dst-nat chain=dstnat comment="DNS BebasID" dst-port=53 protocol=udp to-addresses=103.87.68.194 to-ports=1753
```
<br>

**[ BLOKIR VIRUS ]**
```
# Script by BebasID Community

/ip firewall nat add action=dst-nat chain=dstnat comment="DNS BebasID" dst-port=53 protocol=tcp to-addresses=103.87.68.195 to-ports=1753
/ip firewall nat add action=dst-nat chain=dstnat comment="DNS BebasID" dst-port=53 protocol=udp to-addresses=103.87.68.195 to-ports=1753
```

**[ BLOKIR VIRUS, KONTEN DEWASA & JUDI ]**
```
# Script by BebasID Community

/ip firewall nat add action=dst-nat chain=dstnat comment="DNS BebasID" dst-port=53 protocol=tcp to-addresses=103.87.68.196 to-ports=1753
/ip firewall nat add action=dst-nat chain=dstnat comment="DNS BebasID" dst-port=53 protocol=udp to-addresses=103.87.68.196 to-ports=1753
```

3. Jalankan perintah ini juga untuk membypass DPI Kominfo:
```
# Script by BebasID Community

/ip firewall filter add comment="BebasIT | Bypass DPI" chain=forward protocol=tcp in-interface=[INTERFACE WAN ANDA] content="Location: http://lamanlabuh.aduankonten.id/" action=drop
/ip firewall filter add comment="BebasIT | Bypass DPI" chain=forward protocol=tcp in-interface=[INTERFACE WAN ANDA] tcp-flags=rst,ack action=drop
```
<b>Ganti [INTERFACE WAN ANDA] dengan interface sumber internet anda seperti contoh dibawah ini:</b>
```
# Script by BebasID Community

/ip firewall filter add comment="BebasIT | Bypass DPI" chain=forward protocol=tcp in-interface=ether1 content="Location: http://lamanlabuh.aduankonten.id/" action=drop
/ip firewall filter add comment="BebasIT | Bypass DPI" chain=forward protocol=tcp in-interface=ether1 tcp-flags=rst,ack action=drop
```
<br>

**UNTUK PENGGUNA INDOSAT, SILAHKAN TAMBAHKAN RULE INI DIKARENAKAN INDOSAT MENGIRIM REQUEST SELAIN LAMANLABUH UNTUK PEMBLOKIRAN HTTP**
```
# Script by BebasID Community

/ip firewall filter add comment="BebasIT | Bypass DPI" chain=forward protocol=tcp in-interface=[INTERFACE WAN ANDA] content="Location: http://ads.indosatooredoo.com/ads-request" action=drop
```

**UNTUK PENGGUNA MYREPUBLIC, SILAHKAN TAMBAHKAN RULE INI DIKARENAKAN MYREPUBLIC TERKADANG MENGIRIM REQUEST SELAIN LAMANLABUH UNTUK PEMBLOKIRAN HTTP**
```
# Script by BebasID Community

/ip firewall filter add comment="BebasIT | Bypass DPI" chain=forward protocol=tcp in-interface=[INTERFACE WAN ANDA] content="Location: https://block.myrepublic.co.id" action=drop
```

4. Selesai dan coba!
