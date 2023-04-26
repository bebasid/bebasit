<p align="center">
  <img src="[https://user-images.githubusercontent.com/115700386/232264116-5cef4e89-92c9-4548-b392-fc82e02747e3.png](https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/MikroTik_logo.svg/512px-MikroTik_logo.svg.png)" width="600px">
</p>

<h1 align="center">TUTORIAL BYPASS DPI KOMINFO MENGGUNAKAN MIKROTIK</h1>

<p align="center">
  <b><sup>Following this instruction is in your own risk. I'm not responsible for content you are trying to access after following this tutorial or the damage you done during the installation process. Please use it wisely and follow the instruction carefully</sup></b>
</p>

### Langkah-langkah

1. Login ke RouterOS anda dan buka Terminal
2. Jalankan perintah ini:
```
# Script by BebasID Communnity

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
<b>Ganti [INTERFACE WAN ANDA] dengan interface sumber internet anda seperti contoh dibawah ini</b>
```
/ip firewall filter add comment="BebasIT | Bypass DPI" chain=forward src-address-list=blokir_kominfo protocol=tcp in-interface=ether1 tcp-flags=rst,ack action=drop
```

4. Selesai
