REM ----------------------------------------------------------------------------------------------------------------------
REM File Name         : E:\Instaladores\SetupBizAgi.bat 
REM Author            : Edisson Giovanni Zuñiga Lopez 
REM Description       : Procedimiento de instalacion BPM 
REM                   : 27\11\2018 
REM ----------------------------------------------------------------------------------------------------------------------

@echo off
title:                                   Gestion de Ambientes:                                          Banco Pichincha
REM Menu Principal

:Menu
cls
set "var=%var*=%"
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set miip=%%b
color F9
echo.
echo   -------------------------------------------------------------------------------------------------------------------
echo   NOMBREPC:%COMPUTERNAME%  ! IP:%miip% ! USUARIO:%USERNAME% ! FECHA:%DATE%  !  HORA:%TIME%  Banco Pichincha 
echo   -------------------------------------------------------------------------------------------------------------------
echo.
echo   -   Primer Paso:
echo   - a (A). Actualizar IPS del ejecutable
echo.
echo   -------------------------------------------------------------------------------------------------------------------
echo   -   Instalacion de Servidor                                   -   Configuracion IIS y Servicios                   -
echo   -------------------------------------------------------------------------------------------------------------------
echo   -   1. Instalacion Full PBM                                   - 10. Configuracion Full PBM                        -
echo   -   2. Configuracion Politicas Firewall y Seguridad IExplore  - 11. Copiar BizagiProjects                         -
echo   -   3. Crear Usuario bpm                                      - 12. Crear Pool                                    -
echo   -   4. Instalacion de caracteristicas de IIS para bpm         - 13. Crear Web Aplication                          -
echo   -   5. Instalacion de BizAgi Engine                           - 14. Instalar Servicio Scheduler                   -
echo   -   6. Compartir Carpetas BPM                                 - 15. Configurar Servicio Scheduler                 -
echo   -   7. Copiar Instaladores en Ambientes Distribuidos          - 16. Instalar certificado y https al sitio         -
echo   -   8. Copiar Setup en Ambientes Distribuidos
echo. 
echo   -------------------------------------------------------------------------------------------------------------------
echo   -   Administracion                                                                                                -                                    
echo   -------------------------------------------------------------------------------------------------------------------
echo   -   c (C). Cambiar clave usuario bpmadmin                                                                         -
echo   -   p (P). Actualizar permisos de Carpetas de BizAgi                                                              -
echo   -   u (U). Desinstalar Servicio Scheduler                                                                         -
echo   -   r (R). Crear Ruta Estatica. Solo servidores de DMZ                                                            -
echo   -   i (I). Reinicio IIS y Scheduler                                                                               -
echo   -   e (E). Validar Estados Servicios IIS, Scheduler y Sitios                                                      -
echo   -   b (B). Borrar Certificado                                                                                     -
echo   -   z (Z). Detener Servicios IIS y Scheduler                                                                      -
echo   -   s (S). Subir Servicios IIS y Scheduler                                                                        -
echo   -   t (T). Borrar Temporales                                                                        -
echo.
echo   -------------------------------------------------------------------------------------------------------------------
echo   -   d (D). Despliegues                                                                                            -
echo   -------------------------------------------------------------------------------------------------------------------
echo   -   Enter  Para Salir                                                                                             -
echo   -------------------------------------------------------------------------------------------------------------------
echo   -   Escribe un Numero del menu y Presione Enter:                                                                  -
echo   -------------------------------------------------------------------------------------------------------------------

set /p var=
if %var%==1 goto :Primero
if %var%==2 goto :Segundo
if %var%==3 goto :Tercero
if %var%==4 goto :Cuarto
if %var%==5 goto :Quinto
if %var%==6 goto :Sexto
if %var%==7 goto :Septimo
if %var%==8 goto :Octavo
if %var%==9 goto :Noveno
if %var%==10 goto :Decimo
if %var%==11 goto :Decimoprimero
if %var%==12 goto :Decimosegundo
if %var%==13 goto :Decimotercero
if %var%==14 goto :Decimocuarto
if %var%==15 goto :Decimoquinto
if %var%==16 goto :Decimosexto
if %var%==17 goto :Decimoseptimo
if %var%==18 goto :Decimooctavo
if %var%==19 goto :Decimonoveno
if %var%==a goto :ActualizarData
if %var%==A goto :ActualizarData
if %var%==c goto :Clavesbpmadmin
if %var%==C goto :Clavesbpmadmin
if %var%==q goto :exit
if %var%==Q goto :exit
if %var%==d goto :Despliegues
if %var%==D goto :Despliegues
if %var%==p goto :PermisosCarpetas
if %var%==P goto :PermisosCarpetas
if %var%==r goto :RutaEstatica
if %var%==R goto :RutaEstatica
if %var%==i goto :ReinicioServicios
if %var%==I goto :ReinicioServicios
if %var%==e goto :EstadosServicios
if %var%==E goto :EstadosServicios
if %var%==b goto :UnistallCertificado
if %var%==B goto :UnistallCertificado
if %var%==u goto :UnistallScheduler
if %var%==U goto :UnistallScheduler
if %var%==s goto :SubirServicios
if %var%==S goto :SubirServicios
if %var%==z goto :DetenerServicios
if %var%==Z goto :DetenerServicios
if %var%==t goto :BorrarTemporales
if %var%==T goto :BorrarTemporales
if %var% GTR 0 echo Error
echo Enter Para Salir
Pause>Nul
goto :Menu

:Primero
cls
set "var=%var*=%"
SETLOCAL
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set miip=%%b
set RuleFW=netsh advfirewall firewall set rule name=
set VarPowerShell=%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe
set VarAppCmd=%systemroot%\system32\inetsrv\APPCMD
set Instaladores1=E:\Instaladores
set ServerLan1=10.160.88.68
set ServerLan2=10.160.88.69
set ServerApi1=10.160.75.15
set ServerApi2=10.160.75.16
set ServerWeb1=10.160.75.21
set ServerWeb2=10.160.75.22
set VLAN=10.160.75.1
set PasswUserBpm=A16CalidadC*2018
set UsuarioBpm=bpmadmin
set Instaladores=E:\Instaladores
set BizagiProjects1=E:\BizagiProjects
set LogsTrace1=E:\BizagiProjects\PichinchaBPMExt\Trace
set LogsSOA1=E:\BizagiProjects\PichinchaBPMExt\Temporary\SOA
set WSDLServicios=E:\Servicios\Documentacion Servicios

if %miip% == %ServerLan2% set Result=true
if %miip% == 10.160.93.19 set Result=true
if %miip% == 10.160.93.20 set Result=true
if %miip% == 10.160.93.21 set Result=true
if %miip% == 10.160.93.22 set Result=true

echo ------------------------------------------------------------------------------------------------------------
echo 1. Instalacion Full PBM - Primera Parte
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - Prerequisitos de Copia de Carpetas entre servidores
echo             	 - Crear Carpeta Instaladores si no Existe
echo             	 - Configuracion Politicas Firewall
echo              - Creacion Usuario %Usuariobpm%
echo            	 - Asignacion de Clave Usuario %Usuariobpm%
echo             	 - Agregar grupos administradores, Administrators, IIS_IUSRS y "Remote Desktop Users"
echo             	 - Muestra información usuario %Usuariobpm%
echo            	 - Asigna Permisos a Carpeta %Instaladores1%
echo              - Instalacion y configuracion IIS
echo                 - Se instalara caracteristicas de IIS 
echo                 - Reinstalacion de ServerRuntime y ServerRuntim, Reinicio IIS
echo                 - Reinicio IIS
echo              - Instalacion de BizAgi Engine
echo              - Compartir Carpetas solo servidor Principal
echo              - Copiar Instaladores en Ambientes Distribuidos al Servidor 
echo              - Deshabilitar Seguridad Internet Explorer
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul
IF %miip% == %ServerLan1% (
			cls
			echo.
			echo Instalacion de Servidor Principal %miip%
			echo.
			echo -------------------------------------------------------------------------------------------------------------
			echo Carpeta Instaladores debe contener 
			echo -------------------------------------------------------------------------------------------------------------
			echo Mode                LastWriteTime     Length Name
			echo ----                -------------     ------ ----
			echo d----      10/12/2018  2:45 p. m.            Certificate
			echo d----      14/11/2018  4:05 p. m.            Install
			echo d----      10/12/2018  2:46 p. m.            ps1
			echo -a---      29/10/2018  2:58 p. m.  760212040 BizagiEngine-x64-11.1.02561.exe
			echo -a---      12/12/2018  4:45 p. m.     110926 SetupBizAgi.bat
			echo -------------------------------------------------------------------------------------------------------------
			echo.
			echo Oprima cualquier tecla para continuar
			Pause>Nul
			echo.
			echo Configuracion Politicas de firewall 
			echo -------------------------------------------------------------------------------------------------------------
				%RuleFW%"File and Printer Sharing (Echo Request - ICMPv4-In)" new enable=Yes profile=any
				%RuleFW%"File and Printer Sharing (Echo Request - ICMPv6-In)" new enable=Yes profile=any
				%RuleFW%"File and Printer Sharing (LLMNR-UDP-In)" new enable=Yes profile=any
				%RuleFW%"File and Printer Sharing (NB-Datagram-In)" new enable=Yes profile=any
				%RuleFW%"File and Printer Sharing (NB-Name-In)" new enable=Yes profile=any
				%RuleFW%"File and Printer Sharing (NB-Session-In)" new enable=Yes profile=any
				%RuleFW%"File and Printer Sharing (SMB-In)" new enable=Yes profile=any
				%RuleFW%"File and Printer Sharing (Spooler Service - RPC)" new enable=Yes profile=any
				%RuleFW%"File and Printer Sharing (Spooler Service - RPC-EPMAP)" new enable=Yes profile=any
				netsh advfirewall firewall add rule name="acesso http y https bpm" protocol=TCP dir=in localport="80,443" action=allow
				netsh advfirewall firewall add rule name="acesso http y https bpm" protocol=TCP dir=in localport="80,443" action=allow
				echo.
				echo Fin de habilitar reglas FW
				echo CRL + C si quieres salir de la ejecucion
				echo.
			echo Inicia creacion de Usuario de administracion de bpm
			echo -------------------------------------------------------------------------------------------------------------
			echo.
			echo Oprima cualquier tecla para continuar
			Pause>Nul
				echo.
				net user %Usuariobpm% %PasswUserBpm% /add /FULLNAME:"%Usuariobpm% " /COMMENT:"Usuario de Administrador de BizAgi" /ACTIVE:YES
				echo.
				WMIC USERACCOUNT WHERE Name='%Usuariobpm%' SET PasswordExpires=FALSE
				echo.
				net user %Usuariobpm% %PasswUserBpm%
				echo.
			cls 
			echo -------------------------------------------------------------------------------------------------------------
			echo El usuario %Usuariobpm% se agrergaran a los siguiente grupos 
			echo administradores, Administrators, IIS_IUSRS y Grupo Remote Desktop Users 
			echo -------------------------------------------------------------------------------------------------------------
			echo.
			echo Oprima cualquier tecla para continuar
			Pause>Nul 
				net localgroup administradores %Usuariobpm% /add
				echo Agregado al Grupo administradores
				net localgroup Administrators %Usuariobpm% /add
				echo Agregado al Grupo Administrators
				net localgroup IIS_IUSRS %Usuariobpm% /add
				echo Agregado al Grupo IIS_IUSRS
				net localgroup "Remote Desktop Users" %Usuariobpm% /add
				echo Agregado al Grupo Remote Desktop Users
			echo.
			echo Oprima cualquier tecla para continuar
			Pause>Nul
			cls
			echo -------------------------------------------------------------------------------------------------------------
			echo Informacion del usuario 
			echo -------------------------------------------------------------------------------------------------------------
			echo.
			echo Oprima cualquier tecla para continuar
			Pause>Nul
				net user %Usuariobpm% |more
			echo.
			echo Asignacion Permisos 
			echo -------------------------------------------------------------------------------------------------------------
				icacls "%Instaladores1%" /grant %Usuariobpm%:F
			echo.
			echo Oprima cualquier tecla para continuar
			Pause>Nul
			echo.
			echo Presione Enter para continuar con la instalacion
			echo -------------------------------------------------------------------------------------------------------------
			Pause>Nul
			cls
				%VarPowerShell%  -noprofile -executionpolicy bypass -file "%Instaladores1%\ps1\SetupIIS.ps1"
			echo.
			echo Oprima cualquier tecla para continuar
			Pause>Nul
			echo Oprima cualquier tecla para continuar
			echo.  
			echo Reinstalacion de ServerRuntime y ServerRuntime 
			echo -------------------------------------------------------------------------------------------------------------
				%VarAppCmd% unlock config -section:system.webServer/httpCompression
				%VarAppCmd% unlock config -section:system.webServer/ServerRuntime
			echo fin reinstalacion Servicios
			echo.
			echo Oprima cualquier tecla para continuar
			Pause>Nul
				iisreset /restart
			echo fin reinicio IIS
			echo.
			echo Oprima cualquier tecla para continuar
			Pause>Nul
			echo.
			echo Fin proceso de instalacion de requierimientos IIS
			echo -------------------------------------------------------------------------------------------------------------
			echo Inicia instalacion de BizAgi Engine 
			echo.
			echo Datos que requiere para la instalacion en Ambiente qa1*35415454645 
			echo Server Name: CLUSQLHABZIQA,1433
			echo Usuario: usr_bziadmin
			echo Carpeta de destino: %Instaladores1%\BizagiEngine-x64-11.1.02561.exe
			echo.
			echo Contrasena para instlar : %PasswUserBpm%
			echo.
			echo -------------------------------------------------------------------------------------------------------------
			echo.
			echo Oprima cualquier tecla para continuar
			Pause>Nul
				runas /savecred /user:%Usuariobpm% "cmd /c %Instaladores1%\BizagiEngine-x64-11.1.02561.exe"
			echo.
			echo Carpetas requeridas para despliegues distriobuidos
			echo -------------------------------------------------------------------------------------------------------------
			echo    - Compartir Carpetas Instaladores
			echo    - Compartir Carpetas BizagiProjects
			echo.
			echo.
			echo Oprima cualquier tecla para continuar
			Pause>Nul
			echo.
			net share Instaladores="%Instaladores1%" /remark:"Carpeta de Instaladores"
			echo.
			echo Se compartio la carpeta : %Instaladores1%
			echo.
			echo.
			echo Oprima cualquier tecla para continuar
			Pause>Nul
			echo.
			net share BizagiProjects="%BizagiProjects1%" /remark:"Carpeta de BPM"
			echo.
			echo Se compartio la carpeta : %BizagiProjects1%
			echo.
			echo.
			echo Oprima cualquier tecla para continuar
			Pause>Nul
			echo.
			net share LogsTrace="%LogsTrace1%" /grant:everyone,READ /remark:"Carpeta de logs Trace"
			echo.
			echo Se compartio la carpeta : %LogsTrace1%
			echo.
			echo.
			echo Oprima cualquier tecla para continuar
			Pause>Nul
			echo.
			net share LogsSOA="%LogsSOA1%" /grant:everyone,READ /remark:"Carpeta de logs SOA"
			echo.
			echo Se compartio la carpeta : %LogsSOA1%
			echo.
			echo.
			echo Oprima cualquier tecla para continuar
			Pause>Nul
			echo.
			net share WSDLServicios="%WSDLServicios%" /grant:everyone,READ /remark:"Carpeta de logs SOA"
			echo.
			echo Se compartio la carpeta : %WSDLServicios%
			echo.
			Pause>Nul
			echo deshabilitar seguridad a internet explorer
			echo -------------------------------------------------------------------------------------------------------------
				%VarPowerShell% -noprofile -executionpolicy bypass -file "%Instaladores1%\ps1\DisableIESC.ps1"
			echo.
			echo Oprima cualquier tecla para continuar
			Pause>Nul
			echo.
			echo ************************************************************************************************************
			echo Fin Instalacion de Servidor
			echo Primera parte - Instalacion Completa
			echo ************************************************************************************************************
			echo.
			echo Oprima cualquier tecla para continuar
			echo.
			Pause>Nul
			goto :Menu
		) ELSE ( if "%Result%" == "true" (
			cls
			echo.
							echo.
							echo Instalacion de servidores distribuidos mi ip es: %miip%
							echo.
							echo Solicitar permiso a seguridad informatica
							echo -------------------------------------------------------------------------------------------------------------
							echo Origen        - Destino       - Puerto      -  Descripcion
							echo -------------------------------------------------------------------------------------------------------------
							echo %ServerApi1%  - %ServerLan1%  - TCP/UDP 445 -  Acceso despliegues distribuidos BPM
							echo %ServerApi2%  - %ServerLan1%  - TCP/UDP 445 -  Acceso despliegues distribuidos BPM
							echo %ServerWeb1%  - %ServerLan1%  - TCP/UDP 445 -  Acceso despliegues distribuidos BPM
							echo %ServerWeb2%  - %ServerLan1%  - TCP/UDP 445 -  Acceso despliegues distribuidos BPM
							echo -------------------------------------------------------------------------------------------------------------
							echo.
							echo Persistent Routes:
							echo	  Network Address          Netmask  Gateway Address  Metric
							echo			  0.0.0.0          0.0.0.0     10.160.93.10  Default
							echo		 10.160.88.68  255.255.255.255      10.160.75.1       1
							echo -------------------------------------------------------------------------------------------------------------
							echo.
							echo Se procede a crear Ruta estatica, oprima cualquie tecla para continuar 
							echo validar utilice comando route print
							echo.
							Pause>Nul
							echo.
								 route -p add %ServerLan1% mask 255.255.255.255 %VLAN%
							echo -------------------------------------------------------------------------------------------------------------
							echo.
							echo Configuracion Politicas de firewall
							echo.
							echo Oprima cualquier tecla para continuar
							echo -------------------------------------------------------------------------------------------------------------
							Pause>Nul
								%RuleFW%"File and Printer Sharing (Echo Request - ICMPv4-In)" new enable=Yes profile=any
								%RuleFW%"File and Printer Sharing (Echo Request - ICMPv6-In)" new enable=Yes profile=any
								%RuleFW%"File and Printer Sharing (LLMNR-UDP-In)" new enable=Yes profile=any
								%RuleFW%"File and Printer Sharing (NB-Datagram-In)" new enable=Yes profile=any
								%RuleFW%"File and Printer Sharing (NB-Name-In)" new enable=Yes profile=any
								%RuleFW%"File and Printer Sharing (NB-Session-In)" new enable=Yes profile=any
								%RuleFW%"File and Printer Sharing (SMB-In)" new enable=Yes profile=any
								%RuleFW%"File and Printer Sharing (Spooler Service - RPC)" new enable=Yes profile=any
								%RuleFW%"File and Printer Sharing (Spooler Service - RPC-EPMAP)" new enable=Yes profile=any
								netsh advfirewall firewall add rule name="acesso http y https bpm" protocol=TCP dir=in localport="80,443" action=allow
								echo.
								echo Fin de habilitar reglas FW
								echo CRL + C si quieres salir de la ejecucion
								echo.
							Pause>Nul
							cls
							echo -------------------------------------------------------------------------------------------------------------
							echo Inicia creacion de Usuario de administracion de bpm
							echo -------------------------------------------------------------------------------------------------------------
								echo.
								net user %Usuariobpm% %PasswUserBpm% /add /FULLNAME:"%Usuariobpm% " /COMMENT:"Usuario de Administrador de BizAgi" /ACTIVE:YES
								echo.
								echo Este paso demora un promedio de 1 a 2 min para finalizar
								echo.
								WMIC USERACCOUNT WHERE Name='%Usuariobpm%' SET PasswordExpires=FALSE
								echo.
								net user %Usuariobpm% %PasswUserBpm%
								echo.
								echo Oprima cualquier tecla para continuar
								Pause>Nul
							cls
							echo -------------------------------------------------------------------------------------------------------------
							echo El usuario %Usuariobpm% se agrergaran a los siguiente grupos
							echo administradores, Administrators, IIS_IUSRS y Grupo Remote Desktop Users
							echo -------------------------------------------------------------------------------------------------------------
							echo.
							echo Oprima cualquier tecla para continuar
							Pause>Nul
								net localgroup administradores %Usuariobpm% /add
								echo Agregado al Grupo administradores
								net localgroup Administrators %Usuariobpm% /add
								echo Agregado al Grupo Administrators
								net localgroup IIS_IUSRS %Usuariobpm% /add
								echo Agregado al Grupo IIS_IUSRS
								net localgroup "Remote Desktop Users" %Usuariobpm% /add
								echo Agregado al Grupo Remote Desktop Users
							echo.
							echo Oprima cualquier tecla para continuar
							Pause>Nul
							cls
							echo -------------------------------------------------------------------------------------------------------------
							echo Informacion del usuario
								net user %Usuariobpm% |more
							echo -------------------------------------------------------------------------------------------------------------
							echo Asignacion Permisos
								icacls "%Instaladores1%" /grant %Usuariobpm%:F
							echo -------------------------------------------------------------------------------------------------------------
							echo.
							echo Oprima cualquier tecla para continuar
							Pause>Nul
							echo Inicia instalacion de caracteristicas de IIS para bpm
							cls
								%VarPowerShell%  -noprofile -executionpolicy bypass -file "%Instaladores1%\ps1\SetupIIS.ps1"
							echo.
							echo Oprima cualquier tecla para continuar
							Pause>Nul
							echo -------------------------------------------------------------------------------------------------------------
							echo Reinstalacion de ServerRuntime y ServerRuntime
								%VarAppCmd% unlock config -section:system.webServer/httpCompression
								%VarAppCmd% unlock config -section:system.webServer/ServerRuntime
							echo.	 
							echo fin reinstalacion Servicios
							echo.
							echo Oprima cualquier tecla para continuar
							Pause>Nul
								iisreset /restart
							echo.
							echo fin reinicio IIS 
							echo.
							echo Oprima cualquier tecla para continuar
							Pause>Nul
							echo Fin proceso de instalacion de requierimientos IIS
							echo -------------------------------------------------------------------------------------------------------------
							cls
							echo Inicia instalacion de BizAgi Engine
							echo Datos que requiere para la instalacion en Ambiente
							echo -------------------------------------------------------------------------------------------------------------
							echo Server Name: CLUSQLHABZIQA,1433
							echo Usuario: usr_bziadmin
							echo Carpeta de destino: %Instaladores1%\BizagiEngine-x64-11.1.02561.exe
							echo.
							echo Oprima cualquier tecla para continuar
							Pause>Nul
								runas /savecred /user:%Usuariobpm% "cmd /c %Instaladores1%\BizagiEngine-x64-11.1.02561.exe"
							echo Fin instalacion de BizAgi Engine
							echo -------------------------------------------------------------------------------------------------------------
							echo.
							echo deshabilitar seguridad a internet explorer
							echo -------------------------------------------------------------------------------------------------------------
							echo.
							echo Oprima cualquier tecla para continuar
							Pause>Nul	 
								%VarPowerShell%  -noprofile -executionpolicy bypass -file "%Instaladores1%\ps1\DisableIESC.ps1"
							echo.
							echo ************************************************************************************************************
							echo Fin Instalacion de Servidor
							echo Primera parte - Instalacion Completa
							echo ************************************************************************************************************
							echo.
							echo Oprima cualquier tecla para continuar
							Pause>Nul
							goto :Menu
						)
				)
