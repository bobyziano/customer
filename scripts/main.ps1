Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[void] [System.Windows.Forms.Application]::EnableVisualStyles()

Push-Location -Path "C:\Users\Gonzalo\Documents\bobyziano\jobs\desarrollo local\customer manager\customer"

$IconPath = "C:\Users\Gonzalo\Documents\bobyziano\jobs\desarrollo local\idea manager\images\bobyziano.ico"
$FormFont = New-Object System.Drawing.Font("Verdana", 20)
$btnFont = [System.Drawing.Font]::new("Verdana", 15, [System.Drawing.FontStyle]::Bold)
$LabelFont = [System.Drawing.Font]::new("Verdana", 12, [System.Drawing.FontStyle]::Regular)
$fontLabel = New-Object System.Drawing.Font("Verdana", 14, [System.Drawing.FontStyle]::Regular)
$TextFont = New-Object System.Drawing.Font("Verdana", 20, [System.Drawing.FontStyle]::Regular)
$Image = [system.drawing.image]::FromFile("C:\Users\Gonzalo\Documents\bobyziano\jobs\desarrollo local\idea manager\images\Bobyziano.png")
$Database = ".\data\data.db"
$LogFolder = ".\logs"

$custData = Import-Excel -Path ".\data\data.xlsx" -WorksheetName customer

$sizeButtonX = 200
$sizeButtonY = 50

. .\scripts\functions.ps1

try
    {
        $form = Create-Form -TitleSW "Customer Manager" -sizeX 950 -sizeY 500
        $form.Focused

        $tbcPrincipal = Create-TabControl

        $tabActivities = Create-TabPage -text "Activities"
        $tabNotes = Create-TabPage "Notes"
        $tabCustomers = Create-TabPage "Customers"

        $cmbCustomer = Create-ComboBox -locX 40 -locY 280
        foreach ($cust in $custData."Account Name") {  $cmbCustomer.Items.Add($cust) }

        $source = Import-Excel -Path ".\data\data.xlsx" -WorksheetName "Activity" | Where customer -EQ $cmbCustomer.SelectedItem

        $grdActivities = Create-GridView 20 10 400 250
        $grdActivities.ColumnCount = 3
        $grdActivities.Columns[0].Name = "Activity"
        $grdActivities.Columns[1].Name = "Description"
        $grdActivities.Columns[2].Name = "Due Date"
        $grdActivities.ColumnHeadersHeight = 50

        foreach ($act in $source) {
                                    $grdActivities.Rows.Add($act.activity, $act.description)
                                  }


        $btnCreateCustomer = Create-Button -texto "New" -locX 20 -locY 10 -sizeButtonX 200 -sizeButtonY 60
        $btnCreateCustomer.Add_Click({ 
                                      Write-Host "button pushed"
                                      #Invoke-Expression -Command ""  
                                    })

        $btnOpenCustomer = Create-Button -texto "Open" -locX 20 -locY 70 -sizeButtonX 200 -sizeButtonY 60
        $btnOpenCustomer.Add_Click({
                            #Invoke-Expression -Command ".\"      
                          })

        $btnAddNote = Create-Button -texto "Add Note" -locX 40 -locY 40 -sizeButtonX 400 -sizeButtonY 60
        $btnAddNote.Add_Click({    
                                Invoke-Expression -Command .\scripts\get-note.ps1
                             })

        $btnNewActivity = Create-Button "New Activity" 500 270 400 60
        $btnNewActivity.Add_Click({
                                    # call Create-Activity function
                                 }) 
        
        $tabActivities.Controls.Add($btnNewActivity)
        $tabActivities.Controls.Add($grdActivities)
        $tabActivities.Controls.Add($cmbCustomer)

        $tabCustomers.Controls.Add($btnCreateCustomer)
        $tabCustomers.Controls.Add($btnOpenCustomer)
        $tabNotes.Controls.Add($btnAddNote)

        $tbcPrincipal.controls.Add($tabActivities)
        $tbcPrincipal.controls.Add($tabNotes)
        $tbcPrincipal.controls.Add($tabCustomers)
        $form.Controls.Add($tbcPrincipal)

        $btnExit = Create-Button -texto "Exit" -locX 700 -locY 420 -sizeButtonX 200 -sizeButtonY 70
        $btnExit.Font = $TextFont
        $btnExit.TextAlign = "MiddleCenter"
        $btnExit.Add_Click({ $form.Close() })
        $form.Controls.Add($btnExit)

        # Check-Credentials
        [void] $form.ShowDialog()
    }
catch { 
        [System.Windows.Forms.MessageBox]::Show($top, "Quizas para la proxima si quieres entrar, abrazo!" , "Información",'OK','Information') 
        Write-Log
      }
