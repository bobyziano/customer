
$actData = Import-Excel -Path ".\data\data.xlsx" -WorksheetName activity

$noteForm = Create-Form -TitleSW "Add Note" -sizeButtonX 200 -sizeButtonY 50

$txtNote = Create-TextEntry -locX 30 -locY 70 -SizeX 850 -SizeY 250
$txtNote.MaxLength = 500

$lblNote = Create-Label -textoLabel "Activity:" 20 20 200 40
$cmbActivity = Create-ComboBox -locX 220 -locY 20

foreach ($act in $actData.activity) {  $cmbActivity.Items.Add($act) }

$btnSubmit = Create-Button -texto 'Submit' 300 350 280 100
$btnSubmit.TextAlign = "MiddleCenter"
$btnSubmit.Add_Click({ Entry-Note  })

$btnCancel = Create-Button -texto 'Cancel' 600 350 280 100
$btnCancel.TextAlign = "MiddleCenter"
$btnCancel.Add_Click({ $noteForm.Close() })

$noteForm.Controls.Add($txtNote)
$noteForm.Controls.Add($lblNote)
$noteForm.Controls.Add($cmbActivity)
$noteForm.Controls.Add($btnSubmit)
$noteForm.Controls.Add($btnCancel)





[void] $noteForm.ShowDialog()

