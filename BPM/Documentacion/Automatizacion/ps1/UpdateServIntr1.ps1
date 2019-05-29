# * ------------------------------------------------------------------------------------------------------------ 
# * File Name         : E:\Instaladores\SetupBizAgi.bat 
# * Author            : Edisson Giovanni Zuñiga Lopez 
# * Description       : Procedimiento para actualizar contraseñas del archivos de Setup
# *                   : 27\11\2018 
# * ------------------------------------------------------------------------------------------------------------ 
param($ServerLan1, $ServerLan1new)

(get-content E:\Instaladores\SetupBizAgi.bat) | foreach-object {$_ -replace "$ServerLan1", "$ServerLan1new"} | set-content E:\Instaladores\SetupBizAgi.bat

