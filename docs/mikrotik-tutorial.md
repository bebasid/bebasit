<p align="center">
  <img src="https://user-images.githubusercontent.com/115700386/234646779-cf6c4264-4e8d-4aba-aa19-40f088b3e825.png" width="300px" height="80px">
</p>

<h1 align="center">TUTORIAL BYPASS DPI KOMINFO MENGGUNAKAN MIKROTIK</h1>

<p align="center">
  <b><sup>Following this instruction is in your own risk. I'm not responsible for content you are trying to access after following this tutorial or the damage you done during the installation process. Please use it wisely and follow the instruction carefully</sup></b><br><br>
  <b>This method doesn't work on Biznet, Telkomsel, Iconnet, and XL because how strong their DPI implementation is</b>
</p>

### Langkah-langkah

1. Login ke RouterOS anda dan buka Terminal
2. Jalankan perintah ini:
```
# Script by BebasID Community

/ip firewall address-list 
add list=blokir_kominfo comment="BebasIT | REDDIT" address=151.101.193.140
add list=blokir_kominfo comment="BebasIT | REDDIT" address=151.101.65.140
add list=blokir_kominfo comment="BebasIT | REDDIT" address=151.101.1.140
add list=blokir_kominfo comment="BebasIT | REDDIT" address=151.101.129.140
add list=blokir_kominfo comment="BebasIT | REDDIT" address=199.232.45.140
add list=blokir_kominfo comment="BebasIT | VIMEO" address=162.159.138.60
add list=blokir_kominfo comment="BebasIT | VIMEO" address=162.159.128.61
```
3. Jalankan perintah ini juga:
```
/ip firewall filter add comment="BebasIT | Bypass DPI" chain=forward src-address-list=blokir_kominfo protocol=tcp in-interface=[INTERFACE WAN ANDA] tcp-flags=rst,ack action=drop
```
<b>Ganti [INTERFACE WAN ANDA] dengan interface sumber internet anda seperti contoh dibawah ini:</b>
```
/ip firewall filter add comment="BebasIT | Bypass DPI" chain=forward src-address-list=blokir_kominfo protocol=tcp in-interface=ether1 tcp-flags=rst,ack action=drop
```

4. Selesai
