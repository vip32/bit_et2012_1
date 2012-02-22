@ECHO OFF
REM taskkill /IM node.exe /F
%~dp0\src\client\node_modules\.bin\coffee.cmd %~dp0\src\client\index.coffee %1
