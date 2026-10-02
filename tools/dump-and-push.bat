@echo off
chcp 65001 >nul
rem ===== НАСТРОЙКИ (заполнить) =====
set V8="C:\Program Files\1cv8\8.3.XX.XXXX\bin\1cv8.exe"
rem Файловая база:  set IB=/F "D:\Bases\ERP_copy"
rem Серверная база: set IB=/S "server1c\erp_copy"
set IB=/F "D:\Bases\ERP_copy"
set IBUSER=Администратор
set IBPWD=
rem Каталог с клоном репозитория
set REPO=D:\Git\erp
rem =================================
set SRC=%REPO%\src
set LOG=%REPO%\designer.log

rem Выгрузка конфигурации из базы в файлы и отправка в GitHub
cd /d "%REPO%" || exit /b 1
git pull --ff-only || (echo Ошибка git pull & pause & exit /b 1)
if exist "%SRC%\ConfigDumpInfo.xml" (set UPD=-update -force) else (set UPD=)
echo Выгрузка конфигурации...
%V8% DESIGNER %IB% /N"%IBUSER%" /P"%IBPWD%" /DisableStartupDialogs /DumpConfigToFiles "%SRC%" -Format Hierarchical %UPD% /Out "%LOG%"
if errorlevel 1 (type "%LOG%" & echo Ошибка выгрузки & pause & exit /b 1)
git add -A
git commit -m "Выгрузка конфигурации %DATE% %TIME%"
git push
echo Готово.
pause
