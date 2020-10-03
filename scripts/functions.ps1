Function Create-Form
{

param 
    (
        [string] $TitleSW,
        [int32] $sizeX,
        [int32] $sizeY
    )

 $form = New-Object System.Windows.Forms.Form #create form
    $form.AutoScaleDimensions = '6, 13'
    $form.AutoScale = 'None' 
    $form.Text = ' - ' + $titleSW + ' - '
    $form.Font = $FormFont 
    $form.ClientSize = New-Object System.Drawing.Size('950,500')
    $form.TopMost = $true
    $form.StartPosition = "CenterScreen"
    $form.FormBorderStyle = "FixedDialog"
    $form.MaximizeBox = $false
    $form.MinimizeBox = $true
    $form.Font = $TextFont
    $form.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($IconPath)

    return $form
}


function Create-Button 
{

param 
    (
        [string] $texto, 
        [Int32] $locX, 
        [Int32] $locY, 
        [Int32] $sizeButtonX, 
        [Int32] $sizeButtonY 
    )

$button = New-Object System.Windows.Forms.Button
    $button.Location = New-Object System.Drawing.Point($locX,$locY)
    $button.Size = New-Object System.Drawing.Size($sizeButtonX,$sizeButtonY)
    $button.TextAlign = "MiddleLeft"
    $button.Text = $texto
    $button.Font = $btnFont

    return $button
}


function Create-Label 
{

param 
    (
     [string] $textoLabel, 
     [Int32] $locX, 
     [Int32] $locY,
     [Int32] $sizeLabelX,
     [Int32] $sizeLabelY
    )

$label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point($locX,$locY)
    $label.Size = New-Object System.Drawing.Size($sizeLabelX, $sizeLabelY)
    $label.TextAlign = "MiddleLeft"
    $label.Text = $textoLabel
    $label.Font = $LabelFont

    return $label
}


function Create-TextEntry 
{

param ( 
        [string] $textoLabel,
        [Int32] $locX, 
        [Int32] $locY,
        [Int32] $SizeX,
        [Int32] $SizeY
      )

$TextEntry = New-Object System.Windows.Forms.TextBox -Property @{
                                                                  Location = New-Object System.Drawing.Point($locX, $locY)
                                                                  Size = New-Object System.Drawing.Size($SizeX,$SizeY)
                                                                  Font = $TextFont
                                                                  Multiline = $true
                                                                  ScrollBars = 'Vertical'
                                                                }
$locLabelX = $locX-250
$locLabelY = $locY
$entryLabel = Create-Label -textoLabel $textoLabel -locX $locLabelX -locY $locLabelY -sizeLabelX 100 -sizeLabelY 40
$entryLabel.Font = $fontLabel

    return $TextEntry

}


function Create-ComboBox 
{

param 
    (
        [string] $texto, 
        [Int32] $locX, 
        [Int32] $locY, 
        [Int32] $sizeButtonX, 
        [Int32] $sizeButtonY 
    )

$ComboBox = New-Object System.Windows.Forms.ComboBox -Property @{
                                                                 Location = New-Object System.Drawing.Point($locX,$locY)
                                                                 Size = New-Object System.Drawing.Size(400, 40)

                                                                }
    return $ComboBox
}


function Create-Calendar 
{
 param
 (
    [Int32] $locX, 
    [Int32] $locY,
    [Int32] $sizeCalX,
    [Int32] $sizeCalY
 )

 $calendar = New-Object Windows.Forms.DateTimePicker
    $calendar.Location = New-Object System.Drawing.Point($locX,$locY)
    $calendar.Size = New-Object System.Drawing.Size($sizeCalX,$sizeCalY)
    $calendar.Font = $LabelFont
    $calendar.CustomFormat = "ddd dd MMM yyyy"

    return $calendar
}


function Create-Image 
{
 param
 (
    [string] $urlImage,
    [Int32] $locX, 
    [Int32] $locY
 )

 $image = New-Object System.Windows.Forms.PictureBox
    $image.Location = New-Object System.Drawing.Point($locX,$locY)
    $image.Size = New-Object System.Drawing.Size(200,100)
    $image.Width = $Image.Width
    $image.Height = $Image.Height
    $image.Image = [system.drawing.image]::FromFile($urlImage)
    
    return $image
}



function Create-GridView 
{
    param
    (
        [Int32] $locX, 
        [Int32] $locY,
        [Int32] $sizeCalX,
        [Int32] $sizeCalY
        )
    $dataGridView = New-Object System.Windows.Forms.DataGridView -Property @{
                                                                                Size = New-Object System.Drawing.Size(400,250)
                                                                                Location = New-Object System.Drawing.Point($locx,$locy)
                                                                                ColumnHeadersVisible = $true
                                                                                AutoSizeColumnsMode = 'AllCells' 
                                                                                SelectionMode = "FullRowSelect"
                                                                                Font = New-Object System.Drawing.Font("Verdana", 8)
                                                                                ReadOnly = $true
                                                                                RowHeadersVisible = $true
                                                                                AutoSize = $true
                                                                                AutoSizeRowsMode = 'AllCells'
                                                                                AllowUserToResizeColumns = $true
                                                                                AllowUserToResizeRows = $false
                                                                                AllowUserToAddRows = $false
                                                                            }
    return $dataGridView
}


function Create-TabPage
{
    param 
    (
       [string] $text
    )
    $tabPage = New-Object System.Windows.Forms.TabPage -Property @{
                                                                  Text = $text
                                                                }
    return $tabPage
}


function Create-TabControl
{
    $tabControl = New-Object System.Windows.Forms.TabControl -Property @{
                                                                            Size = New-Object System.Drawing.Size(930,400)
                                                                            Location = New-Object System.Drawing.Point(10,10)
                                                                        }
    return $tabControl
}


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



