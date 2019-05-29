# * ------------------------------------------------------------------------------------------------------------ 
# * File Name         : E:\Instaladores\SetupBizAgi.bat 
# * Author            : Edisson Giovanni Zuñiga Lopez 
# * Description       : Procedimiento para actualizar contraseñas del archivos de Setup
# *                   : 27\11\2018 
# * ------------------------------------------------------------------------------------------------------------ 
param($ServerApi1prod, $ServerApi1newpro, $ServerApi2prod, $ServerApi2newpro, $ServerWeb1prod, $ServerWeb1newpro, $ServerWeb2prod, $ServerWeb2newpro, $ServerApi1, $ServerApi1new, $ServerApi2, $ServerApi2new, $ServerWeb1, $ServerWeb1new, $ServerWeb2, $ServerWeb2new, $ServerLan1, $ServerLan1new, $ServerLan2, $ServerLan2new, $PasswUserBpm, $PasswUserBpmNew)

(get-content E:\Instaladores\SetupBizAgi.bat) | foreach-object {$_ -replace "$ServerApi1prod", "$ServerApi1newpro"} | set-content E:\Instaladores\SetupBizAgi.bat
(get-content E:\Instaladores\SetupBizAgi.bat) | foreach-object {$_ -replace "$ServerApi2prod", "$ServerApi2newpro"} | set-content E:\Instaladores\SetupBizAgi.bat
(get-content E:\Instaladores\SetupBizAgi.bat) | foreach-object {$_ -replace "$ServerWeb1prod", "$ServerWeb1newpro"} | set-content E:\Instaladores\SetupBizAgi.bat
(get-content E:\Instaladores\SetupBizAgi.bat) | foreach-object {$_ -replace "$ServerWeb2prod", "$ServerWeb2newpro"} | set-content E:\Instaladores\SetupBizAgi.bat
(get-content E:\Instaladores\SetupBizAgi.bat) | foreach-object {$_ -replace "$ServerApi1", "$ServerApi1new"} | set-content E:\Instaladores\SetupBizAgi.bat
(get-content E:\Instaladores\SetupBizAgi.bat) | foreach-object {$_ -replace "$ServerApi2", "$ServerApi2new"} | set-content E:\Instaladores\SetupBizAgi.bat
(get-content E:\Instaladores\SetupBizAgi.bat) | foreach-object {$_ -replace "$ServerWeb1", "$ServerWeb1new"} | set-content E:\Instaladores\SetupBizAgi.bat
(get-content E:\Instaladores\SetupBizAgi.bat) | foreach-object {$_ -replace "$ServerWeb2", "$ServerWeb2new"} | set-content E:\Instaladores\SetupBizAgi.bat
(get-content E:\Instaladores\SetupBizAgi.bat) | foreach-object {$_ -replace "$ServerLan1", "$ServerLan1new"} | set-content E:\Instaladores\SetupBizAgi.bat
(get-content E:\Instaladores\SetupBizAgi.bat) | foreach-object {$_ -replace "$ServerLan2", "$ServerLan2new"} | set-content E:\Instaladores\SetupBizAgi.bat
(get-content E:\Instaladores\SetupBizAgi.bat) | foreach-object {$_ -replace "$PasswUserBpm", "$PasswUserBpmNew"} | set-content E:\Instaladores\SetupBizAgi.bat