echo Enter --: Para Salir
Pause>Nul
goto :Menu

:Segundo 
cls
set "var=%var*=%"
set Instaladores1=E:\Instaladores
set VarPowerShell=%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe 
set RuleFW=netsh advfirewall firewall set rule name=
echo ------------------------------------------------------------------------------------------------------------
echo 2. Configuracion Politicas Firewall y Seguridad IExplore
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - Habilitar reglas FW para paso de archivos
echo              - Deshabilitar seguridad Internet Explorer del Servidor: Para Pruebas internas
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul
echo ************************************************************************************************************
echo Configuracion Politicas de firewall
echo ************************************************************************************************************
%RuleFW%"File and Printer Sharing (Echo Request - ICMPv4-In)" new enable=Yes profile=any
%RuleFW%"File and Printer Sharing (Echo Request - ICMPv6-In)" new enable=Yes profile=any
%RuleFW%"File and Printer Sharing (LLMNR-UDP-In)" new enable=Yes profile=any
%RuleFW%"File and Printer Sharing (NB-Datagram-In)" new enable=Yes profile=any
%RuleFW%"File and Printer Sharing (NB-Name-In)" new enable=Yes profile=any
%RuleFW%"File and Printer Sharing (NB-Session-In)" new enable=Yes profile=any
%RuleFW%"File and Printer Sharing (SMB-In)" new enable=Yes profile=any
%RuleFW%"File and Printer Sharing (Spooler Service - RPC)" new enable=Yes profile=any
%RuleFW%"File and Printer Sharing (Spooler Service - RPC-EPMAP)" new enable=Yes profile=any
netsh advfirewall firewall add rule name="acesso http y https bpm" protocol=TCP dir=in localport="80,443" action=allow
netsh advfirewall firewall add rule name="acesso http y https bpm" protocol=TCP dir=in localport="80,443" action=allow
echo.
echo Fin de habilitar reglas FW
echo CRL + C si quieres salir de la ejecucion
echo.
Pause>Nul
echo ************************************************************************************************************ 
echo deshabilitar seguridad a internet explorer
echo ************************************************************************************************************ 
%VarPowerShell%  -noprofile -executionpolicy bypass -file "%Instaladores1%\ps1\DisableIESC.ps1"
Pause>Nul
goto :Menu

:tercero
cls
set "var=%var*=%"
set PasswUserBpm=A16CalidadC*2018
set UsuarioBpm=bpmadmin
set Instaladores1=E:\Instaladores
echo ------------------------------------------------------------------------------------------------------------
echo 3. Crear Usuario bpm
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - Creacion Usuario %Usuariobpm%
echo              - Asignación de Clave Usuario %Usuariobpm%
echo              - Agregar grupos administradores, Administrators, IIS_IUSRS y "Remote Desktop Users"
echo              - Muestra información usuario %Usuariobpm%
echo              - Asigna Permisos a Carpeta %Instaladores1%
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul
echo ************************************************************************************************************
echo Inicia creacion de Usuario de administracion de bpm
echo ************************************************************************************************************
net user %Usuariobpm% %PasswUserBpm% /add /FULLNAME:"%Usuariobpm%" /COMMENT:"Usuario de Administrador de BizAgi" /ACTIVE:YES
WMIC USERACCOUNT WHERE Name='%Usuariobpm%' SET PasswordExpires=FALSE
net user %Usuariobpm%  %PasswUserBpm%
cls
echo ************************************************************************************************************
echo El usuario %Usuariobpm% se agrergaran a los siguiente grupos
echo administradores, Administrators, IIS_IUSRS y Grupo Remote Desktop Users
echo ************************************************************************************************************
Pause>Nul
net localgroup administradores %Usuariobpm% /add
echo Agregado al Grupo administradores
net localgroup Administrators %Usuariobpm% /add
echo Agregado al Grupo Administrators
net localgroup IIS_IUSRS %Usuariobpm% /add
echo Agregado al Grupo IIS_IUSRS
net localgroup "Remote Desktop Users" %Usuariobpm% /add
echo Agregado al Grupo Remote Desktop Users
Pause>Nul
cls
echo ************************************************************************************************************
echo Informacion del usuario
echo ************************************************************************************************************
Pause>Nul
net user %Usuariobpm% |more
echo ************************************************************************************************************
echo Asignacion Permisos
echo ************************************************************************************************************
icacls "%Instaladores1%" /grant %Usuariobpm%:F
Pause>Nul
cls
echo ************************************************************************************************************
echo Fin instalacion de usuario %Usuariobpm%
echo ************************************************************************************************************
Pause>Nul
goto :Menu

:Cuarto
cls
set "var=%var*=%"
set VarAppCmd=%systemroot%\system32\inetsrv\APPCMD
set VarPowerShell=%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe 
echo ------------------------------------------------------------------------------------------------------------
echo 4. Instalacion de caracteristicas de IIS para bpm
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - Se instalara caracteristicas de IIS 
echo              - Reinstalacion de ServerRuntime y ServerRuntim, Reinicio IIS
echo              - Reinicio IIS
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul
echo ************************************************************************************************************
echo Inicia instalacion de caracteristicas de IIS para bpm
echo Presione Enter para continuar con la instalacion
echo ************************************************************************************************************
Pause>Nul
cls
%VarPowerShell%  -noprofile -executionpolicy bypass -file "%Instaladores1%\ps1\SetupIIS.ps1"

echo ************************************************************************************************************
echo Reinstalacion de ServerRuntime y ServerRuntime
echo ************************************************************************************************************
%VarAppCmd% unlock config -section:system.webServer/httpCompression
%VarAppCmd% unlock config -section:system.webServer/ServerRuntime
echo.
echo fin reinstalacion Servicios
Pause>Nul
echo Reinicio IIS
iisreset /restart
echo fin reinicio IIS
Pause>Nul
echo ************************************************************************************************************
echo Fin proceso de instalacion de requierimientos IIS
echo ************************************************************************************************************
Pause>Nul
goto :Menu

:Quinto
cls
set "var=%var*=%"
set UsuarioBpm=bpmadmin
set Instaladores1=E:\Instaladores
echo ------------------------------------------------------------------------------------------------------------
echo 5. Instalacion de BizAgi Engine
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - Instalacion BizAgi Engine con usuario bpmadmin
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul
echo ************************************************************************************************************
echo Inicia instalacion de BizAgi Engine
echo ************************************************************************************************************
echo Datos que requiere para la instalacion en Ambiente
echo ************************************************************************************************************
echo Server Name: CLUSQLHABZIQA,1433
echo Usuario: usr_bziadmin
echo Carpeta de destino: %Instaladores1%\BizagiEngine-x64-11.1.02561.exe
echo ************************************************************************************************************
Pause>Nul
runas /savecred /user:%Usuariobpm% "cmd /c %Instaladores1%\BizagiEngine-x64-11.1.02561.exe"
echo.
echo ************************************************************************************************************ 
echo Fin instalacion de BizAgi Engine
echo ************************************************************************************************************
Pause>Nul
Pause>Nul
goto :Menu

