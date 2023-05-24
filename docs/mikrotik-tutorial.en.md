<p align="center">
  <img src="https://user-images.githubusercontent.com/115700386/234646779-cf6c4264-4e8d-4aba-aa19-40f088b3e825.png" width="300px" height="80px">
</p>

<h1 align="center">BYPASS DPI USING MIKROTIK</h1>

<p align="center">
  <b><sup>Following this instruction is in your own risk. I'm not responsible for content you are trying to access after following this tutorial or the damage you done during the installation process. Please use it wisely and follow the instruction carefully</sup></b><br><br>
</p>

### Steps

1. Login into your RouterOS and open Terminal
2. Run this command to bypass National DNS:
```
# Script by BebasID Community

/ip firewall nat add action=dst-nat chain=dstnat comment="DNS BebasID" dst-port=53 protocol=tcp to-addresses=147.139.211.126 to-ports=1753
/ip firewall nat add action=dst-nat chain=dstnat comment="DNS BebasID" dst-port=53 protocol=udp to-addresses=147.139.211.126 to-ports=1753
```
3. Run this command as well to bypass Kominfo DPI:
```
# Script by BebasID Community

/ip firewall filter add comment="BebasIT | Bypass DPI" chain=forward protocol=tcp in-interface=[INTERFACE WAN ANDA] content="Location: http://lamanlabuh.aduankonten.id/" action=drop
/ip firewall filter add comment="BebasIT | Bypass DPI" chain=forward protocol=tcp in-interface=[INTERFACE WAN ANDA] tcp-flags=rst,ack action=drop
```
<b>Change [YOUR WAN INTERFACE] with your internet source interface like this:</b>
``` 
# Script by BebasID Community

/ip firewall filter add comment="BebasIT | Bypass DPI" chain=forward protocol=tcp in-interface=ether1 content="Location: http://lamanlabuh.aduankonten.id/" action=drop
/ip firewall filter add comment="BebasIT | Bypass DPI" chain=forward protocol=tcp in-interface=ether1 tcp-flags=rst,ack action=drop
```

**FOR INDOSAT USERS, PLEASE ADD THIS RULE DUE TO INDOSAT ALSO SEND ADDITIONAL REQUEST OTHER THAN LAMANLABUH FOR HTTP BLOCKING**
```
# Script by BebasID Community

/ip firewall filter add comment="BebasIT | Bypass DPI" chain=forward protocol=tcp in-interface=[INTERFACE WAN ANDA] content="Location: http://ads.indosatooredoo.com/ads-request" action=drop
```

4. All set and let's try!
