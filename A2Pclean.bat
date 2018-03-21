@echo off

del /q C:\Test\A2P_fail.*
for /d %i in (C:\Test\A2P_fail.*) do @rmdir /s /q "%i"

/secondary /minimized