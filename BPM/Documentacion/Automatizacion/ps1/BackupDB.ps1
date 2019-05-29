
set server=
set db=
set sql=


Aquí hay una función que uso para ejecutar comandos sql. Solo tiene que cambiar $ sqlCommand.CommandText por el nombre de su sproc y $ SqlCommand.CommandType por CommandType.StoredProcedure.


function execute-Sql{ 
    param($server, $db, $sql) 
    $sqlConnection = new-object System.Data.SqlClient.SqlConnection 
    $sqlConnection.ConnectionString = 'server=' + $server + ';integrated security=TRUE;database=' + $db 
    $sqlConnection.Open() 
    $sqlCommand = new-object System.Data.SqlClient.SqlCommand 
    $sqlCommand.CommandTimeout = 120 
    $sqlCommand.Connection = $sqlConnection 
    $sqlCommand.CommandText= $sql 
    $text = $sql.Substring(0, 50) 
    Write-Progress -Activity "Executing SQL" -Status "Executing SQL => $text..." 
    Write-Host "Executing SQL => $text..." 
    $result = $sqlCommand.ExecuteNonQuery() 
    $sqlConnection.Close() 
} 


function exec-storedprocedure($storedProcName, 
     [hashtable] $parameters=@{}, 
     [hashtable] $outparams=@{}, 
     $conn,[switch]$help){ 

     function put-outputparameters($cmd, $outparams){ 
      foreach($outp in $outparams.Keys){ 
       $cmd.Parameters.Add("@$outp", (get-paramtype $outparams[$outp])).Direction=[System.Data.ParameterDirection]::Output 
      } 
     } 
     function get-outputparameters($cmd,$outparams){ 
      foreach($p in $cmd.Parameters){ 
       if ($p.Direction -eq [System.Data.ParameterDirection]::Output){ 
       $outparams[$p.ParameterName.Replace("@","")]=$p.Value 
       } 
      } 
     } 

     function get-paramtype($typename,[switch]$help){ 
      switch ($typename){ 
       'uniqueidentifier' {[System.Data.SqlDbType]::UniqueIdentifier} 
       'int' {[System.Data.SqlDbType]::Int} 
       'xml' {[System.Data.SqlDbType]::Xml} 
       'nvarchar' {[System.Data.SqlDbType]::NVarchar} 
       default {[System.Data.SqlDbType]::Varchar} 
      } 
     } 
     if ($help){ 
      $msg = @" 
    Execute a sql statement. Parameters are allowed. 
    Input parameters should be a dictionary of parameter names and values. 
    Output parameters should be a dictionary of parameter names and types. 
    Return value will usually be a list of datarows. 

    Usage: exec-query sql [inputparameters] [outputparameters] [conn] [-help] 
    "@ 
      Write-Host $msg 
      return 
     } 
     $close=($conn.State -eq [System.Data.ConnectionState]'Closed') 
     if ($close) { 
      $conn.Open() 
     } 

     $cmd=new-object system.Data.SqlClient.SqlCommand($sql,$conn) 
     $cmd.CommandType=[System.Data.CommandType]'StoredProcedure' 
     $cmd.CommandText=$storedProcName 
     foreach($p in $parameters.Keys){ 
      $cmd.Parameters.AddWithValue("@$p",[string]$parameters[$p]).Direction= 
        [System.Data.ParameterDirection]::Input 
     } 

     put-outputparameters $cmd $outparams 
     $ds=New-Object system.Data.DataSet 
     $da=New-Object system.Data.SqlClient.SqlDataAdapter($cmd) 
     [Void]$da.fill($ds) 
     if ($close) { 
      $conn.Close() 
     } 
     get-outputparameters $cmd $outparams 

     return @{data=$ds;outputparams=$outparams} 
    } 