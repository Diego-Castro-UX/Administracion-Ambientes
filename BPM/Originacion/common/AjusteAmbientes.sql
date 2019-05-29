USE PichinchaBPMExt
go
declare @envName varchar(50)
declare @envId int
declare @envAppWebId int
 
--set @envName = 'Production'
set @envName = 'Test'
--set @envName = 'Development'
 
if(@envName = 'TestOptional') begin
                set @envId = 6
                set @envAppWebId = 3
end
 
if(@envName = 'Test') begin
                set @envId = 2
                set @envAppWebId = 3
end
 
if(@envName = 'Production') begin
                set @envId = 3
                set @envAppWebId = 8
end
 
if(@envName = 'Development') begin
                set @envId = 1
                set @envAppWebId = 1
end
 
begin tran
update BIZAGIINFO set BAValue = @envName where BAInfo = 'Environment';
update BADPLENVOPTION SET eoIntvalue = @envId WHERE idEnvOption = 3;
update BAEnvironment set isCurrentEnv = 0;
update BAEnvironment set isCurrentEnv = 1 where idEnvType = @envAppWebId;
 
commit;
