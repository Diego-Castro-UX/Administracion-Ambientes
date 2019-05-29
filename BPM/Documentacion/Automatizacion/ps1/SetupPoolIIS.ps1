# * ------------------------------------------------------------------------------------------------------------ 
# * File Name         : E:\Instaladores\SetupBizAgi.bat 
# * Author            : Edisson Giovanni Zuñiga Lopez 
# * Description       : Procedimiento de cambiar usuario y password de pool
# *                   : 27\11\2018 
# * ------------------------------------------------------------------------------------------------------------ 

param([string]$namepool, [string]$usuario, [string]$passwdbpmadmi)

Import-Module ServerManager
Add-WindowsFeature Web-Scripting-Tools
Import-Module WebAdministration

Set-ItemProperty IIS:\AppPools\$namepool -name processModel -value @{userName=$usuario;password=$passwdbpmadmi;identitytype=3}