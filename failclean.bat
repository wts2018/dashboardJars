@echo off
del /q C:\Test\SPD_fail.*
for /d %i in (C:\Test\SPD_fail.*) do @rmdir /s /q "%i"

/secondary /minimized