:Sexto
cls
set "var=%var*=%"
SETLOCAL
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set miip=%%b
set Result=false
set ServerLan1=10.160.88.68
set ServerLan2=10.160.88.69
set ServerApi1=10.160.75.15
set ServerApi2=10.160.75.16
set ServerWeb1=10.160.75.21
set ServerWeb2=10.160.75.22
set Instaladores1=E:\Instaladores
set BizagiProjects1=E:\BizagiProjects
set LogsTrace1=E:\BizagiProjects\PichinchaBPMExt\Trace
set LogsSOA1=E:\BizagiProjects\PichinchaBPMExt\Temporary\SOA
set WSDLServicios=E:\Servicios\Documentacion Servicios
						
if %miip% == %ServerLan2% set Result=true
if %miip% == 10.160.93.19 set Result=true
if %miip% == 10.160.93.20 set Result=true
if %miip% == 10.160.93.21 set Result=true
if %miip% == 10.160.93.22 set Result=true

echo ------------------------------------------------------------------------------------------------------------
echo 6. Compartir Carpetas solo servidor Principal
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo                 - Compartir Carpetas Instaladores
echo                 - Compartir Carpetas BizagiProjects
echo                 - Compartir Carpetas Logs SOA
echo                 - Compartir Carpetas Logs Trace
echo                 - Compartir Carpetas WSDl de Servicios
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
pause

if %miip% == %ServerLan1% (
						echo.
						net share Instaladores="%Instaladores1%" /remark:"Carpeta de Instaladores"
						echo.
						echo Se compartio la carpeta : %Instaladores1%
						echo.
						Pause>Nul
						echo.
						net share BizagiProjects="%BizagiProjects1%" /remark:"Carpeta de BPM"
						echo.
						echo Se compartio la carpeta : %BizagiProjects1%
						echo.
						Pause>Nul
						echo.
						net share LogsTrace="%LogsTrace1%" /grant:everyone,READ /remark:"Carpeta de logs Trace"
						echo.
						echo Se compartio la carpeta : %LogsTrace1%
						echo.
						Pause>Nul
						echo.
						net share LogsSOA="%LogsSOA1%" /grant:everyone,READ /remark:"Carpeta de logs SOA"
						echo.
						echo Se compartio la carpeta : %LogsSOA1%
						echo.
						Pause>Nul
						echo.
						net share WSDLServicios="%WSDLServicios%" /grant:everyone,READ /remark:"Carpeta de logs SOA"
						echo.
						echo Se compartio la carpeta : %WSDLServicios%
						echo.
						echo ************************************************************************************************************ 
						echo Fin Compartir Carpetas
						echo Enter cualquier tecla para continuar o CTRL + C para finalizar
						echo ************************************************************************************************************
						Pause>Nul
						goto :Menu
		) ELSE ( if "%Result%" == "true" (
							echo.
							echo Solo aplica compartir las carpetas para el servidor principal: %ServerLan1%
							Pause>Nul
							echo.
							net share LogsTrace="%LogsTrace1%" /grant:everyone,READ /remark:"Carpeta de logs Trace"
							echo.
							echo Se compartio la carpeta : %LogsTrace1%
							echo.
							Pause>Nul
							echo.
							net share LogsSOA="%LogsSOA1%" /grant:everyone,READ /remark:"Carpeta de logs SOA"
							echo.
							echo Se compartio la carpeta : %LogsSOA1%
							echo.
							Pause>Nul
							echo.
							pause
							goto :Menu
						)
				)
Pause>Nul
goto :Menu

:Septimo
cls
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set miip=%%b

SETLOCAL
set Result=false
set ServerLan1=10.160.88.68
set ServerLan2=10.160.88.69
set ServerApi1=10.160.75.15
set ServerApi2=10.160.75.16
set ServerWeb1=10.160.75.21
set ServerWeb2=10.160.75.22
set Instaladores=E:\Instaladores\*.*

if %miip% == %ServerLan2% set Result=true
if %miip% == 10.160.93.19 set Result=true
if %miip% == 10.160.93.20 set Result=true
if %miip% == 10.160.93.21 set Result=true
if %miip% == 10.160.93.22 set Result=true

echo ------------------------------------------------------------------------------------------------------------
echo 7. Copiar Instaladores 
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - Copia de Instalacion de archivos Distibuidos al servidor %ServerLan2% 
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul

IF %miip% == %ServerLan1% (
						echo ******************************************************************************************************************
						echo Inicia Proceso Instalacion Servidores Distibuidos IP: 
						echo %ServerLan2%, %ServerApi1%,%ServerApi2%,%ServerWeb1%,%ServerWeb2%
						echo ******************************************************************************************************************
						xcopy %Instaladores% /s/e/f \\%ServerLan2%\E$\Instaladores\
						del "\\%ServerLan2%\E$\SetupBizAgi.bat" /Q
						echo.
						echo Finalizo copia del servidor %ServerLan2%
						Pause>Nul
						xcopy %Instaladores% /s/e/f \\%ServerApi1%\E$\Instaladores\
						del "\\%ServerApi1%\E$\SetupBizAgi.bat" /Q
						echo.
						echo Finalizo copia del servidor %ServerApi1%
						Pause>Nul
						xcopy %Instaladores% /s/e/f \\%ServerApi2%\E$\Instaladores\
						del "\\%ServerApi2%\E$\SetupBizAgi.bat" /Q
						echo.
						echo Finalizo copia del servidor %ServerApi2%
						Pause>Nul
						xcopy %Instaladores% /s/e/f \\%ServerWeb1%\E$\Instaladores\
						del "\\%ServerWeb1%\E$\SetupBizAgi.bat" /Q
						echo.
						echo Finalizo copia del servidor %ServerWeb1%
						Pause>Nul
						xcopy %Instaladores% /s/e/f \\%ServerWeb2%\E$\Instaladores\
						del "\\%ServerWeb1%\E$\SetupBizAgi.bat" /Q
						echo.
						echo Finalizo copia del servidor %ServerWeb2%
						Pause>Nul
						echo ******************************************************************************************************************
						echo Fin Copia de Instalacion de archivos Distibuidos
						echo ******************************************************************************************************************
						Pause>Nul
						echo Enter cualquier tecla para continuar o CTRL + C para finalizar
						echo.
						echo Enter para continuar o CTRL + C para finalizar
						echo.
						Pause>Nul
						goto :Menu
		) ELSE ( if "%Result%" == "true" (
							echo.
							echo Solo aplica pasar los archivos desde el servidor principal: %ServerLan1% 
							echo al servidor distribuido %ServerLan2%
							echo.
							Pause>Nul
							echo Oprima cualquier tecla para continuar
							echo.
							echo Enter cualquier tecla para continuar o CTRL + C para finalizar
							echo.
							Pause>Nul
							goto :Menu
						)
				)
				Pause>Nul
Pause>Nul
goto :Menu

:Octavo
cls
set "var=%var*=%"
SETLOCAL
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set miip=%%b
set Result=false
set ServerLan1=10.160.88.68
set ServerLan2=10.160.88.69
set ServerApi1=10.160.75.15
set ServerApi2=10.160.75.16
set ServerWeb1=10.160.75.21
set ServerWeb2=10.160.75.22
set Instaladores1=E:\Instaladores\SetupBizAgi.bat
						
if %miip% == %ServerLan2% set Result=true
if %miip% == 10.160.93.19 set Result=true
if %miip% == 10.160.93.20 set Result=true
if %miip% == 10.160.93.21 set Result=true
if %miip% == 10.160.93.22 set Result=true

echo ------------------------------------------------------------------------------------------------------------
echo 8. Copiar Setup en Ambientes Distribuidos
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo                 - Actualizar archivo SetupBizAgi
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul

if %miip% == %ServerLan1% (
						echo.
						echo ******************************************************************************************************************
							echo Inicia Proceso Instalacion Servidores Distibuidos IP: 
							echo %ServerLan2%, %ServerApi1%,%ServerApi2%,%ServerWeb1%,%ServerWeb2%
							echo ******************************************************************************************************************
							xcopy %Instaladores1% /s/e/f \\%ServerLan2%\E$\Instaladores\
							echo.
							echo Finalizo copia del servidor %ServerLan2%
							Pause>Nul
							xcopy %Instaladores1% /s/e/f \\%ServerApi1%\E$\Instaladores\
							echo.
							echo Finalizo copia del servidor %ServerApi1%
							Pause>Nul
							xcopy %Instaladores1% /s/e/f \\%ServerApi2%\E$\Instaladores\
							echo.
							echo Finalizo copia del servidor %ServerApi2%
							Pause>Nul
							xcopy %Instaladores1% /s/e/f \\%ServerWeb1%\E$\Instaladores\
							echo.
							echo Finalizo copia del servidor %ServerWeb1%
							Pause>Nul
							xcopy %Instaladores1% /s/e/f \\%ServerWeb2%\E$\Instaladores\
							echo.
							echo Finalizo copia del servidor %ServerWeb2%
							echo.
							Pause>Nul
						Pause>Nul
						goto :Menu
		) ELSE ( if "%Result%" == "true" (
							echo.
							echo Solo aplica para el instalador del servidor principal %ServerLan1%
							echo.
							Pause>Nul
							goto :Menu
						)
				)
Pause>Nul
goto :Menu

:Noveno
cls
set "var=%var*=%"
echo ------------------------------------------------------------------------------------------------------------
echo 9. Vacio
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - 
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul
Pause>Nul
goto :Menu

:Decimo
cls
set "var=%var*=%"
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set miip=%%b
SETLOCAL

set BizagiProjects=E:\BizagiProjects
set Instaladores=E:\Instaladores\*.*
set Instaladores1=E:\Instaladores
set NameOperation=Bizagi Standard Server Operations Service
set NameScheduler=BizAgiPichinchaBPMExtSchedulerService
set Server=\\%ServerLan1%\Instaladores\
set ServerScheduler=E:\BizagiProjects\PichinchaBPMExt\Scheduler\
set ServerLan1=10.160.88.68
set ServerLan1=10.160.88.68
set ServerLan2=10.160.88.69
set ServerApi1=10.160.75.15
set ServerApi2=10.160.75.16
set ServerWeb1=10.160.75.21
set ServerWeb2=10.160.75.22
set VarPowerShell=%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe
set VarAppCmd=%systemroot%\system32\inetsrv\APPCMD
set WebApplication=\\%ServerLan1%\BizagiProjects\PichinchaBPMExt\*.*
set Scheduler=\\%ServerLan1%\BizagiProjects\PichinchaBPMExt\Scheduler\*.*
set NamePool=Bizagi 64-Bit ASP.NET v4.0
set PasswUserBpm=A16CalidadC*2018
set UsuarioBpm=bpmadmin
set NamePool=Bizagi 64-Bit ASP.NET v4.0
set ServerWebApplication=E:\BizagiProjects\PichinchaBPMExt\

set Result=false		
if %miip% == %ServerLan2% set Result=true
if %miip% == 10.160.93.19 set Result=true
if %miip% == 10.160.93.20 set Result=true
if %miip% == 10.160.93.21 set Result=true
if %miip% == 10.160.93.22 set Result=true


echo ------------------------------------------------------------------------------------------------------------
echo 10. Instalacion Configuracion Full PBM
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo        - Prerequisitos
echo              - Copia de carpeta %WebApplication%
echo              - Copia de carpeta %ServerWebApplication%
echo              - Reasignacion Permisos %WebApplication% usuario %Usuariobpm%
echo              - Reasignacion Permisos %ServerScheduler% usuario %Usuariobpm%
echo       - Creacion de Pool %VarAppCmd%
echo              - Cambiar propietario de Pool %VarAppCmd% por usuario %Usuariobpm%
echo              - Creacion de Web Aplication = %WebApplication%
echo              - Desbloquear httpCompression
echo              - Desbloquear ServerRuntime
echo              - Registrar Framework4
echo              - Reinicio IIS
echo       - Instalar Servicio Scheduler
echo       - Configurar Servicio Scheduler
echo              - Detener Servicio %NameScheduler%
echo              - Cambiar Propietario %NameScheduler%
echo              - Subir Servicio %NameScheduler%
echo              - Detener Servicio %NameOperation%
echo              - Subir Servicio %NameOperation%
echo              - Reinicio IIS
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul

