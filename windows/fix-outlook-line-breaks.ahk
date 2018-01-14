#NoEnv
#SingleInstance force
SetTitleMatchMode 2
SendMode, Input
Return
#IfWinActive, - Message
$+Enter::Send, {Enter}
$Enter::Send, +{Enter}