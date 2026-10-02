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

rem Получение доработок из GitHub и частичная загрузка в базу.
rem Сначала проверяйте на КОПИИ базы.
cd /d "%REPO%" || exit /b 1
for /f %%h in ('git rev-parse HEAD') do set OLD=%%h
git pull --ff-only || (echo Ошибка git pull & pause & exit /b 1)
for /f %%h in ('git rev-parse HEAD') do set NEW=%%h
if "%OLD%"=="%NEW%" (echo Новых изменений нет & pause & exit /b 0)

set LIST=%TEMP%\1c_changed.txt
if exist "%LIST%" del "%LIST%"
for /f "usebackq delims=" %%f in (`git -c core.quotepath=off diff --name-only --diff-filter=AMR %OLD% %NEW% -- src`) do (
  echo %REPO%\%%f>>"%LIST%"
)
for /f "usebackq delims=" %%f in (`git -c core.quotepath=off diff --name-only --diff-filter=D %OLD% %NEW% -- src`) do (
  echo ВНИМАНИЕ: удалён файл %%f — удаление объектов делайте вручную в Конфигураторе
)
if not exist "%LIST%" (echo Изменений в src нет & pause & exit /b 0)
powershell -NoProfile -Command "(Get-Content '%LIST%') -replace '/', '\' | Set-Content -Encoding UTF8 '%LIST%'"
echo Загружаются файлы:
type "%LIST%"

%V8% DESIGNER %IB% /N"%IBUSER%" /P"%IBPWD%" /DisableStartupDialogs /LoadConfigFromFiles "%SRC%" -listFile "%LIST%" -Format Hierarchical -partial -updateConfigDumpInfo /Out "%LOG%"
if errorlevel 1 (type "%LOG%" & echo Ошибка загрузки & pause & exit /b 1)

echo Обновление конфигурации базы данных...
%V8% DESIGNER %IB% /N"%IBUSER%" /P"%IBPWD%" /DisableStartupDialogs /UpdateDBCfg /Out "%LOG%"
if errorlevel 1 (type "%LOG%" & echo Ошибка обновления БД & pause & exit /b 1)
echo Готово: загружено %OLD:~0,7% .. %NEW:~0,7%
pause