if %miip% == %ServerLan1% (
			cls
			echo. 
			echo Instalacion de Servidor Principal %miip% 
			echo. 
			echo Seguir pasos de guia de implementacion de primer nodo de bpm 
			echo. 
			echo - Crear nuevo proyecto 
			echo    - Project Information 
			echo 		- 	Project Name: PichinchaBPMExt 
			echo 		-	Destination Folder: %BizagiProjects%
			echo 		-	Flap en Advanced datacase configuration 
			echo. 
			echo - Database Information 
			echo	- 	Server NAme: CLUSQLHABZIQA,1433
			echo	-	Database: PichinchaBPMExt  
			echo	-	Usuario: usr_bziadmin 
			echo	-	Password: ********* 
			echo. 
			echo - Validar IIS 
			echo	- 	Validar pool - cambiar identity = %Usuariobpm% 
			echo	-	Validar aplication 
			echo. 
			echo - Validar cadena conexion Base de Datos 
			echo 	-	"%ServerWebApplication%Web.config" 
			echo	- Buscar "--> " 
			echo 		-	"<add key="DSNDB" value="Current Language=us_english;Initial Catalog=PichinchaBPMExt;"  
			echo 		-	"DataSource=CLUSQLHABZIQA,1433;User ID=usr_bziadmin;Password=*************==;" />" 
			echo. 
			echo 		-	"<add key="PROVIDERTYPE" value="MSSqlClient" />" 
			echo.			 
			echo 		-	"<add mimeType="text/*" enabled="true" />" 
			echo 		-	"<add mimeType="message/*" enabled="true" />" 
			echo 		-	"<add mimeType="application/javascript" enabled="true" />" 
			echo 		-	"<add mimeType="application/json" enabled="true" />" 
			echo 		-	"<add mimeType="*/*" enabled="false" />" 
			echo.	 
			echo - Reinicio IIS 
			echo. 
			echo ************************************************************************************************************* 
			echo. 
			echo - URL Ingreso Servidor = "http://localhost/PichinchaBPMExt/" 
			echo - URL Ingreso Usuario = "http://%ServerLan1%/PichinchaBPMExt/" 
			echo. 
			Pause>Nul 
			goto :Menu
		) ELSE ( if "%Result%" == "true" (
							cls
							echo.
							echo ------------------------------------------------------------------------------------------------------------
							echo Inicia Proceso Instalacion Servidores Distibuidos IP: %miip%
							echo Oprima cualquier tecla para continuar
							echo ------------------------------------------------------------------------------------------------------------
							Pause>Nul
									Pause>Nul
									echo.
									echo Inicia Copia Carpeta Servicio %WebApplication%
									echo ----------------------------------------------------------------------------------------------------
									echo.
									xcopy %WebApplication% /s/e/f %ServerWebApplication% /Y
									echo.
									echo Reasignacion Permisos carpeta %WebApplication%
									echo.
									icacls %ServerWebApplication% /grant %Usuariobpm%:F
									Pause>Nul
									echo Oprima cualquier tecla para continuar
									echo.
									echo Se detiene servicio si existe: net stop %NameScheduler%
									echo.
									echo.
									Pause>Nul
									net stop %NameScheduler%
									echo.
									cls
							echo ------------------------------------------------------------------------------------------------------------
							echo Crear Pool: %NamePool%
							echo ------------------------------------------------------------------------------------------------------------
									echo.
									echo Oprima cualquier tecla para continuar
									Pause>Nul
									echo.
									%VarAppCmd% add apppool /name:"%NamePool%" /managedRuntimeVersion:"v4.0" /managedPipelineMode:"Integrated"
									echo.
									echo Se crea pool %NamePool%
									echo.
									echo Oprima cualquier tecla para continuar
									Pause>Nul
									echo.
									%VarPowerShell% -noprofile -executionpolicy bypass -file "%Instaladores1%\ps1\SetupPoolIIS.ps1" "%NamePool%" "%Usuariobpm%" "%PasswUserBpm%"
									echo.						
									echo se cambia propietario de pool %Usuariobpm%
									echo.
									echo Oprima cualquier tecla para continuar
									Pause>Nul
									echo.
									%VarAppCmd% stop apppool /apppool.name:"%NamePool%"
									echo.
									echo se detiene pool para tomar cambios
									echo.
									%VarAppCmd% start apppool /apppool.name:"%NamePool%"
									echo.
									echo se inicia pool
									echo Oprima cualquier tecla para continuar
									echo ----------------------------------------
									pause>Nul
									echo.
									cls
							echo ------------------------------------------------------------------------------------------------------------
							echo Crear Web Aplication
							echo Oprima cualquier tecla para continuar
							echo ------------------------------------------------------------------------------------------------------------
									Pause>Nul
									echo.
									echo Reasignacion Permisos Carpeta %BizagiProjects%
									echo.
									icacls "%BizagiProjects%" /grant %Usuariobpm%:F
									echo.
									echo Creacion de Web Aplication
									echo.
									echo Oprima cualquier tecla para continuar
									echo.
									Pause>Nul
									%VarAppCmd% add app /site.name:"Default Web Site" /path:/PichinchaBPMExt /physicalPath:"%ServerWebApplication%" /applicationPool:"%NamePool%"
									echo.
									echo Oprima cualquier tecla para continuar
									Pause>Nul
									echo.
									echo Desbloquear httpCompression
									echo.
									%VarAppCmd% unlock config -section:system.webServer/httpCompression
									echo.
									echo Oprima cualquier tecla para continuar
									echo.
									Pause>Nul
									echo Desbloquear ServerRuntime
									echo.
									%VarAppCmd% unlock config -section:system.webServer/ServerRuntime
									echo.
									echo Oprima cualquier tecla para continuar
									Pause>Nul
									echo.
									echo Registrar Framework4
									echo ----------------------------------------
									echo.
									C:\Windows\Microsoft.NET\Framework64\v4.0.30319\aspnet_regiis -i
									echo.
									echo Oprima cualquier tecla para continuar
									echo ----------------------------------------
									Pause>Nul
									echo.
									echo Reinicio IIS
									iisreset /restart
									echo.
									cls
							echo ------------------------------------------------------------------------------------------------------------
							echo Instalar Servicio Scheduler
							echo Oprima cualquier tecla para continuar
							echo ------------------------------------------------------------------------------------------------------------
								Pause>Nul
								echo.
										%ServerScheduler%\BizAgi_PichinchaBPMExt_Scheduler_Service_Install.bat
								echo ------------------------------------------------------------------------------------------------------------
								echo Configurar Servicio Scheduler
								echo Oprima cualquier tecla para continuar
								echo ------------------------------------------------------------------------------------------------------------
								echo.
								Pause>Nul
								net stop %NameScheduler%
								echo.
								sc.exe config "%NameScheduler%" obj=".\%Usuariobpm%" password="%PasswUserBpm%" start=auto
								echo.
								echo se cambia propietario %Usuariobpm%
								echo.
								echo %NameScheduler%
								echo %PasswUserBpm%
								pause
								net start %NameScheduler%
								echo.
								net stop "%NameOperation%"
								net start "%NameOperation%"
								echo ************************************************************************************************************
								echo Finalizo reinicio de Servicio %NameOperation%
								echo ************************************************************************************************************
								echo.
								echo Reinicio IIS
								iisreset /restart
								echo.
								echo ------------------------------------------------------------------------------------------------------------
								echo Finalizo inicio de servicio
								echo.
								echo Oprima cualquier tecla para continuar
								echo ------------------------------------------------------------------------------------------------------------
								Pause>Nul
							goto :Menu
						)
				)
echo Enter --: Para Salir
Pause>Nul
goto :Menu

:Decimoprimero
cls
set "var=%var*=%"
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set miip=%%b

SETLOCAL
set NameScheduler=BizAgiPichinchaBPMExtSchedulerService
set Result=false
set ServerLan1=10.160.88.68
set ServerLan2=10.160.88.69
set ServerApi1=10.160.75.15
set ServerApi2=10.160.75.16
set ServerWeb1=10.160.75.21
set ServerWeb2=10.160.75.22
set UsuarioBpm=bpmadmin
set Instaladores1=E:\Instaladores
set BizagiProjects=E:\BizagiProjects
set WebApplication=\\%ServerLan1%\BizagiProjects\PichinchaBPMExt
set ServerWebApplication=E:\BizagiProjects\PichinchaBPMExt\
set ServerScheduler=E:\BizagiProjects\
set Servicios="E:\Servicios\Documentacion Servicios\"
set ServerServicios=\\%ServerLan1%\WSDLServicios\*.*
							
if %miip% == %ServerLan2% set Result=true
if %miip% == 10.160.93.19 set Result=true
if %miip% == 10.160.93.20 set Result=true
if %miip% == 10.160.93.21 set Result=true
if %miip% == 10.160.93.22 set Result=true

echo ------------------------------------------------------------------------------------------------------------
echo 11. Copiar BizagiProjects
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - Copia de carpeta %WebApplication%
echo              - Reasignacion Permisos %WebApplication% Usuario %Usuariobpm%
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul

if %miip% == %ServerLan1% (
							echo.
							echo Solo aplica para servidores distribuidos
							echo.
							Pause>Nul
						goto :Menu
		) ELSE ( if "%Result%" == "true" (
							echo.
							echo ******************************************************************************************************************
							echo Inicia Proceso Instalacion Servidores Distibuidos IP: %miip%
							echo ******************************************************************************************************************
								Pause>Nul
								echo.
								echo Inicia Copia Carpeta Servicio %WebApplication%
								echo ----------------------------------------------------------------------------------------------------
								echo.
								xcopy %WebApplication% /c/e/f %ServerWebApplication% /Y
								echo.
								echo Reasignacion Permisos carpeta %WebApplication%
								echo.
								icacls %ServerWebApplication% /grant %Usuariobpm%:F
								Pause>Nul
								echo.
								echo Inicia Copia Carpeta Servicio %ServerServicios%
								echo ----------------------------------------------------------------------------------------------------
								echo.
								echo  %Servicios%
								echo  %ServerServicios%
								pause
								xcopy %ServerServicios% /c/e/f %Servicios% /Y
								echo.
								echo Reasignacion Permisos carpeta %Servicios%
								echo.
								icacls %Servicios% /grant %Usuariobpm%:F
								Pause>Nul
							echo ******************************************************************************************************************
							echo Fin Copia de Instalacion de archivos Distibuidos
							echo ******************************************************************************************************************
							echo Oprima cualquier tecla para continuar
							echo.
							Pause>Nul
							goto :Menu
						)
				)
Pause>Nul
goto :Menu

:Decimosegundo
cls
set Instaladores1=E:\Instaladores
set VarPowerShell=%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe
set VarAppCmd=%systemroot%\system32\inetsrv\APPCMD
set PasswUserBpm=A16CalidadC*2018
set UsuarioBpm=bpmadmin
set NamePool=Bizagi 64-Bit ASP.NET v4.0

echo ------------------------------------------------------------------------------------------------------------
echo 12. Creación de Pool
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - Creacion de Pool %VarAppCmd%
echo              - Cambiar propietario de Pool %VarAppCmd% por usuario %Usuariobpm%
echo              - Creacion de Web Aplication = %WebApplication%
echo              - Detener Pool %VarAppCmd%
echo              - Iniciar Pool %VarAppCmd%
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul

echo ************************************************************************************************************
echo Crear Pool
echo ************************************************************************************************************
echo.
%VarAppCmd% add apppool /name:"%NamePool%" /managedRuntimeVersion:"v4.0" /managedPipelineMode:"Integrated"
echo Se crea pool %NamePool%
echo.
Pause>Nul

%VarPowerShell% -noprofile -executionpolicy bypass -file "%Instaladores1%\ps1\SetupPoolIIS.ps1" "%NamePool%" "%Usuariobpm%" "%PasswUserBpm%"

echo se cambia propietario de pool %Usuariobpm%
echo.
Pause>Nul
echo.
%VarAppCmd% stop apppool /apppool.name:"%NamePool%"
echo.
echo se detiene pool para tomar cambios
%VarAppCmd% start apppool /apppool.name:"%NamePool%"
echo.
echo se inicia pool
Pause>Nul
Pause>Nul
goto :Menu

:Decimotercero
cls
set Instaladores1=E:\Instaladores
set UsuarioBpm=bpmadmin
set NamePool=Bizagi 64-Bit ASP.NET v4.0
set ServerWebApplication=E:\BizagiProjects\PichinchaBPMExt\WebApplication
set VarAppCmd=%systemroot%\system32\inetsrv\APPCMD

echo ------------------------------------------------------------------------------------------------------------
echo 13. Crear Web Aplication
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - Reasignacion Permisos carpeta %BizagiProjects%
echo              - Creacion de Web Aplication = %WebApplication%
echo              - Desbloquear httpCompression
echo              - Desbloquear ServerRuntime
echo              - Registrar Framework4
echo              - Reinicio IIS
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul

echo ************************************************************************************************************
echo Crear Web Aplication
echo ************************************************************************************************************
echo.
echo Reasignacion Permisos
echo.
icacls "%BizagiProjects%" /grant %Usuariobpm%:F
echo Creacion de Web Aplication
Pause>Nul
echo.
%VarAppCmd% add app /site.name:"Default Web Site" /path:/PichinchaBPMExt /physicalPath:"%ServerWebApplication%" /applicationPool:"%NamePool%"
Pause>Nul
echo.
echo Desbloquear httpCompression
%VarAppCmd% unlock config -section:system.webServer/httpCompression
Pause>Nul
echo.
echo Desbloquear httpCompression
%VarAppCmd% unlock config -section:system.webServer/ServerRuntime
Pause>Nul
echo.
echo Registrar Framework4
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\aspnet_regiis -i
Pause>Nul
echo.
echo Reinicio IIS
iisreset /restart
Pause>Nul
goto :Menu

:Decimocuarto
cls
set "var=%var*=%"
set ServerScheduler=E:\BizagiProjects\PichinchaBPMExt\Scheduler\

echo ------------------------------------------------------------------------------------------------------------
echo 14. Instalar Servicio Scheduler
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - Instalar Servicio Scheduler
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul

echo ************************************************************************************************************
echo Instalar Servicio Scheduler
echo ************************************************************************************************************
	%ServerScheduler%\BizAgi_PichinchaBPMExt_Scheduler_Service_Install.bat
Pause>Nul
goto :Menu

:Decimoquinto
cls
set "var=%var*=%"
set NameScheduler=BizAgiPichinchaBPMExtSchedulerService
set NameOperation=Bizagi Standard Server Operations Service
set PasswUserBpm=A16CalidadC*2018
set UsuarioBpm=bpmadmin

echo ------------------------------------------------------------------------------------------------------------
echo 15. Configurar Servicio Scheduler
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - Detener Servicio %NameScheduler%
echo              - Cambiar Propietario %NameScheduler%
echo              - Subir Servicio %NameScheduler%
echo              - Detener Servicio %NameOperation%
echo              - Subir Servicio %NameOperation%
echo              - Reinicio IIS
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul
echo ************************************************************************************************************
echo Configurar Servicio Scheduler
echo ************************************************************************************************************
echo.
net stop %NameScheduler%
echo Se deteniene servicio %NameScheduler%
echo.
sc.exe config "%NameScheduler%" obj=".\%Usuariobpm%" password="%PasswUserBpm%" start=auto
echo.
echo se cambia propietario %Usuariobpm%
echo.
net start %NameScheduler%
echo ************************************************************************************************************
echo Finalizo reinicio de Servicio %NameScheduler%
echo ************************************************************************************************************
echo.
net stop "%NameOperation%"
net start "%NameOperation%"
echo ************************************************************************************************************
echo Finalizo reinicio de Servicio %NameOperation%
echo ************************************************************************************************************
echo.
echo Reinicio IIS
iisreset /restart
echo ************************************************************************************************************
echo Finalizo reinicio de Servicio IIS
echo ************************************************************************************************************
echo.
echo ------------------------------------------------------------------------------------------------------------
echo Finalizo configuracion del Servicio
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo.
Pause>Nul
goto :Menu

:Decimosexto
cls
echo ------------------------------------------------------------------------------------------------------------
echo 16. Instalar certificado y https al sitio
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara:
echo              1. Instalar Puerto SSL
echo              2. Configurar Puerto HTTP
echo              v (V). Volver al Menu anterior
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
set /p var=
if %var%==1 goto :SetupHttps
if %var%==2 goto :SetupHttp
if %var%==v goto :Menu
if %var%==V goto :Menu
if %var%==q goto :exit
if %var%==Q goto :exit
if %var% GTR 0 echo Error
echo Enter --: Para Salir
Pause>Nul
goto :Decimosexto

:SetupHttps
cls
set Instaladores1=E:\Instaladores
set VarPowerShell=%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe
set SiteName1="Default Web Site"
set HostName1=""
set UAPWebBrowserUrl1=https://localhost
set SiteFolder1=%SystemDrive%\inetpub\wwwroot
set certPath1=E:\Instaladores\Certificate\SSL_Portal-Pichincha-BPM-Interno.pfx
set Protocolhtt1="https"
echo.
echo.
echo ------------------------------------------------------------------------------------------------------------
echo Configurar Puerto %Protocolhtt1%
echo ------------------------------------------------------------------------------------------------------------
echo.
set /p pfxPass1=Digite el password del ceritificado:
set /p PortSitehttps1=Digite el puerto (443, 8443, 9443) que va a instalar:
set /p Thumbprin2=Digite el hash del certificado a instalar sin los ":" = 

