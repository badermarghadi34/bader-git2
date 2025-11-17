$csvPath = "C:\Users\Administrateur\Desktop\csv\csv.csv"
$csvData = Import-Csv -Path $csvPath -Delimiter ";"
$csvData
New-ADOrganizationalUnit -Name "UBIJURISTE" -path "DC=afpa,DC=mtp" -ProtectedFromAccidentalDeletion $false
$dnou = "OU=UBIJURISTE,DC=afpa,DC=mtp"
$sousOUs = "Direction","Gestion","Rédaction","Accueil","Compta"
foreach ($ou in $sousOUs){
    New-ADOrganizationalUnit -Name $ou -Path $dnou -ProtectedFromAccidentalDeletion $false -ErrorAction SilentlyContinue
    Write-host "Ou : $ou"
}

 

Get-ADOrganizationalUnit -SearchBase $dnou -Filter *|
    Select Name, DistinguishedName | Sort Name
New-ADGroup -Name "GG_ubi_Direction"  -GroupScope Global -GroupCategory Security -Path "OU=Direction,OU=UBIJURISTE,DC=afpa,DC=mtp"
New-ADGroup -Name "GG_ubi_Compta"  -GroupScope Global -GroupCategory Security -Path "OU=Compta,OU=UBIJURISTE,DC=afpa,DC=mtp"
New-ADGroup -Name "GG_ubi_Redaction"  -GroupScope Global -GroupCategory Security -Path "OU=Rédaction,OU=UBIJURISTE,DC=afpa,DC=mtp"
New-ADGroup -Name "GG_ubi_Gestion"  -GroupScope Global -GroupCategory Security -Path "OU=Gestion,OU=UBIJURISTE,DC=afpa,DC=mtp"
New-ADGroup -Name "GG_ubi_Accueil"  -GroupScope Global -GroupCategory Security -Path "OU=Accueil,OU=UBIJURISTE,DC=afpa,DC=mtp"

 

Foreach($utilisateur in $csvData){ 
    $utilisateurprenom = $utilisateur.prenom
    $utilisateurnom = $utilisateur.nom
    $utilisateurlogin = ($utilisateurprenom).Substring(0,3)+"."+$utilisateurnom
    $UtilisateurMotdePasse = "Bader2004."

 

if(Get-ADUser-Filter "SamAccountName -eq '$utilisateurlogin'"){
Write-Host"L'identifiant $utilisateurlogin existe déja dans l'AD"}
{
Write-Host "L'identifiant $utilisateurlogin existe déjà dans l'AD"
}
else { 
New-ADUser`
    -Name "$utilisateurnom $utilisateurprenom"`
    -DisplayName"$utilisateurnom $utilisateurprenom"`
    -GivenName $utilisateurprenom `
    -Surname $utilisateurnom`
    -SamAccountName $utilisateurlogin`
    -UserprincipalName "$utilisateurlogin@afpa.mtp"`
    -Path "OU=UBIJURISTE,DC=afpa,DC=mtp"`
    -AccountPassword(ConvertTo-SecureString $UtilisateurMotdePasse-AsPlainText-Force)`
    -ChangePasswortAtLogon $true`
    -Enabled $true

 

Write-Output "Création de l'utilisateur: $utilisateurlogin ($utilisateurnom $utilisateurprenom)"
}
}
Import-Module ActiveDirectory   $csvPath  =... par Bader Marghadi
21/10 22:44
Bader Marghadi

Import-Module ActiveDirectory

 

$csvPath  = "C:\Users\Administrateur\Desktop\csv\csv.csv"
$csvData  = Import-Csv -Path $csvPath -Delimiter ";"

 

# OU racine et sous-OU
New-ADOrganizationalUnit -Name "UBIJURISTE" -Path "DC=afpa,DC=mtp" -ProtectedFromAccidentalDeletion $false -ErrorAction SilentlyContinue
$dnou = "OU=UBIJURISTE,DC=afpa,DC=mtp"

 

$sousOUs = "Direction","Gestion","Rédaction","Accueil","Compta"
foreach ($ou in $sousOUs){
    New-ADOrganizationalUnit -Name $ou -Path $dnou -ProtectedFromAccidentalDeletion $false -ErrorAction SilentlyContinue
    Write-Host "OU : $ou"
}

 

# Groupes
New-ADGroup -Name "GG_ubi_Direction"  -GroupScope Global -GroupCategory Security -Path "OU=Direction,OU=UBIJURISTE,DC=afpa,DC=mtp"  -ErrorAction SilentlyContinue
New-ADGroup -Name "GG_ubi_Compta"     -GroupScope Global -GroupCategory Security -Path "OU=Compta,OU=UBIJURISTE,DC=afpa,DC=mtp"     -ErrorAction SilentlyContinue
New-ADGroup -Name "GG_ubi_Redaction"  -GroupScope Global -GroupCategory Security -Path "OU=Rédaction,OU=UBIJURISTE,DC=afpa,DC=mtp"  -ErrorAction SilentlyContinue
New-ADGroup -Name "GG_ubi_Gestion"    -GroupScope Global -GroupCategory Security -Path "OU=Gestion,OU=UBIJURISTE,DC=afpa,DC=mtp"    -ErrorAction SilentlyContinue
New-ADGroup -Name "GG_ubi_Accueil"    -GroupScope Global -GroupCategory Security -Path "OU=Accueil,OU=UBIJURISTE,DC=afpa,DC=mtp"    -ErrorAction SilentlyContinue

 

# Mot de passe par défaut (sécurisé) — calculé UNE fois
$UtilisateurMotdePasse = "Bader2004."
$SecurePw = ConvertTo-SecureString $UtilisateurMotdePasse -AsPlainText -Force

 

# Création des utilisateurs
foreach ($utilisateur in $csvData) {

 

    $utilisateurprenom = $utilisateur.prenom
    $utilisateurnom    = $utilisateur.nom
    $utilisateurlogin  = ($utilisateurprenom).Substring(0,[Math]::Min(3,$utilisateurprenom.Length)) + "." + $utilisateurnom  # pour l’UPN
    $sam               = (($utilisateurprenom).Substring(0,[Math]::Min(3,$utilisateurprenom.Length)) + $utilisateurnom)     # sAM sans point

 

    # Vérifie si le compte existe déjà (SYNTAXE CORRECTE)
    if (Get-ADUser -Filter "SamAccountName -eq '$sam'" -ErrorAction SilentlyContinue) {
        Write-Host "L'identifiant $sam existe déjà dans l'AD"
    }
    else {
        New-ADUser `
            -Name               "$utilisateurnom $utilisateurprenom" `
            -DisplayName        "$utilisateurnom $utilisateurprenom" `
            -GivenName          $utilisateurprenom `
            -Surname            $utilisateurnom `
            -SamAccountName     $sam `
            -UserPrincipalName  ("$utilisateurlogin@afpa.mtp") `
            -Path               "OU=UBIJURISTE,DC=afpa,DC=mtp" `
            -AccountPassword    $SecurePw `
            -Enabled            $true `
            -ChangePasswordAtLogon $true

 

        Write-Output "Création de l'utilisateur: $sam ($utilisateurnom $utilisateurprenom)"
    }
}
