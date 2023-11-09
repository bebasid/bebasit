<p align="center">
  <img src="https://user-images.githubusercontent.com/115700386/232264116-5cef4e89-92c9-4548-b392-fc82e02747e3.png" width="600px">
</p>

<h1 align="center">DPI BYPASS TUTORIAL USING OPENWRT</h1>
<p align="center">
    <a href="openwrt-tutorial.md">Indonesia</a> | <b>English</b>
</p>

<p align="center">
  <b><sup>Following this instruction is in your own risk. I'm not responsible for content you are trying to access after following this tutorial or the damage you done during the installation process. Please use it wisely and follow the instruction carefully</sup></b>
</p>

### Installation Preparation Step
1. First, we login into our OpenWRT via SSH as admin by typing our IP from OpenWRT
2. After login, run ```opkg update``` command in terminal and wait until it finished<br>
3. After that, run ```opkg install iptables ip6tables git git-http nano``` command to install package that will be used for installation process of Zapret
4. Switch to tmp by running ```cd /tmp``` command in terminal<br>
5. Run ```git clone https://github.com/bol-van/zapret.git``` and wait until it finished<br>

### Bypass National DNS
Because Kominfo implemented  <a href="https://cms.dailysocial.id/wp-content/uploads/2015/05/slack_for_ios_upload_1024.png">National DNS</a> that mandated every ISP to redirect Port 53 to their servers and because Zapret will use the results of DNS resolves from our OpenWRT for bypass method probing, we need to bypass ISP DNS first before installing Zapret 