IF "%PortSitehttps1%"=="" (
echo El dato ingresado el puerto no debe ser en blanco
echo Oprima cualquier tecla para continuar
	) ELSE (
			IF "%pfxPass1%"=="" ( 
			set pfxPass1=%pfxPass1=%
			set PortSitehttps1=%PortSitehttps1=%
			echo El dato ingresado no debe ser en blanco
			Timeout /T 2 /NoBreak>nul
			goto digpasspfx
			Pause>Nul
			goto digpasspfx
			) ELSE (			
				IF "%Thumbprin2%"=="" (
				set pfxPass1=%pfxPass1=%
				set PortSitehttps1=%PortSitehttps1=%
				set Thumbprin2=%Thumbprin2=%
				echo El dato ingresado de la huella digital
				echo Oprima cualquier tecla para continuar
				goto digpasspfx
					) ELSE (
						%VarPowerShell%  -noprofile -executionpolicy bypass -file "%Instaladores1%\ps1\SetupSSL.ps1" %SiteName1% %HostName1% %pfxPass1% %UAPWebBrowserUrl1% %SiteFolder1% %certPath1% %Thumbprin2% %PortSitehttps1% %Protocolhtt1%
						)
					Goto Decimosexto
					)
				Goto Decimosexto
				)	
			Goto Decimosexto
		
:SetupHttp
cls
set Instaladores1=E:\Instaladores
set VarPowerShell=%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe
set SiteName1="Default Web Site"
set HostName1=""
set UAPWebBrowserUrl1=https://localhost
set SiteFolder1=%SystemDrive%\inetpub\wwwroot
set Protocolhtt1=http

echo.
echo ------------------------------------------------------------------------------------------------------------
echo Configurar Puerto %Protocolhtt1%
echo ------------------------------------------------------------------------------------------------------------
echo.
set /p PortSitehttps1=Digite el puerto (80, 8080, 9090) que va a instalar:

IF "%PortSitehttps1%"=="" (
	echo.
	echo El dato ingresado del puerto %Protocolhtt1% no debe ser en blanco
	echo.
	set PortSitehttps1=%PortSitehttps1=%
	echo Oprima cualquier tecla para continuar
	Pause>Nul
	goto Decimosexto
		) ELSE (
		echo.
		%VarPowerShell% -noprofile -executionpolicy bypass -file "%Instaladores1%\ps1\SetupHTTP.ps1" %SiteName1% %HostName1% %UAPWebBrowserUrl1% %SiteFolder1% %PortSitehttps1% %Protocolhtt1%
		)
Goto Menu
Pause>Nul
goto :Menu

:Decimoseptimo
cls
set "var=%var*=%"
echo ------------------------------------------------------------------------------------------------------------
echo 17. Vacio
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - 
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul
Pause>Nul
goto :Menu

:Decimooctavo
cls
set "var=%var*=%"
echo ------------------------------------------------------------------------------------------------------------
echo 18. Vacio
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - 
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul
Pause>Nul
goto :Menu

REM ************************************************************************************************************
REM Sección de solicitudes de Administracióin
REM ************************************************************************************************************



:Clavesbpmadmin
cls
set "var=%var*=%"
echo ------------------------------------------------------------------------------------------------------------
echo c (C). Cambiar clave usuario bpmadmin
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - Cambio de Clave usuario %UsuarioBpm%
echo              - Clave Anterior es %passwdant%
echo              - Se actuliza clave del archivo de Setup
echo              - Se actualiza clave de Pool %NamePool%
echo              - Se actualiza clave de Servicio %NameScheduler%
echo              - Se reinici IIS
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul
echo Modulo de cambio de password de usuarios locales de windows
echo ------------------------------------------------------------------------------------------------------------
setlocal EnableDelayedExpansion

		:Menuline
		set "var=%var*=%"
		set passwdant=A16CalidadC*2018
		set /p ditpasant=Digite el password anterior:
		set UsuarioBpm=bpmadmin
		if "%passwdant%"=="%ditpasant%" (
		  set var2=1
		  REM echo !var2!
		  goto Menupasswd
		)else (
			goto MenuReturn
			)
			:Menupasswd
			set "var=%var*=%"
			set NamePool=Bizagi 64-Bit ASP.NET v4.0
			set NameScheduler=BizAgiPichinchaBPMExtSchedulerService
			set VarPowerShell=%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe 
			set Instaladores1=E:\Instaladores
			set BizagiProjects=E:\BizagiProjects
			set /p ditpasnew=Digite el nuevo password:
				echo.
				net user %Usuariobpm%  %ditpasnew%
				echo Password del usuario %Usuariobpm% actualizado!
				echo Oprima cualquier tecla para continuar
				Pause>Nul
				echo.
				%VarPowerShell%  -file "%Instaladores1%\ps1\SetupPasswd.ps1" %passwdant% %ditpasnew%
				echo.
				echo Actualizado archivo con el nuevo password
				echo.
				%VarPowerShell% -noprofile -executionpolicy bypass -file "%Instaladores1%\ps1\SetupPoolIIS.ps1" "%NamePool%" "%Usuariobpm%" "%PasswUserBpm%"
				echo se actualiza contrasena del propietario pool %Usuariobpm%
				echo.
				echo ------------------------------------------------------------------------------------------------------------
				set PasswUserBpm=A16CalidadC*2018
				set UsuarioBpm=bpmadmin
				echo Configurar Servicio Scheduler
				echo ------------------------------------------------------------------------------------------------------------
				echo.
				net stop %NameScheduler%
				sc.exe config "%NameScheduler%" obj=".\%Usuariobpm%" password="%PasswUserBpm%" start=auto
				echo.
				echo se cambia propietario %Usuariobpm%
				echo.
				net start %NameScheduler%
				echo.
				echo ------------------------------------------------------------------------------------------------------------
				echo Reinicio IIS
				iisreset /restart
				echo ------------------------------------------------------------------------------------------------------------
				echo.
				echo ------------------------------------------------------------------------------------------------------------
				echo Verificar servicio en pagina. Que se abrira en instantes
				echo ------------------------------------------------------------------------------------------------------------
				start http://localhost/PichinchaBPMExt/
				start https://localhost/PichinchaBPMExt/
				echo ************************************************************************************************************
				echo Finalizo inicio de servicio
				Pause>Nul
				goto :Menu
			:MenuReturn 
			set "var=%var*=%"
				echo.
				echo password anterior incorrecto
				echo.
				goto :Menuline
Pause>Nul
goto :Menu

:PermisosCarpetas
cls
set "var=%var*=%"
set UsuarioBpm=bpmadmin
set ServerLan1=10.160.88.68
set Instaladores1=E:\Instaladores
set BizagiProjects=E:\BizagiProjects
set WebApplication=\\%ServerLan1%\BizagiProjects\PichinchaBPMExt\WebApplication\*.*
set Scheduler=\\%ServerLan1%\BizagiProjects\PichinchaBPMExt\Scheduler\*.*
set ServerWebApplication=E:\BizagiProjects\PichinchaBPMExt\WebApplication\
set ServerScheduler=E:\BizagiProjects\PichinchaBPMExt\Scheduler\
set DefaultWebSite=

echo ------------------------------------------------------------------------------------------------------------
echo p (P). Actualizar permisos de Carpetas de BizAgi
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - Se actualiza permisos carpeta %Instaladores1%
echo              - Se actualiza permisos carpeta %BizagiProjects%
echo              - Se actualiza permisos carpeta %ServerWebApplication%
echo              - Se actualiza permisos carpeta %ServerScheduler%
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul
		
		icacls "%Instaladores1%" /grant %Usuariobpm%:F
		echo Reasignacion Permisos Carpeta Instaladores
		echo.
		Pause>Nul
		
		icacls "%BizagiProjects%" /grant %Usuariobpm%:F								
		echo Reasignacion Permisos de Carpeta BizagiProjects
		echo.
		Pause>Nul		
		
		icacls %ServerWebApplication% /grant %Usuariobpm%:F
		echo Reasignacion Permisos de Carpeta WebApplication
		echo.
		Pause>Nul
		
		icacls %ServerScheduler% /grant %Usuariobpm%:F
		echo Reasignacion Permisos de Carpeta Scheduler
		echo.
		Pause>Nul
Pause>Nul
goto :Menu

:RutaEstatica
cls
set "var=%var*=%"
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set miip=%%b

SETLOCAL
set ServerLan1=10.160.88.68
set ServerLan2=10.160.88.69
set ServerApi1=10.160.75.15
set ServerApi2=10.160.75.16
set ServerWeb1=10.160.75.21
set ServerWeb2=10.160.75.22
set VLAN=10.160.75.1

if %miip% == %ServerLan2% set Result=true
if %miip% == 10.160.93.19 set Result=true
if %miip% == 10.160.93.20 set Result=true
if %miip% == 10.160.93.21 set Result=true
if %miip% == 10.160.93.22 set Result=true

echo ------------------------------------------------------------------------------------------------------------
echo r (R). Crear Ruta Estatica. Solo para los servidores Distribuidos
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - Se crea ruta estatica servidores distribuidos
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul

if %miip% == %ServerLan1% (
			echo.
			echo Instalacion de servidores distribuidos mi ip es: %miip%
			echo ************************************************************************************************************
			echo No es necesario crear ruta estatica para este servidor esta en la misma VLAN
			echo.
			echo Enter para volver al -- Menu
			echo ************************************************************************************************************
			Pause>Nul
			goto :Menu
		) ELSE ( if "%Result%" == "true" (
							echo.
							echo Instalacion de servidores distribuidos mi ip es: %miip%
							echo Solicitar permiso a seguridad informatica
							echo -------------------------------------------------------------------------------------------------------------
							echo Origen        - Destino       - Puerto      -  Descripcion
							echo -------------------------------------------------------------------------------------------------------------
							echo %ServerApi1%  - %ServerLan1%  - TCP/UDP 445 -  Acceso despliegues distribuidos BPM
							echo %ServerApi2%  - %ServerLan1%  - TCP/UDP 445 -  Acceso despliegues distribuidos BPM
							echo %ServerWeb1%  - %ServerLan1%  - TCP/UDP 445 -  Acceso despliegues distribuidos BPM
							echo %ServerWeb2%  - %ServerLan1%  - TCP/UDP 445 -  Acceso despliegues distribuidos BPM
							echo -------------------------------------------------------------------------------------------------------------
							echo.
							echo ************************************************************************************************************
								if %miip% == %ServerLan2% ( echo No es necesario crear ruta estatica para este servidor esta en la misma VLAN 
								)else (route -p add %ServerLan1% mask 255.255.255.255 %VLAN%)
							echo ************************************************************************************************************
							echo.
							echo Enter para volver al -- Menu
							echo.
							Pause>Nul
						)
				)
Pause>Nul
goto :Menu

:UnistallScheduler
cls
set SiteName1="Default Web Site"
set "var=%var*=%"
set NameScheduler=BizAgiPichinchaBPMExtSchedulerService
set ServerScheduler=E:\BizagiProjects\PichinchaBPMExt\Scheduler\

echo ------------------------------------------------------------------------------------------------------------
echo u (U). Desinstalar Servicio Scheduler
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - Se desinstala servicio %NameScheduler%
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul
echo u (U). Desinstalar Servicio Scheduler
echo ------------------------------------------------------------------------------------------------------------
echo.
net stop %NameScheduler%
echo.
%ServerScheduler%\BizAgi_PichinchaBPMExt_Scheduler_Service_UnInstall.bat
Pause>Nul
goto :Menu


:ReinicioServicios
cls
set "var=%var*=%"
set cacheurl=http://localhost/PichinchaBPMExt/webservices/cache.asmx
set NameScheduler=BizAgiPichinchaBPMExtSchedulerService
set NameOperation="Bizagi Standard Server Operations Service"
echo ------------------------------------------------------------------------------------------------------------
echo  i (I). Reinicio IIS y Scheduler
echo ------------------------------------------------------------------------------------------------------------
echo Acciones a Realizar:
echo              - Reinicio de IIS
echo              - Reinicio servicio %NameScheduler%
echo              - Limpieza de Cache %cacheurl%
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
echo Inicia reinicio IIS ...
echo.
		iisreset /restart
echo.
echo fin reinicio IIS
echo ------------------------------------------------------------------------------------------------------------
echo.
echo Inicia reinicio Servicio %NameOperation% y %NameScheduler%...
echo Oprima cualquier tecla para continuar
Pause>Nul	
echo.
		net stop %NameOperation%
	    net start %NameOperation%
echo ------------------------------------------------------------------------------------------------------------
echo.
echo Inicia reinicio Servicio %NameScheduler% ...
		net stop "%NameScheduler%"
		net start "%NameScheduler%"
echo ------------------------------------------------------------------------------------------------------------
echo Finalizo reinicio de Servicio %NameScheduler% y %NameOperation%
echo.
echo Inicia Limpieza Cache Automatica del Sitio PichinchaBPMExt
echo Oprima cualquier tecla para continuar
echo ------------------------------------------------------------------------------------------------------------
Pause>Nul
echo.
start http://localhost/PichinchaBPMExt/webservices/cache.asmx/CleanRenderCache
start http://localhost/PichinchaBPMExt/webservices/cache.asmx/CleanTracing
start http://localhost/PichinchaBPMExt/webservices/cache.asmx/ReleaseLocalizationResources
start http://localhost/PichinchaBPMExt/webservices/cache.asmx/UpdatePortal
start http://localhost/PichinchaBPMExt/webservices/cache.asmx/cleanParameters
start http://localhost/PichinchaBPMExt/webservices/cache.asmx/cleanUpRuleCache
echo Finalizo Limpieza Cache Automatica del Sitio PichinchaBPMExt
echo ------------------------------------------------------------------------------------------------------------
echo.
echo Inicia Limpieza Cache parametrica del Sitio PichinchaBPMExt
echo Oprima cualquier tecla para continuar
Pause>Nul
echo.------------------------
echo Parameter  -  Value
echo ------------------------
echo sPrefix:   -   *       -
echo sKey:      -   *       -
echo ------------------------
echo clic en invoke
start http://localhost/PichinchaBPMExt/webservices/cache.asmx?op=CleanUpCache
echo Finalizo Limpieza Cache parametrica del Sitio PichinchaBPMExt
Pause>Nul
goto :Menu

:BorrarTemporales
cls
echo ------------------------------------------------------------------------------------------------------------
echo  z (Z). Detener Servicios IIS y Scheduler  
echo ------------------------------------------------------------------------------------------------------------
echo.
echo Borrar el contenido de las siguientes carpetas:
echo    - C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Temporary ASP.NET Files
echo    - E:\BizagiProjects\PichinchaBPMExt\EntityManager\
echo    - E:\BizagiProjects\PichinchaBPMExt\ComponentLibrary\
echo    - E:\BizagiProjects\PichinchaBPMExt\SOA\
Pause>Nul

echo -------------------------------------------------------------------------------------
echo 1. Detener Servicios 
echo ------------------------------------------------------------------------------------------------------------
echo.
echo Acciones a Realizar:
echo              - Detener Servicio de IIS
echo              - Detener servicio %NameScheduler%
echo              - Detener de Cache %cacheurl%
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
echo Detener de Servicio IIS ...
echo.
		iisreset /stop
