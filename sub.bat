@echo off
setlocal

REM Establecer el límite de memoria en 50mb
REM set "limite=104857600"
set "limite=%1"

REM Obtener la lista de procesos y su uso de memoria
cd c:/users/modim/desktop/

REM wmic process where "WorkingSetSize <= %limite% AND Name != 'csrss.exe' AND Name != 'wininit.exe' REM AND Name != 'smss.exe' AND Name != 'lsass.exe' AND Name != 'svchost.exe' AND Name != 'services.exe' REM AND Name != 'winlogon.exe'" get ProcessId > procesos.txt

REM wmic process where "WorkingSetSize <= %limite% AND CommandLine LIKE '%%.exe' AND ExecutablePath REM LIKE '%%\\Windows\\%%' AND ExecutablePath LIKE '%%\\System32\\%%'" get ProcessId > procesos.txt

wmic process where "WorkingSetSize <= %limite% AND NOT ExecutablePath LIKE '%%\\Windows\\%%' AND NOT ExecutablePath LIKE '%%\\System32\\%%'" get ProcessId > procesosFINAL.txt

wmic process where "WorkingSetSize <= %limite% AND NOT ExecutablePath LIKE '%%\\Windows\\%%' AND NOT ExecutablePath LIKE '%%\\System32\\%%'" get Name, ProcessId, WorkingSetSize > procesosTable.txt


pause
type procesosFINAL.txt > procesosFINAL2.txt

for /F %%A in (procesosFINAL2.txt) do (
REM echo %%A
echo Eliminando proceso con ID: %%A
taskkill /PID %%A /F
)

pause
REM Eliminar el archivo temporal
del procesosFINAL.txt
del procesosFINAL2.txt
echo Procesos eliminados.

pause
endlocal
