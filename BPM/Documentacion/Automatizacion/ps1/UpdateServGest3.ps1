# * ------------------------------------------------------------------------------------------------------------ 
# * File Name         : E:\Instaladores\SetupBizAgi.bat 
# * Author            : Edisson Giovanni Zuñiga Lopez 
# * Description       : Procedimiento para actualizar contraseñas del archivos de Setup
# *                   : 27\11\2018 
# * ------------------------------------------------------------------------------------------------------------ 
param($ServerWeb1, $ServerWeb1new)

(get-content E:\Instaladores\SetupBizAgi.bat) | foreach-object {$_ -replace "$ServerWeb1", "$ServerWeb1new"} | set-content E:\Instaladores\SetupBizAgi.bat