echo.
echo ------------------------------------------------------------------------------------------------------------
echo Servicio IIS Detenido...
echo.
echo Oprima cualquier tecla para Detener Servicios:
echo.
echo    -  %NameOperation% 
echo    -  %NameScheduler%
echo ------------------------------------------------------------------------------------------------------------
Pause>Nul	
echo.
		net stop %NameOperation%
echo.
echo Detener Servicio %NameScheduler% ...
		net stop "%NameScheduler%"		
echo Oprima cualquier tecla para continuar
echo.
echo Finalizo Detener de Servicio. Oprima cualquier tecla para continuar
echo ------------------------------------------------------------------------------------------------------------

		set folder="E:\BizagiProjects\PichinchaBPMExt\SOA\"
		cd /d %folder%
		for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)
		dir

		set folder="E:\BizagiProjects\PichinchaBPMExt\Temporary\"
		cd /d %folder%
		for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)
		dir

		set folder="E:\BizagiProjects\PichinchaBPMExt\EntityManager\"
		cd /d %folder%
		for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)
		dir

		set folder="E:\BizagiProjects\PichinchaBPMExt\ComponentLibrary\"
		cd /d %folder%
		for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)
		dir

		set folder="C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Temporary ASP.NET Files\"
		cd /d %folder%
		for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)
		dir
	
Pause>Nul
goto :Menu

:DetenerServicios
cls
set "var=%var*=%"
set cacheurl=http://localhost/PichinchaBPMExt/webservices/cache.asmx
set NameScheduler=BizAgiPichinchaBPMExtSchedulerService
set NameOperation="Bizagi Standard Server Operations Service"
echo ------------------------------------------------------------------------------------------------------------
echo  z (Z). Detener Servicios IIS y Scheduler  
echo ------------------------------------------------------------------------------------------------------------
echo Acciones a Realizar:
echo              - Detener Servicio de IIS
echo              - Detener servicio %NameScheduler%
echo              - Detener de Cache %cacheurl%
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
echo Detener de Servicio IIS ...
echo.
		iisreset /stop
echo.
echo fin stop IIS
echo.
echo Detener Servicio %NameOperation% y %NameScheduler%...
echo Oprima cualquier tecla para continuar
echo ------------------------------------------------------------------------------------------------------------
Pause>Nul	
echo.
		net stop %NameOperation%
echo.
echo Detener Servicio %NameScheduler% ...
echo.
		net stop "%NameScheduler%"
echo.
echo Oprima cualquier tecla para continuar
echo ------------------------------------------------------------------------------------------------------------
Pause>Nul
goto :Menu


:SubirServicios
cls
set "var=%var*=%"
set cacheurl=http://localhost/PichinchaBPMExt/webservices/cache.asmx
set NameScheduler=BizAgiPichinchaBPMExtSchedulerService
set NameOperation="Bizagi Standard Server Operations Service"
echo ------------------------------------------------------------------------------------------------------------
echo   s (S). Subir Servicios IIS y Scheduler 
echo ------------------------------------------------------------------------------------------------------------
echo Acciones a Realizar:
echo              - Inicio de IIS
echo              - Inicio servicio %NameScheduler%
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
echo Inicia Servicio IIS ...
echo.
		iisreset /start
echo.
echo fin Inicio IIS
echo.
echo Inicio Servicio %NameOperation% y %NameScheduler%...
echo Oprima cualquier tecla para continuar
echo ------------------------------------------------------------------------------------------------------------
Pause>Nul	
echo.
		net start %NameOperation%
echo.
echo Inicio Servicio %NameScheduler% ...
echo.
		net start "%NameScheduler%"
echo.
echo Oprima cualquier tecla para continuar
echo ------------------------------------------------------------------------------------------------------------
Pause>Nul
goto :Menu

:UnistallCertificado
cls
cls
set Instaladores1=E:\Instaladores
set VarPowerShell=%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe
set SiteName1="Default Web Site"
set HostName1=""
set UAPWebBrowserUrl1=https://localhost
set SiteFolder1=%SystemDrive%\inetpub\wwwroot
set certPath1=E:\Instaladores\Certificate\SSL_Portal-Pichincha-BPM-Interno.pfx
echo.
echo.
echo ------------------------------------------------------------------------------------------------------------
echo Desinstalar Certificado %Protocolhtt1% del sitio %SiteName1%
echo ------------------------------------------------------------------------------------------------------------
set /p Protocolhtt1=Digite http o https que va a desinstalar:
echo.
set /p PortSitehttps1=Digite el puerto desinstalar (80, 443, 8080, 8443):

IF "%Protocolhtt1%"=="" (
	echo.
	echo El dato ingresado del protolo no debe ser en blanco
	set PortSitehttps1=%PortSitehttps1=%
	echo.
	echo Oprima cualquier tecla para continuar
	Pause>Nul
	goto UnistallCertificado
		) ELSE (
		IF "%PortSitehttps1%"=="" (
			echo.
			echo El dato ingresado del puerto no debe ser en blanco
			set Protocolhtt1=%Protocolhtt1=%
			set PortSitehttps1=%PortSitehttps1=%
			echo.
			echo Oprima cualquier tecla para continuar
			Pause>Nul
			goto UnistallCertificado
				) ELSE (
							%VarPowerShell%  -noprofile -executionpolicy bypass -file "%Instaladores1%\ps1\UnistallSSL.ps1" %SiteName1% %Protocolhtt1% %PortSitehttps1%
						)
					goto Menu
					)
				goto Menu
Pause>Nul
goto :Menu

:EstadosServicios
cls
set "var=%var*=%"
set NameScheduler=BizAgiPichinchaBPMExtSchedulerService
set NameOperation=Bizagi Standard Server Operations Service
set NameIIS=IISADMIN
set VarPowerShell=%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe
echo ------------------------------------------------------------------------------------------------------------
echo Informacion de los sitios Publicados
	%VarPowerShell%  Get-Website
	%VarPowerShell%  Get-WebApplication 
	sc interrogate "%NameScheduler%"
echo ------------------------------------------------------------------------------------------------------------
	sc interrogate "%NameOperation%"
echo ------------------------------------------------------------------------------------------------------------
	sc interrogate "%NameIIS%"
echo ...
echo Finalizo Validacion estados Servicios. Oprima cualquier tecla para continuar
Pause>Nul
goto :Menu

REM ************************************************************************************************************
REM Sección de Despliegues
REM ************************************************************************************************************

:ActualizarData
cls
set "var=%var*=%"
color F1
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set miip=%%b
set ServerLan1=10.160.88.68
set ServerLan2=10.160.88.69
set ServerApi1=10.160.75.15
set ServerApi2=10.160.75.16
set ServerWeb1=10.160.75.21
set ServerWeb2=10.160.75.22
set ServerApi1prod=10.160.93.19
set ServerApi2prod=10.160.93.20
set ServerWeb1prod=10.160.93.21
set ServerWeb2prod=10.160.93.22
set PasswUserBpm=A16CalidadC*2018
set VarPowerShell=%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe 
set Instaladores1=E:\Instaladores
set UsuarioBpm=bpmadmin
set VLAN=10.160.75.1

if %miip% == %ServerLan2% set Result=true
if %miip% == 10.160.93.19 set Result=true
if %miip% == 10.160.93.20 set Result=true
if %miip% == 10.160.93.21 set Result=true
if %miip% == 10.160.93.22 set Result=true

echo.
echo   -------------------------------------------------------------------------------------------------------------------
echo   -   a (A). Actualizar IPS del ejecutable	
echo   -------------------------------------------------------------------------------------------------------------------
echo    1. Actualizar contrasena de Usuario bpmadmin
echo   -------------------------------------------------------------------------------------------------------------------
echo    2. Servidores LAN
echo   -------------------------------------------------------------------------------------------------------------------
echo              - servidor Principal = %ServerLan1%
echo              - Servidor Intranet 2 = %ServerLan2%
echo   -------------------------------------------------------------------------------------------------------------------
echo    3. Servidores DMZ Gestion
echo   -------------------------------------------------------------------------------------------------------------------
echo              - Servidor Servidor Api 1 - Gestion = %ServerApi1%
echo              - Servidor Servidor Api 2 - Gestion = %ServerApi2%
echo              - Servidor Servidor Web 1 - Gestion = %ServerWeb1%
echo              - Servidor Servidor Web 2 - Gestion = %ServerWeb2%
echo   -------------------------------------------------------------------------------------------------------------------
echo    4. Servidores DMZ Produccion
echo   -------------------------------------------------------------------------------------------------------------------
echo              - Servidor Servidor Api 1 - Produccion = %ServerApi1prod%
echo              - Servidor Servidor Api 2 - Produccion = %ServerApi2prod%
echo              - Servidor Servidor Web 1 - Produccion = %ServerWeb1prod%
echo              - Servidor Servidor Web 2 - Produccion = %ServerWeb2prod%
echo   -------------------------------------------------------------------------------------------------------------------
echo    5. Actualizacion Masiva de IPS y Contrasenas
echo   -------------------------------------------------------------------------------------------------------------------
echo   -   V. Volver al Menu anterior
echo   -   Enter para Salir
echo   -   CTRL + C para detener ejecutable
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar

set /p var=
if %var%==1 goto :uno
if %var%==2 goto :dos
if %var%==3 goto :tres
if %var%==4 goto :cuatro
if %var%==5 goto :cinco
if %var%==v goto :Menu
if %var%==V goto :Menu
if %var%==q goto :exit
if %var%==Q goto :exit
if %var% GTR 0 echo Error
echo Enter --: Para Salir
Pause>Nul
goto :ActualizarData

:uno
cls
set "var=%var*=%"
echo.
set PasswUserBpm=A16CalidadC*2018
set UsuarioBpm=bpmadmin
set Instaladores1=E:\Instaladores
echo ------------------------------------------------------------------------------------------------------------
echo  1. Actualizar contrasena de Usuario bpmadmin
echo ------------------------------------------------------------------------------------------------------------
echo Acciones a Realizar:
echo              - Cambio de contrasena archivo setup
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
		echo.
		echo contrasena anterior es = %PasswUserBpm%
		echo.
				set /p PasswUserBpmNew=Digite el password anterior:
		if "%PasswUserBpm%"=="%PasswUserBpmNew%" (
		  set var2=1
		  REM echo !var2!
		  goto MenuActualizaPasswd
		)else (
			echo la contrasena no es la misma. Verifique la contrasena en el archivo SetupBizAgi.bat
			Pause>Nul
			goto uno
			)
			:MenuActualizaPasswd
			echo.
				set /p ditpasnew=Digite el nuevo password:
				IF "%ditpasnew%"=="" ( 
					Timeout /T 2 /NoBreak>nul
					echo El dato ingresado no debe ser nulo
					Pause>Nul
					goto uno 
				) ELSE (
				echo.
					echo.
					IF "%ditpasnew%"=="%PasswUserBpm%" ( 
					Timeout /T 2 /NoBreak>nul
					echo.
					echo El dato ingresado no el mismo que el anterior
					echo.
					Pause>Nul
					goto MenuActualizaPasswd 
					) ELSE (
					echo Se procede a actualizar el archivo:
					%VarPowerShell%  -file "%Instaladores1%\ps1\UpdateUsu.ps1" %PasswUserBpm% %ditpasnew%
					echo Actualizado archivo con el nuevo password
					echo.
					Pause>Nul
					echo.
					echo Enter cualquier tecla para continuar o CTRL + C para finalizar
					Pause>Nul
					Pause>Nul
					goto :ActualizarData
				)
			)
:dos
cls
echo.
echo    - Camnios de IPS Servidores LAN
echo.
echo ------------------------------------------------------------------------------------------------------------
echo  1. Cambiar IP Intranet 1
echo  2. Cambiar IP Intranet 2
echo  v. Volver al Menu Anterior
echo ------------------------------------------------------------------------------------------------------------
echo   -   Escribe un Numero del menu y Presione Enter:                                                                  -

set /p var=
if %var%==1 goto :MenuIPIntra1
if %var%==2 goto :MenuIPIntra2
if %var%==v goto :ActualizarData
if %var%==V goto :ActualizarData
if %var%==q goto :exit
if %var%==Q goto :exit
if %var% GTR 0 echo Error

Pause>Nul
goto :dos

for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set miip=%%b
set ServerLan1=10.160.88.68
set ServerLan2=10.160.88.69
set VarPowerShell=%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe 
set Instaladores1=E:\Instaladores


:MenuIPIntra1
set "var=%var*=%"
set ServerLan1=10.160.88.68
echo la IP servidor intranet 1 = %ServerLan1%
set /p ServerLan1new=Digita Nueva IP Servidor Principal:

IF "%ServerLan1new%"=="" ( 
    echo El dato ingresado no debe ser en blanco
    Timeout /T 2 /NoBreak>nul
    goto dos
) ELSE (
			echo.
			echo la IP servidor intranet 1 = %ServerLan1%
			echo.
			:MenuIPLan1
			cls
			set "var=%var*=%"
			IF "%ServerLan1%"=="%ServerLan1new%" ( 
					Timeout /T 1 /NoBreak>nul
					echo.
					echo El dato ingresado no debe ser igual
					echo.
					Pause>Nul
					goto dos 
					) ELSE (
					echo.
					%VarPowerShell%  -file "%Instaladores1%\ps1\UpdateServIntr1.ps1" %ServerLan1% %ServerLan1new%
					echo.
					echo Finalizo actualizacion del archivo
					echo.
					Pause>Nul
					echo.
					echo Enter cualquier tecla para continuar o CTRL + C para finalizar
					Pause>Nul
					Goto :dos
					)
		Goto dos
)
Goto ActualizarData

:MenuIPIntra2
set "var=%var*=%"
set ServerLan2=10.160.88.69
echo la IP ServerLan2new intranet 2 = %ServerLan2%
set /p ServerLan2new=Digita Nueva IP Servidor Intranet 2:

IF "%ServerLan2new%"=="" ( 
    echo El dato ingresado no debe ser en blanco
    Timeout /T 2 /NoBreak>nul
    goto dos
) ELSE (
			echo.
			echo la IP servidor intranet 2 = %ServerLan2%
			echo.
			:MenuIPLan2
			cls
			set "var=%var*=%"
			IF "%ServerLan2%"=="%ServerLan2new%" ( 
					Timeout /T 1 /NoBreak>nul
					echo.
					echo El dato ingresado no debe ser igual
					echo.
					Pause>Nul
					goto dos 
					) ELSE (
					echo.
					%VarPowerShell%  -file "%Instaladores1%\ps1\UpdateServIntr1.ps1" %ServerLan2% %ServerLan2new%
					echo.
					echo Finalizo actualizacion del archivo
					echo.
					Pause>Nul
					echo.
					echo Enter cualquier tecla para continuar o CTRL + C para finalizar
					Pause>Nul
					Goto dos
					)
		Goto dos
)

goto :ActualizarData

