@ECHO OFF
REM taskkill /IM node.exe /F
%~dp0\src\tracker\node_modules\.bin\coffee.cmd %~dp0\src\tracker\index.coffee %1