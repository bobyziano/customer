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
    $button.TextAlign = "MiddleCenter"
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
                                                                                Size = New-Object System.Drawing.Size($sizeCalX,$sizeCalY)
                                                                                Location = New-Object System.Drawing.Point($locx,$locy)
                                                                                ColumnHeadersVisible = $true
                                                                                AutoSize = $false
                                                                                AutoSizeRowsMode = 'AllCells'
                                                                                AutoSizeColumnsMode = 'AllCells' 
                                                                                SelectionMode = "FullRowSelect"
                                                                                Font = New-Object System.Drawing.Font("Verdana", 14)
                                                                                ReadOnly = $true
                                                                                RowHeadersVisible = $true
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