:tres
cls
set "var=%var*=%"
echo.
echo    - Camnios de IPS Servidores DMZ Gestion
echo.
echo ------------------------------------------------------------------------------------------------------------
echo  1. Cambiar IP DMZ Gestion 1: ServerApi1 = %ServerApi1%
echo  2. Cambiar IP DMZ Gestion 2: ServerApi2 = %ServerApi2%
echo  3. Cambiar IP DMZ Gestion 3: ServerWeb1 = %ServerWeb1%
echo  4. Cambiar IP DMZ Gestion 4: ServerWeb2 = %ServerWeb2%
echo  v. Volver al Menu Anterior
echo ------------------------------------------------------------------------------------------------------------
echo   -   Escribe un Numero del menu y Presione Enter:                                                                  -

set /p var=
if %var%==1 goto :MenuIPDmzG1
if %var%==2 goto :MenuIPDmzG2
if %var%==2 goto :MenuIPDmzG3
if %var%==2 goto :MenuIPDmzG4
if %var%==v goto :ActualizarData
if %var%==V goto :ActualizarData
if %var%==q goto :exit
if %var%==Q goto :exit
if %var% GTR 0 echo Error

Pause>Nul
goto :tres

for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set miip=%%b
set ServerApi1=10.160.75.15
set ServerApi2=10.160.75.16
set ServerWeb1=10.160.75.21
set ServerWeb2=10.160.75.22
set VarPowerShell=%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe 
set Instaladores1=E:\Instaladores


:MenuIPDmzG1
set "var=%var*=%"
set ServerApi1=10.160.75.15
echo la IP ServerApi1 = %ServerApi1%
set /p ServerApi1new=Digita Nueva IP Servidor Servidor Api 1 - Gestion:

IF "%ServerApi1new%"=="" ( 
    echo El dato ingresado no debe ser en blanco
    Timeout /T 2 /NoBreak>nul
    goto tres
) ELSE (
			echo.
			echo la IP servidor api 1 = %ServerApi1%
			echo.
			:MenuIPDmzIntG1
			cls
			set "var=%var*=%"
			IF "%ServerApi1%"=="%ServerApi1new%" ( 
					Timeout /T 1 /NoBreak>nul
					echo.
					echo El dato ingresado no debe ser igual
					echo.
					Pause>Nul
					goto tres 
					) ELSE (
					echo.
					%VarPowerShell%  -file "%Instaladores1%\ps1\UpdateServGest1.ps1" %ServerApi1% %ServerApi1new%
					echo.
					echo Finalizo actualizacion del archivo
					echo.
					Pause>Nul
					echo.
					echo Enter cualquier tecla para continuar o CTRL + C para finalizar
					Pause>Nul
					Goto :tres
					)
		Goto ActualizarData
)
Goto ActualizarData

:MenuIPDmzG2
set "var=%var*=%"
set ServerApi2=10.160.75.16
echo la IP ServerApi2=10.160.75.16
set /p ServerApi2new=Digita Nueva IP Servidor Servidor Api 2 - Gestion:
IF "%ServerApi2new%"=="" ( 
    echo El dato ingresado no debe ser en blanco
    Timeout /T 2 /NoBreak>nul
    goto tres
) ELSE (
			echo.
			echo la IP servidor api 2 = %ServerApi2%
			echo.
			:MenuIPDmzIntG2
			cls
			set "var=%var*=%"
			IF "%ServerApi2%"=="%ServerApi2new%" ( 
					Timeout /T 1 /NoBreak>nul
					echo.
					echo El dato ingresado no debe ser igual
					echo.
					Pause>Nul
					goto tres 
					) ELSE (
					echo.
					%VarPowerShell%  -file "%Instaladores1%\ps1\UpdateServGest2.ps1" %ServerApi2% %ServerApi2new%
					echo.
					echo Finalizo actualizacion del archivo
					echo.
					Pause>Nul
					echo.
					echo Enter cualquier tecla para continuar o CTRL + C para finalizar
					Pause>Nul
					Goto :tres
					)
		Goto ActualizarData
)
Goto ActualizarData

:MenuIPDmzG3
set "var=%var*=%"
set ServerWeb1=10.160.75.21
echo la IP ServerWeb1 = %ServerWeb1%
set /p ServerWeb1new=Digita Nueva IP Servidor Servidor Web 1 - Gestion:
IF "%ServerWeb1new%"=="" ( 
    echo El dato ingresado no debe ser en blanco
    Timeout /T 2 /NoBreak>nul
    goto tres
) ELSE (
			echo.
			echo la IP servidor web 1 = %ServerWeb1%
			echo.
			:MenuIPDmzIntG3
			cls
			set "var=%var*=%"
			IF "%ServerWeb1%"=="%ServerWeb1new%" ( 
					Timeout /T 1 /NoBreak>nul
					echo.
					echo El dato ingresado no debe ser igual
					echo.
					Pause>Nul
					goto tres 
					) ELSE (
					echo.
					%VarPowerShell%  -file "%Instaladores1%\ps1\UpdateServGest3.ps1" %ServerWeb1% %ServerWeb1new%
					echo.
					echo Finalizo actualizacion del archivo
					echo.
					Pause>Nul
					echo.
					echo Enter cualquier tecla para continuar o CTRL + C para finalizar
					Pause>Nul
					Goto :tres
					)
		Goto ActualizarData
)
Goto ActualizarData

:MenuIPDmzG4
set "var=%var*=%"
set ServerWeb2=10.160.75.22
echo la IP ServerWeb2  = %ServerWeb2%
set /p ServerWeb2new=Digita Nueva IP Servidor Servidor Web 2 - Gestion:
IF "%ServerWeb2new%"=="" ( 
    echo El dato ingresado no debe ser en blanco
    Timeout /T 2 /NoBreak>nul
    goto tres
) ELSE (
			echo.
			echo la IP servidor Web 2= %ServerWeb2%
			echo.
			:MenuIPDmzIntG4
			cls
			set "var=%var*=%"
			IF "%ServerWeb2%"=="%ServerWeb2new%" ( 
					Timeout /T 1 /NoBreak>nul
					echo.
					echo El dato ingresado no debe ser igual
					echo.
					Pause>Nul
					goto tres 
					) ELSE (
					echo.
					%VarPowerShell%  -file "%Instaladores1%\ps1\UpdateServGest4.ps1" %ServerWeb2% %ServerWeb2new%
					echo.
					echo Finalizo actualizacion del archivo
					echo.
					Pause>Nul
					echo.
					echo Enter cualquier tecla para continuar o CTRL + C para finalizar
					Pause>Nul
					Goto :tres
					)
		Goto ActualizarData
)

Goto ActualizarData

:cuatro
cls
set "var=%var*=%"
echo.
echo    - Camnios de IPS Servidores DMZ Gestion
echo.
echo ------------------------------------------------------------------------------------------------------------
echo  1. Cambiar IP DMZ Produccion 1: ServerApi1prod = %ServerApi1prod%
echo  2. Cambiar IP DMZ Produccion 2: ServerApi2prod = %ServerApi2prod%
echo  3. Cambiar IP DMZ Produccion 3: ServerWeb1prod = %ServerWeb1prod%
echo  4. Cambiar IP DMZ Produccion 4: ServerWeb2prod = %ServerWeb2prod%
echo  v. Volver al Menu Anterior
echo ------------------------------------------------------------------------------------------------------------
echo   -   Escribe un Numero del menu y Presione Enter:                                                                  -

set /p var=
if %var%==1 goto :MenuIPDmzP1
if %var%==2 goto :MenuIPDmzP2
if %var%==2 goto :MenuIPDmzP3
if %var%==2 goto :MenuIPDmzP4
if %var%==v goto :ActualizarData
if %var%==V goto :ActualizarData
if %var%==q goto :exit
if %var%==Q goto :exit
if %var% GTR 0 echo Error

Pause>Nul
goto :cuatro

set ServerApi1prod=10.160.93.19
set ServerApi2prod=10.160.93.20
set ServerWeb1prod=10.160.93.21
set ServerWeb2prod=10.160.93.22
set VarPowerShell=%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe 
set Instaladores1=E:\Instaladores

:MenuIPDmzP1
set "var=%var*=%"
set ServerApi1prod=10.160.93.19
echo la IP ServerApi1prod = %ServerApi1prod%
set /p ServerApi1newpro=Digita Nueva IP Servidor Servidor Api 1 - Produccion:

IF "%ServerApi1newpro%"=="" ( 
    echo El dato ingresado no debe ser en blanco
    Timeout /T 2 /NoBreak>nul
    goto cuatro
) ELSE (
			echo.
			echo la IP servidor api 1 = %ServerApi1prod%
			echo.
			:MenuIPDmzIntP1
			cls
			set "var=%var*=%"
			IF "%ServerApi1prod%"=="%ServerApi1newpro%" ( 
					Timeout /T 1 /NoBreak>nul
					echo.
					echo El dato ingresado no debe ser igual
					echo.
					Pause>Nul
					goto cuatro 
					) ELSE (
					echo.
					%VarPowerShell%  -file "%Instaladores1%\ps1\UpdateServProd1.ps1" %ServerApi1prod% %ServerApi1newpro%
					echo.
					echo Finalizo actualizacion del archivo
					echo.
					Pause>Nul
					echo.
					echo Enter cualquier tecla para continuar o CTRL + C para finalizar
					Pause>Nul
					Goto :cuatro
					)
		Goto ActualizarData
)
Goto ActualizarData

:MenuIPDmzP2
set "var=%var*=%"
set ServerApi2prod=10.160.93.20
echo la IP ServerApi2prod=10.160.75.16
set /p ServerApi2newpro=Digita Nueva IP Servidor Servidor Api 2 - Produccion:
IF "%ServerApi2newpro%"=="" ( 
    echo El dato ingresado no debe ser en blanco
    Timeout /T 2 /NoBreak>nul
    goto cuatro
) ELSE (
			echo.
			echo la IP servidor api 2 = %ServerApi2prod%
			echo.
			:MenuIPDmzIntP2
			cls
			set "var=%var*=%"
			IF "%ServerApi2prod%"=="%ServerApi2newpro%" ( 
					Timeout /T 1 /NoBreak>nul
					echo.
					echo El dato ingresado no debe ser igual
					echo.
					Pause>Nul
					goto cuatro 
					) ELSE (
					echo.
					%VarPowerShell%  -file "%Instaladores1%\ps1\UpdateServProd2.ps1" %ServerApi2newpro% %ServerWeb1prod%
					echo.
					echo Finalizo actualizacion del archivo
					echo.
					Pause>Nul
					echo.
					echo Enter cualquier tecla para continuar o CTRL + C para finalizar
					Pause>Nul
					Goto :cuatro
					)
		Goto ActualizarData
)
Goto ActualizarData

:MenuIPDmzP3
set "var=%var*=%"
set ServerWeb1prod=10.160.93.21
echo la IP ServerWeb1prod = %ServerWeb1prod%
set /p ServerWeb1newpro=Digita Nueva IP Servidor Servidor Web 1 - Produccion:
IF "%ServerWeb1newpro%"=="" ( 
    echo El dato ingresado no debe ser en blanco
    Timeout /T 2 /NoBreak>nul
    goto cuatro
) ELSE (
			echo.
			echo la IP servidor web 1 = %ServerWeb1prod%
			echo.
			:MenuIPDmzIntP3
			cls
			set "var=%var*=%"
			IF "%ServerWeb1prod%"=="%ServerWeb1newpro%" ( 
					Timeout /T 1 /NoBreak>nul
					echo.
					echo El dato ingresado no debe ser igual
					echo.
					Pause>Nul
					goto cuatro 
					) ELSE (
					echo.
					%VarPowerShell%  -file "%Instaladores1%\ps1\UpdateServProd3.ps1" %ServerWeb1prod% %ServerWeb1newpro% 
					echo.
					echo Finalizo actualizacion del archivo
					echo.
					Pause>Nul
					echo.
					echo Enter cualquier tecla para continuar o CTRL + C para finalizar
					Pause>Nul
					Goto :cuatro
					)
		Goto ActualizarData
)
Goto ActualizarData

:MenuIPDmzP4
set "var=%var*=%"
set ServerWeb2prod=10.160.93.22
echo la IP ServerWeb2prod  = %ServerWeb2prod%
set /p ServerWeb2newpro=Digita Nueva IP Servidor Servidor Web 2 - Produccion:
IF "%ServerWeb2newpro%"=="" ( 
    echo El dato ingresado no debe ser en blanco
    Timeout /T 2 /NoBreak>nul
    goto cuatro
) ELSE (
			echo.
			echo la IP servidor Web 2= %ServerWeb2prod%
			echo.
			:MenuIPDmzIntP4
			cls
			set "var=%var*=%"
			IF "%ServerWeb2prod%"=="%ServerWeb2newpro%" ( 
					Timeout /T 1 /NoBreak>nul
					echo.
					echo El dato ingresado no debe ser igual
					echo.
					Pause>Nul
					goto cuatro 
					) ELSE (
					echo.
					%VarPowerShell%  -file "%Instaladores1%\ps1\UpdateServProd4.ps1" %ServerWeb2prod% %ServerWeb2newpro%
					echo.
					echo Finalizo actualizacion del archivo
					echo.
					Pause>Nul
					echo.
					echo Enter cualquier tecla para continuar o CTRL + C para finalizar
					Pause>Nul
					Goto :cuatro
					)
		Goto ActualizarData
)

Goto ActualizarData


:cinco
cls
set "var=%var*=%"
echo.
echo -------------------------------------------------------------------------------------
echo 5. Actualizacion Masiva de IPS y Contrasenas
echo ------------------------------------------------------------------------------------------------------------
echo   1. Acciones a Realizar:
echo             - Cambio de contrasena archivo setup
echo 			 - Cambiar IP Intranet 1
echo 			 - Cambiar IP Intranet 2
echo 			 - Cambiar IP DMZ Gestion 1: ServerApi1 = 10.160.75.15
echo 			 - Cambiar IP DMZ Gestion 2: ServerApi2 = 10.160.75.16
echo 			 - Cambiar IP DMZ Gestion 3: ServerWeb1 = 10.160.75.21
echo 			 - Cambiar IP DMZ Gestion 4: ServerWeb2 = 10.160.75.22
echo 			 - Cambiar IP DMZ Produccion 1: ServerApi1prod = 10.160.93.19
echo 			 - Cambiar IP DMZ Produccion 2: ServerApi2prod = 10.160.93.20
echo 			 - Cambiar IP DMZ Produccion 3: ServerWeb1prod = 10.160.93.21
echo 			 - Cambiar IP DMZ Produccion 4: ServerWeb2prod = 10.160.93.22
echo ------------------------------------------------------------------------------------------------------------
echo 			 Enter cualquier tecla para continuar 
echo ------------------------------------------------------------------------------------------------------------
echo   -   Escribe un Numero del menu y Presione Enter:

set /p var=
if %var%==1 goto :MenuFull
if %var%==2 goto :MenuIPDmzP2
if %var%==2 goto :MenuIPDmzP3
if %var%==2 goto :MenuIPDmzP4
if %var%==v goto :ActualizarData
if %var%==V goto :ActualizarData
if %var%==q goto :exit
if %var%==Q goto :exit
if %var% GTR 0 echo Error
Pause>Nul
goto :cinco