<b>There are 4 methods to bypass:</b><br>
- <b>Using BebasID host</b><br>
   - Create a file named bebasid in system by typing ```touch /etc/bebasid``` in terminal
   - Open the file by typing ```nano /etc/bebasid```
   - Copy the content of <a href="https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts" target="_blank">BebasID</a> into the aforementioned file that we made and then save it
   - Login to OpenWRT via web by typing the IP of OpenWRT, then go to <b>Network >> DHCP & DNS</b><br>
     ![image](https://user-images.githubusercontent.com/115700386/232265676-e1c5f8a7-e7ec-47e8-afe2-b703ee64e48f.png)
   - Go to <b>Resolv and Hosts Files</b>, add `/etc/bebasid` within <b>Additional hosts files
</b> and click + like this example below:<br>
     ![image](https://user-images.githubusercontent.com/115700386/232265727-0596f6b2-5e58-4cdd-bb24-302a44f76162.png)
   - Click Save & Apply 
   - To ensure that BebasID Host is already properly installed, run `nslookup lamanlabuh.aduankonten.id` in OpenWRT terminal<br>
     <p align="center"><img src="https://user-images.githubusercontent.com/115700386/232265834-d88744e5-bb59-462f-82e9-20c24434a6b3.png"><br>
     <b><sup>If the result is same as above, BebasID host configuration is successful</sup></b></p><br>
- <b>Using DNS with port other than 53</b><br>
   - Login into OpenWRT
   - Go to <b>Network >> Interfaces</b> and Edit WAN (or any interface used as your internet source)
     ![image](https://user-images.githubusercontent.com/115700386/232383389-329fceba-d178-4ca7-88b7-448c7c5dcc19.png)
   - Go to <b>Advanced Settings</b> and uncheck `Use DNS servers advertised by peer` option
     ![image](https://user-images.githubusercontent.com/115700386/232383541-96bba9e0-712a-415f-bdde-ffcdc3a6408c.png)
   - Setting DNS to 127.0.0.1 and click +
   - Then Save dan Apply
   - After that, go to <b>Network >> DHCP and DNS</b><br>
     ![image](https://user-images.githubusercontent.com/115700386/232383622-711dde04-c1b9-4099-8101-3234084c22fc.png)
   - At DNS Forwading, fill the DNS and alt-port with format `IP#PORT`
     For example:<br>
     ![image](https://user-images.githubusercontent.com/115700386/232384543-1a87981d-2186-45d1-b056-9b2a5ed146c9.png)<br>
     <sup>Example of usage of DNS from BebasID with alt-port 1753</sup><br>
     <p align="center"><sup><b>For Moratel/Oxygen users, do not use alt-port 5353 because Moratel blocked that port. Use DNS with alt-port other than 5353 if you are using it</b></sup></p>
   - Then click + and Save & Apply
- <b>Using DNS-over-TLS (Stubby)</b><br>
   - Before using DoT in OpenWRT, make sure that port 853 is not blocked by ISP
   - Check by running `curl -v portquiz.net:853` in terminal<br>
     <p align="center">
     <img src="https://user-images.githubusercontent.com/115700386/232675750-9c30e527-7ce9-4f04-acfc-db092894a346.png"><br>
     <sup>Make sure that <b>`Port test successful!`</b><br>If not, use other methods like hosts, alt port, and DoH</p>
   - If the test is successful, run `opkg update` in terminal
   - Then run `opkg install stubby` and wait until it finished<br>
     ![image](https://user-images.githubusercontent.com/115700386/232675427-8aa0b7b5-e498-4e9c-8c6d-7c8d40f4e505.png)<br>
   - Run `nano /etc/stubby/stubby.yml` to edit Stubby config
   - Note the used port<br>
     ![image](https://user-images.githubusercontent.com/115700386/232676399-e662ed62-eb88-42c7-a278-aa6ee7a32136.png)<br>
      <sup>It will be used in DNS configuration</sup>
   - If you want to change the default DNS provider (Cloudflare 1.1.1.1), edit the `address-data:` and `tls_auth_name:` section<br>
     ![image](https://user-images.githubusercontent.com/115700386/232677110-6173b9cc-2568-4d9a-800f-8488e8fd0435.png)<br>
     As example, to change to DNS-over-TLS of BebasID:<br>
     ![image](https://user-images.githubusercontent.com/115700386/232692104-7ca5eda9-1ad4-4d27-9e8d-ec2f3c2e379e.png)<br>
   - Save the result then run `nano /etc/config/stubby`
   - Change `option manual '0'` to `option manual '1'` then save<br>
     ![image](https://user-images.githubusercontent.com/115700386/232694974-294f09e0-0f3f-434a-af28-777f009c3593.png)
   - Run `service stubby restart` and `service stubby enable`
   - After that, login into OpenWRT with Web Interface
   - Go to <b>Network >> Interfaces</b> and Edit WAN (or any interface used as your internet source)
     ![image](https://user-images.githubusercontent.com/115700386/232383389-329fceba-d178-4ca7-88b7-448c7c5dcc19.png)
   - Go to <b>Advanced Settings</b> and uncheck `Use DNS servers advertised by peer` option
     ![image](https://user-images.githubusercontent.com/115700386/232383541-96bba9e0-712a-415f-bdde-ffcdc3a6408c.png)
   - Setting DNS to 127.0.0.1 and click +
   - Save dan Apply
   - Go to <b>Network >> DHCP and DNS</b><br>
     ![image](https://user-images.githubusercontent.com/115700386/232383622-711dde04-c1b9-4099-8101-3234084c22fc.png)
   - At DNS Forwarding, fill the DNS with the config `127.0.0.1#5453`
     ![image](https://user-images.githubusercontent.com/115700386/232693231-9a1f0c02-df3e-4383-9fc3-a830945fb1bf.png)
  - Click + and <b>Save and Apply</b>
  - Check by nslookup into domain that blocked by Kominfo (Ex: `nslookup reddit.com`) Make sure that Internet Positif IP is not shown<br>
    ![image](https://user-images.githubusercontent.com/115700386/232694308-b934f8e4-31d3-4922-99be-30b4ca1adaa5.png)<br>   
- <b>Using DNS-over-HTTPS</b><br>
<p align="center"><b>( TO BE CONTINUED... )</b></p>

### Zapret Installation
1.  After finished running <i>git clone</i> command in terminal and bypassed National / ISP DNS, navigate to /tmp/zapret by typing ```cd /tmp/zapret``` in terminal<br>
2.  Run ```./install-easy.sh``` in Terminal
3.  If this message is shown
    ```
    easy install is supported only from default location : /opt/zapret 
    currently its run from /tmp/zapret
    do you want the installer to copy it for you (default : N) (Y/N) ?
    ```
    Proceed ahead by typing `Y` and Enter
4.  For Firewall, choose iptables by typing 1 and enter<br>
    ![image](https://user-images.githubusercontent.com/115700386/232266676-b901a3a2-3cf1-48d1-87ee-bbce9d8e0721.png)<br>
5.  To enable IPv6 support, choose `Y` just in case<br>
    ![image](https://user-images.githubusercontent.com/115700386/232266756-e24ba6de-df68-4b65-bce7-e39c3e8669b3.png)<br>
6.  For Mode, choose `3` and enter<br>
    ![image](https://user-images.githubusercontent.com/115700386/232266796-e218738c-8399-4469-93c4-b81146730fdc.png)<br>
7.  Make sure to enable HTTP support, HTTPS support by choosing `Y` during installation process <br>
    ![image](https://user-images.githubusercontent.com/115700386/232266856-6abfb4da-e52a-41a9-a720-ae71e2ed293a.png)<br>
8.  After that click Enter and wait until it finished
9.  Delete Zapret folder in /tmp to conserve memory by going to `cd /tmp` and running `rm zapret -r`<br>

### Zapret Configuration
1.  Go to Zapret folder `cd /opt/zapret/` and run installation script `./install_bin.sh`
2.  If the process is successful, run `./blockpage.sh` to find optimal Zapret configuration for your ISP
3.  If this message is shown:
    ```
    specify domain(s) to test. multiple domains are space separated.
    domain(s) (default: rutracker.org) :
    ```
    Fill with domain that blocked by Kominfo (Example: `reddit.com`, `vimeo.com`, `omegle.com`, etc)
4.  If prompted with `ip protocol version`, adjust with your network configuration
    - For example, if your network only support IPv4, type `4` and enter
    - But, if your network supports IPv4 and IPv6, type `46` and enter
5.  Click enter and wait until you see `how many times to repeat each test (default: 1)`. Type `2` and Enter
6.  After that, you will see `do all test despite of result?`. Type Y and Enter
7.  Wait until Zapret found optimal configuration for your ISP 
8.  If finished, this will be shown:<br>
    ![image](https://user-images.githubusercontent.com/115700386/232272140-d9b62495-493e-4170-93d9-c8b70eae965a.png)<br>
    Note the results
9.  After that, stop Zapret service on OpenWRT by running `service zapret stop`
10. Edit Config by running `nano /opt/zapret/config`
11. Find this section inside the config file and replace with config that you already noted
    ```
    #NFQWS_OPT_DESYNC_HTTP=
    #NFQWS_OPT_DESYNC_HTTPS=
    #NFQWS_OPT_DESYNC_HTTP6=
    #NFQWS_OPT_DESYNC_HTTPS6=
    ```
    Uncomment # on NFQWS<br>
    For curl_test_https_tls12, fill in the HTTPS dan HTTPS6 section (Type after nfqws)<br>
    And, for curl_test_http, fill in the HTTP dan HTTP6 section (Type after nfqws)<br><br>
    <b>As Example:</b> (Adapt the section according to the results you already noted)
    ```
    NFQWS_OPT_DESYNC_HTTP="--hostcase"
    NFQWS_OPT_DESYNC_HTTPS="--dpi-desync=split2"
    NFQWS_OPT_DESYNC_HTTP6="--hostcase"
    NFQWS_OPT_DESYNC_HTTPS6="--dpi-desync=split2"
    ```
12. Then, save the results and start Zapret by running `service zapret start`
13. Do not forget to enable iptables and Zapret by running `service zapret enable` and `service iptables enable` to make sure that the services are started automatically during booting process

## Problem with banking application (Credit to One for the step)
Many bank will reject your request if you activated Zapret on OpenWRT Router so we need to create whitelist to those bank sites
1. Go to `/opt/zapret` folder then run `nano whitelist.txt`
2. Fill with:
    ```
    bankbjb.co.id
    bankbsi.co.id
    bankmandiri.co.id
    bca.co.id
    bi.go.id
    blubybcadigital.id
    bni.co.id
    bri.co.id
    btn.co.id
    cimbniaga.co.id
    danamon.co.id
    hanabank.co.id
    hsbc.co.id
    jago.com
    klikbca.com
    maybank.co.id
    permatabank.com
    permatanet.com
    sc.com
    ```
      <sup><b>(Add more if needed)</b></sup><br>
3. Then Save and run `chmod 755 whitelist.txt` in terminal
4. Edit Zapret config by running `nano config`
5. Find line with `NFQWS_OPT_DESYNC` and append ` --hostlist-exclude=/opt/zapret/whitelist.txt` on every end section before `"`
   - As example, our Zapret Configuration:
     ```
     # CHOOSE NFQWS DAEMON OPTIONS for DPI desync mode. run "nfq/nfqws --help" for option list
     DESYNC_MARK=0x40000000
     NFQWS_OPT_DESYNC="--dpi-desync=fake --dpi-desync-ttl=0 --dpi-desync-ttl6=0 --dpi-desync-fooling=badsum"
     NFQWS_OPT_DESYNC_HTTP="--hostcase"
     NFQWS_OPT_DESYNC_HTTPS="--dpi-desync=split2"
     NFQWS_OPT_DESYNC_HTTP6="--hostcase"
     NFQWS_OPT_DESYNC_HTTPS6="--dpi-desync=split2"
     ```
   - We need to append `--hostlist-exclude=/opt/zapret/whitelist.txt` on every end section so they will look like this:
     ```
     # CHOOSE NFQWS DAEMON OPTIONS for DPI desync mode. run "nfq/nfqws --help" for option list
     DESYNC_MARK=0x40000000
     NFQWS_OPT_DESYNC="--dpi-desync=fake --dpi-desync-ttl=0 --dpi-desync-ttl6=0 --dpi-desync-fooling=badsum --hostlist-exclude=/opt/zapret/whitelist.txt"
     NFQWS_OPT_DESYNC_HTTP="--hostcase --hostlist-exclude=/opt/zapret/whitelist.txt"
     NFQWS_OPT_DESYNC_HTTPS="--dpi-desync=split2 --hostlist-exclude=/opt/zapret/whitelist.txt"
     NFQWS_OPT_DESYNC_HTTP6="--hostcase --hostlist-exclude=/opt/zapret/whitelist.txt"
     NFQWS_OPT_DESYNC_HTTPS6="--dpi-desync=split2 --hostlist-exclude=/opt/zapret/whitelist.txt"
     ```
6. Save and restart Zapret by running `service zapret restart`
