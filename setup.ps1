#Requires -RunAsAdministrator

#Check module is installed
$modules = @(
    @{Name="Posh-ACME";Version=[Version]"3.5.0"},
    @{Name="Az";Version=[Version]"2.5.0"}
)
foreach($Module in $Modules){
    Write-Host "Validation de la présence du module $($Module.Name), version minimale $($Module.Version.tostring())" -ForegroundColor Yellow
    $found = Get-InstalledModule -Name $Module.Name -ErrorAction SilentlyContinue
    #Validation si installé
    if($found){
        #Validation de la version
        if($found.version -lt $module.Version){
            #Failed. Update
            Write-Host "    Module $($module.name) trouvé. Version $($Found.Version)" -ForegroundColor Red
            Write-Host "    Mise à jour du module $($module.name)" -ForegroundColor Yellow
            Update-Module $module.Name -MaximumVersion $module.Version
            if(Get-InstalledModule -Name $Module.Name -ErrorAction SilentlyContinue -MinimumVersion $module.Version){
                Write-Host "    Module $($module.name) trouvé. Version $($Found.Version)" -ForegroundColor Green
            }
            else{
                Write-Host "    Erreur avec la mise à niveau. Installer le module manuellement" -ForegroundColor Red
            }
        }
        else{
            #Sucess.
            Write-Host "    Module $($module.name) trouvé. Version $($Found.Version)" -ForegroundColor Green
        }
    }
    else{
        Write-Host "    Module $($module.Name) inexistant." -ForegroundColor Red
        Write-Host "    Installation du module $($module.Name)" -ForegroundColor Yellow
        Install-Module -Name $module.name
    }
}
Write-Host "Fin de la validation des prérequis" -ForegroundColor Yellow
""
#Confirm method
    #Confirm Prereqs
    #Prereqs setup
Write-Host "Sélectionner l'hébergeur de DNS:" -ForegroundColor Yellow