:MenuFull
set "var=%var*=%"
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set miip=%%b
set ServerLan1=10.160.88.68
set ServerLan2=10.160.88.69
set ServerApi1=10.160.75.15
set ServerApi2=10.160.75.16
set ServerWeb1=10.160.75.21
set ServerWeb2=10.160.75.22
set ServerApi1prod=10.160.93.19
set ServerApi2prod=10.160.93.20
set ServerWeb1prod=10.160.93.21
set ServerWeb2prod=10.160.93.22
set PasswUserBpm=A16CalidadC*2018
set VarPowerShell=%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe 
set Instaladores1=E:\Instaladores
set UsuarioBpm=bpmadmin
set VLAN=10.160.75.1
-----------------------
echo.
echo.
echo  - Contrasena de usuario anterior %PasswUserBpm%
echo.
echo    -Actualizar contraseña de Usuario bpmadmin
set /p PasswUserBpmNew=Digita Nueva IP Servidor Principal:
echo.
echo    -Servidores LAN
set /p ServerLan1new=Digita Nueva IP Servidor Principal:
set /p ServerLan2new=Digita Nueva IP Servidor Intranet 2:
echo.
echo    -Servidores DMZ Gestion
set /p ServerApi1new=Digita Nueva IP Servidor Servidor Api 1 - Gestion:
set /p ServerApi2new=Digita Nueva IP Servidor Servidor Api 2 - Gestion:
set /p ServerWeb1new=Digita Nueva IP Servidor Servidor Web 1 - Gestion:
set /p ServerWeb2new=Digita Nueva IP Servidor Servidor Web 2 - Gestion:
echo.
echo.
echo    -Servidores DMZ Produccio	n
set /p ServerApi1newpro=Digita Nueva IP Servidor Servidor Api 1 - Produccion:
set /p ServerApi2newpro=Digita Nueva IP Servidor Servidor Api 2 - Produccion:
set /p ServerWeb1newpro=Digita Nueva IP Servidor Servidor Web 1 - Produccion:
set /p ServerWeb2newpro=Digita Nueva IP Servidor Servidor Web 2 - Produccion:
echo.
%VarPowerShell%  -file "%Instaladores1%\ps1\UpdateFull.ps1" %ServerApi1prod% %ServerApi1newpro% %ServerApi2prod% %ServerApi2newpro% %ServerWeb1prod% %ServerWeb1newpro% %ServerWeb2prod% %ServerWeb2newpro% %ServerApi1% %ServerApi1new% %ServerApi2% %ServerApi2new% %ServerWeb1% %ServerWeb1new% %ServerWeb2% %ServerWeb2new% %ServerLan1% %ServerLan1new% %ServerLan2% %ServerLan2new% %PasswUserBpm% %PasswUserBpmNew%
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
Pause>Nul
goto :ActualizarData




:Despliegues
cls
set "var=%var*=%"
echo.
echo ------------------------------------------------------------------------------------------------------------
echo   Despliegues BizAgi
echo ------------------------------------------------------------------------------------------------------------
echo.
echo       1. Detener Servicios
echo       2. Realizar Backup Aplicacion
echo       3. Realizar Backup DB
echo       4. Instalar Servicios si Aplica
echo       5. Instalar Export File
echo       6. Limpiar Cache
echo       7. Subir Servicios
echo.
echo ------------------------------------------------------------------------------------------------------------
echo   Instalacion Fix
echo ------------------------------------------------------------------------------------------------------------
echo.
echo       9. Descomprimir archivos http://jfrogqa:8081/artifactory/webapp 
echo      13. Borrar archivo de entregable
echo      14. Reescribir carpeta Scheduler
echo      15. Reescribir carpeta bin y jquery
echo      17. Subir Servicios
echo.
echo ------------------------------------------------------------------------------------------------------------
echo   Escribe un Numero del menu y Presione Enter:

set /p var=
if %var%==1 goto :DespDetener
if %var%==2 goto :DespBackupServicios
if %var%==3 goto :DespBackupDB
if %var%==4 goto :DespServicios
if %var%==5 goto :DespBizAgi
if %var%==6 goto :DespLimpiarCache
if %var%==7 goto :DespSubirServicios
if %var%==v goto :Menu
if %var%==V goto :Menu
if %var%==q goto :exit
if %var%==Q goto :exit
if %var% GTR 0 echo Error
Pause>Nul
goto :Despliegues


:DespDetener
cls
set "var=%var*=%"
set cacheurl=http://localhost/PichinchaBPMExt/webservices/cache.asmx
set NameScheduler=BizAgiPichinchaBPMExtSchedulerService
set NameOperation="Bizagi Standard Server Operations Service"
echo.
echo -------------------------------------------------------------------------------------
echo 1. Detener Servicios 
echo ------------------------------------------------------------------------------------------------------------
echo.
echo Acciones a Realizar:
echo              - Detener Servicio de IIS
echo              - Detener servicio %NameOperation%
echo              - Detener servicio %NameScheduler%
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
echo Detener de Servicio IIS ...
echo.
		iisreset /stop
echo.
echo ------------------------------------------------------------------------------------------------------------
echo Servicio IIS Detenido...
echo.
echo Oprima cualquier tecla para Detener Servicios:
echo.
echo    -  %NameOperation% 
echo    -  %NameScheduler%
echo ------------------------------------------------------------------------------------------------------------
Pause>Nul	
echo.
		net stop %NameOperation%
echo.
echo Detener Servicio %NameScheduler% ...
		net stop "%NameScheduler%"		
echo Oprima cualquier tecla para continuar
echo.
echo Finalizo Detener de Servicio. Oprima cualquier tecla para continuar
echo ------------------------------------------------------------------------------------------------------------
Pause>Nul
goto :Despliegues

:DespBackupServicios
cls
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set miip=%%b
set backups=E:\Backups\
set BizagiProjects=E:\BizagiProjects\PichinchaBPMExt
set Servicios=E:\Servicios\Documentacion Servicios
set ProgramData=C:\ProgramData\Bizagi
set ServerLan1=10.160.88.68
set dd=%date:~-10,2%
set mm=%date:~-7,2%
set yy=%date:~-4%
set folder=%backups%%dd%%mm%%yy%
set bckpBizagiProjects=%folder%\BizagiProjects\
set bckpServicios=%folder%\Servicios\
set bckpProgramData=%folder%\ProgramData\


if %miip% == %ServerLan2% set Result=true
if %miip% == 10.160.93.19 set Result=true
if %miip% == 10.160.93.20 set Result=true
if %miip% == 10.160.93.21 set Result=true
if %miip% == 10.160.93.22 set Result=true

echo ------------------------------------------------------------------------------------------------------------
echo 2. Realizar Backup Aplicacion
echo ------------------------------------------------------------------------------------------------------------
echo El backup se dejara en la ruta: %folder%
echo              - Backup de Carpeta %BizagiProjects%
echo              - Backup de Carpeta %Servicios%
echo              - Backup de Carpeta %ProgramData%
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
Pause>Nul
echo.
IF exist %folder% ( goto :DespBackupServicios1) ELSE ( mkdir %folder% && echo se creo carpeta %folder% && goto :DespBackupServicios1)
echo.
Pause>Nul

:DespBackupServicios1
IF %miip% == %ServerLan1% (
							echo.
							echo ------------------------------------------------------------------------------------------------------------
							echo Inicia Proceso de Backups
							echo ------------------------------------------------------------------------------------------------------------
								Pause>Nul
								echo.
								echo Inicia Copia Carpeta Servicio %bckpBizagiProjects%
								echo ----------------------------------------------------------------------------------------------------
								echo.
									xcopy %BizagiProjects% /s/e/f %bckpBizagiProjects%
								echo.
								echo Inicia Copia Carpeta Servicio %bckpServicios%
								echo ----------------------------------------------------------------------------------------------------
								echo.
									xcopy "%Servicios%" /s/e/f %bckpServicios%
								echo.
								echo Inicia Copia Carpeta Servicio %bckpProgramData%
								echo ----------------------------------------------------------------------------------------------------
								echo.
									xcopy %ProgramData% /s/e/f %bckpProgramData%
								echo.
								echo Fin Backups: %BizagiProjects%, %Servicios% y %ProgramData%
								echo ----------------------------------------------------------------------------------------------------
								Pause>Nul
								echo.
							Pause>Nul
						goto :Despliegues
		) ELSE ( if "%Result%" == "true" (
							echo.
							echo Solo aplica para servidor Principal
							echo.
				Pause>Nul
							goto :Despliegues
						)
				)
				Pause>Nul

echo Oprima cualquier tecla para continuar
echo Finalizo Validacion estados Servicios. Oprima cualquier tecla para continuar
Pause>Nul
goto :Despliegues

:DespBackupDB
cls

echo Oprima cualquier tecla para continuar
echo Finalizo Validacion estados Servicios. Oprima cualquier tecla para continuar
Pause>Nul
goto :Despliegues


:DespServicios
cls
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set miip=%%b
set TempDespliegues=E:\TempDespliegues\Documentacion Servicios\*.*
set Servicios=E:\Servicios\Documentacion Servicios

if %miip% == %ServerLan2% set Result=true
if %miip% == 10.160.93.19 set Result=true
if %miip% == 10.160.93.20 set Result=true
if %miip% == 10.160.93.21 set Result=true
if %miip% == 10.160.93.22 set Result=true

echo ------------------------------------------------------------------------------------------------------------
echo 4. Instalar Servicios si Aplica
echo ------------------------------------------------------------------------------------------------------------
echo Se instalara: 
echo              - Descomprimir archivos http://jfrogqa:8081/artifactory/webapp 
echo              - Remplazar Archivos de Carpeta %Servicios%
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------

IF %miip% == %ServerLan1% (
							echo.
							echo ------------------------------------------------------------------------------------------------------------
							echo Inicia Proceso de Backups
							echo ------------------------------------------------------------------------------------------------------------
								start http://jfrogqa:8081/artifactory/webapp
								Pause>Nul
								echo.
								echo Inicia Copia de Servicios %Servicios%
								echo ----------------------------------------------------------------------------------------------------
								echo.
								echo %TempDespliegues%
								echo %Servicios%
								pause
									xcopy "%TempDespliegues%" /s/e/f "%Servicios%"\
								echo.
								Pause>Nul
								echo.
							Pause>Nul
						goto :Despliegues
		) ELSE ( if "%Result%" == "true" (
							echo.
							echo Solo aplica para servidor Principal
							echo.
				Pause>Nul
							goto :Despliegues
						)
				)
				Pause>Nul
				
				
				
echo Oprima cualquier tecla para continuar
echo Finalizo Validacion estados Servicios. Oprima cualquier tecla para continuar
Pause>Nul
goto :Despliegues

:DespBizAgi
cls
set Instaladores1=E:\Bizagi\Bizagi Engine\MC\CreateImport.exe

echo ------------------------------------------------------------------------------------------------------------
echo 5. Instalar Export File
echo ------------------------------------------------------------------------------------------------------------
echo.
echo.
cmd /c "%Instaladores1%"

echo Oprima cualquier tecla para continuar
echo Finalizo Instalacion del Nuevo Desplegable. Oprima cualquier tecla para continuar
Pause>Nul
goto :Despliegues

:DespLimpiarCache
cls

set folder="E:\BizagiProjects\PichinchaBPMExt\SOA\"
cd /d %folder%
for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)
dir

set folder="E:\BizagiProjects\PichinchaBPMExt\Temporary\"
cd /d %folder%
for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)
dir

set folder="E:\BizagiProjects\PichinchaBPMExt\EntityManager\"
cd /d %folder%
for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)
dir

set folder="E:\BizagiProjects\PichinchaBPMExt\ComponentLibrary\"
cd /d %folder%
for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)
dir

set folder="C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Temporary ASP.NET Files\"
cd /d %folder%
for /F "delims=" %%i in ('dir /b') do (rmdir "%%i" /s/q || del "%%i" /s/q)
dir



echo Oprima cualquier tecla para continuar
echo Finalizo Validacion estados Servicios. Oprima cualquier tecla para continuar
Pause>Nul
goto :Despliegues


:DespSubirServicios
cls

set "var=%var*=%"
set cacheurl=http://localhost/PichinchaBPMExt/webservices/cache.asmx
set NameScheduler=BizAgiPichinchaBPMExtSchedulerService
set NameOperation="Bizagi Standard Server Operations Service"
echo ------------------------------------------------------------------------------------------------------------
echo   s (S). Subir Servicios IIS y Scheduler 
echo ------------------------------------------------------------------------------------------------------------
echo Acciones a Realizar:
echo              - Inicio de IIS
echo              - Inicio servicio %NameScheduler%
echo.
echo Enter cualquier tecla para continuar o CTRL + C para finalizar
echo ------------------------------------------------------------------------------------------------------------
echo.
echo Inicia Servicio IIS ...
echo.
		iisreset /start
echo.
echo fin Inicio IIS
echo.
echo Inicio Servicio %NameOperation% y %NameScheduler%...
echo Oprima cualquier tecla para continuar
echo ------------------------------------------------------------------------------------------------------------
Pause>Nul	
echo.
		net start %NameOperation%
echo.
echo Inicio Servicio %NameScheduler% ...
echo.
		net start "%NameScheduler%"
echo.
echo Oprima cualquier tecla para continuar
echo ------------------------------------------------------------------------------------------------------------
echo.
echo Inicia Limpieza Cache Automatica del Sitio PichinchaBPMExt
echo Oprima cualquier tecla para continuar
echo ------------------------------------------------------------------------------------------------------------
Pause>Nul
echo.
start http://localhost/PichinchaBPMExt/webservices/cache.asmx/CleanRenderCache
start http://localhost/PichinchaBPMExt/webservices/cache.asmx/CleanTracing
start http://localhost/PichinchaBPMExt/webservices/cache.asmx/ReleaseLocalizationResources
start http://localhost/PichinchaBPMExt/webservices/cache.asmx/UpdatePortal
start http://localhost/PichinchaBPMExt/webservices/cache.asmx/cleanParameters
start http://localhost/PichinchaBPMExt/webservices/cache.asmx/cleanUpRuleCache
echo Finalizo Limpieza Cache Automatica del Sitio PichinchaBPMExt
echo ------------------------------------------------------------------------------------------------------------
echo.
echo Inicia Limpieza Cache parametrica del Sitio PichinchaBPMExt
echo Oprima cualquier tecla para continuar
Pause>Nul
echo.------------------------
echo Parameter  -  Value
echo ------------------------
echo sPrefix:   -   *       -
echo sKey:      -   *       -
echo ------------------------
echo clic en invoke
start http://localhost/PichinchaBPMExt/webservices/cache.asmx?op=CleanUpCache
echo Finalizo Limpieza Cache parametrica del Sitio PichinchaBPMExt
echo ------------------------------------------------------------------------------------------------------------

set Instaladores1="E:\Bizagi\Bizagi Engine\MC\BizAgiMC.exe"

echo ------------------------------------------------------------------------------------------------------------
echo 5. Iniciar BizAgi Console
echo ------------------------------------------------------------------------------------------------------------
echo.
cmd /c "%Instaladores1%"

echo Oprima cualquier tecla para continuar
echo Finalizo Validacion estados Servicios. Oprima cualquier tecla para continuar
Pause>Nul
goto :Despliegues