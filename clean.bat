@echo off
del /q C:\Test\*.*
for /d %i in (C:\Test\*.*) do @rmdir /s /q "%i"
/secondary /minimized