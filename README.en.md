# bebasit
bebasit is a derivative repo of bebasid which contains application for deep packet inspection (DPI) bypassing.

## List of Application
Here is a list of application which already tested in regards to DPI bypass capability.
### Windows
- GoodbyeDPI.
- PowerTunnel (JRE).
### Linux
- Green Tunnel (NodeJS + NPM).
- PowerTunnel (JRE).
- Zapret (currently it is still under testing phase as zapret does not include DoH within tpws).
### Mac
- Green Tunnel (NodeJS + NPM).
- PowerTunnel (JRE).
## Note
### Windows
- Not all version of Windows will work, for example Windows 7 without any update has problem, it needs KBxxxxxx.
### Linux dan MacOS
- Green Tunnel usability is depending on luck (it does not mean that Green Tunnel cannot bypass DPI).
### Addendum
- Version of application inside this repo does not use auto update scheme to latest version because a new feature of application might not be useful.
### Why bebasid and bebasit is separate
- Easing application suitability control.
- If application like GoodbyeDPI, Green Tunnel, PowerTunnel, and Zapret are included into bebasid repo, it would consume more data. In many cases, people use `git clone` command when downloading bebasid and it caused Mac version of the app being downloaded as well in Windows.
- New project.
- To make bebasid looks more formal.
## bebasit Dependencies
- [GoodbyeDPI](https://github.com/ValdikSS/GoodbyeDPI)
- [Green Tunnel](https://github.com/SadeghHayeri/GreenTunnel/)
- [PowerTunnel](https://github.com/krlvm/PowerTunnel)
- [Zapret](https://github.com/bol-van/zapret)
## License

bebasit is licensed under [MIT License](https://github.com/bebasid/bebasit/blob/master/LICENSE).

---

# Terms and Conditions

By using this service, you are deemed to have read, understood, and agreed to all the rules that we have made and you accept all the consequences that will arise. For more about the rules, you can see them on the page. [RULES](https://github.com/bebasid/bebasit/blob/master/dev/readme/RULES.md).
