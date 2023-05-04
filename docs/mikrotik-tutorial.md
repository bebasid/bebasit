<p align="center">
  <img src="https://user-images.githubusercontent.com/115700386/234646779-cf6c4264-4e8d-4aba-aa19-40f088b3e825.png" width="300px" height="80px">
</p>

<h1 align="center">TUTORIAL BYPASS DPI KOMINFO MENGGUNAKAN MIKROTIK</h1>

<p align="center">
  <b><sup>Following this instruction is in your own risk. I'm not responsible for content you are trying to access after following this tutorial or the damage you done during the installation process. Please use it wisely and follow the instruction carefully</sup></b><br><br>
  <b>This method doesn't work on Biznet, Telkomsel, Iconnet, HSP-NET (PT Parsaoran Global Datatrans), and XL because how strong their DPI implementation is</b>
</p>

### Langkah-langkah

1. Login ke RouterOS anda dan buka Terminal
2. Jalankan perintah ini untuk membypass DNS Nasional:
```
# Script by BebasID Community

/ip firewall nat add action=dst-nat chain=dstnat comment="DNS BebasID" dst-port=53 protocol=tcp to-addresses=47.254.192.66 to-ports=1753
/ip firewall nat add action=dst-nat chain=dstnat comment="DNS BebasID" dst-port=53 protocol=udp to-addresses=47.254.192.66 to-ports=1753
```
3. Jalankan perintah ini juga:
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

4. Selesai
