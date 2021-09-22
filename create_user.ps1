# Legg til flere brukere via .csv fil
$newusers=Import-Csv ./inft2504-skytjenester-som-arbeidsflate-2021-host/oppgave1/create_user.csv -Delimiter ";"
write-host $newusers

#Oppretter en bruker, aktivterer to-faktor autentisering og krever at passord endres på første innlogging: 

foreach ($user in $newusers) {
    $PasswordProfile=New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
    $PasswordProfile.Password=$user.Password
    $MFAProfile=New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
    $MFAProfile.IsDefault = $true
    $MFAProfile.MethodType="PhoneAppNotification" 
    New-AzureADUser `
        -GivenName $user.GivenName `
        -SurName $user.SurName `
        -DisplayName $user.DisplayName `
        -UserPrincipalName $user.UserPrincipalName `
        -MailNickName $user.MailNickName `
        -OtherMails $user.Altmailaddr `
        -Mobile $user.Mobile `
        -Department $user.Department `
        -jobTitle $user.JobTitle `
        -PasswordProfile $PasswordProfile.ForceChangePasswordNextLogin `
        -MFAProfile $MFAProfile `
        -AccountEnabled $true
}
