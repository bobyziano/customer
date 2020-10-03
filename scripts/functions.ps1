function Connect-Database 
{
    
    $Query = "SELECT * FROM user"

    #SQLite will create Names.SQLite for us
    Invoke-SqliteQuery -Query $Query -DataSource $Database

    # We have a database, and a table, let's view the table info
    Invoke-SqliteQuery -DataSource $Database -Query "PRAGMA table_info(NAMES)"
}


function Write-Log
{
   Param ([string]$logstring)
   
   $todaysDate = (Get-Date).ToString("yyyyMMdd")
   $LogFile = $LogFolder + "\log_" + $todaysDate + ".log"
   $cuenta = $error.Count - 1
   if ($logstring -eq "") { $logstring = "There was an error - on " + (Get-Date).DateTime + "`n" + $Error[$cuenta] + "`n" }
   else {$logstring = $logstring + (Get-Date).DateTime }
   if (Test-Path $LogFile) {
                            Add-content $Logfile -value $logstring #[$cuenta]
                           }
   else {
            New-Item $LogFile
            Add-content $Logfile -value $logstring  
        }

<# ideas
 maybe is useful using write-error to a variable 
 for ($i=0; $i -le 100; $i+=20)
 { write-progress -Activity "Starting System" -Status "$i% Complete:" -PercentComplete $i
   Start-Sleep 1
 }
#>


   $Error.Clear()
   $logstring = $null
}


function Check-Credentials
{
    $wcmGreating = "Bienvenido al Sistema de Administracion de Clientes"

    if ((Get-Credential -Message "Input your user and Password, if you are wrong you won't see anything" ).GetNetworkCredential().Password -eq 'chupalo') 
    { 
        [System.Windows.Forms.MessageBox]::Show($top, $wcmGreating , "Información",'OK','Information')
        [void] $form.ShowDialog()
        Push-Location
    } 
    else 
    { 
      [System.Windows.Forms.MessageBox]::Show($top, "If you keep not giving the right password, you'll be follow", "Información",'OKCancel','Error')
      Push-Location
    }
}



