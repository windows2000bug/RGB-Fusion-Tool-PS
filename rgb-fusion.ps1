#Zones for Gigabyte Z370 Gaming 7
#0 = VRM
#1 = RAM
#2 = Chepset + Bar
#3 = PCIe
#4 = 12vRGBW Header
#5 = NA
#6 = NA
#7 = Digital LED ?
#8 = Digltal LED ?

$games = "Overwatch","FarCry5"
$path = $PSScriptRoot + "\RGBFusionTool.exe"
$c=0

while ($true) {
$x=0
$z=0
$y=0
ForEach ($check in $games) {
$process = get-process $check -ErrorAction SilentlyContinue

    if ($process -ne $null ) {
        write-host "Game Running, $check"
        if ($check -eq "Overwatch") {
            $colors = "orange","white","orange","blue","blue"
        } ElseIf ($check -eq "FarCry5") {
            $colors = "blue","white","red","white","blue"
        }

        if ($c -eq 0) {
            ForEach ($setColor in $colors) {
                write-host "changing color"
                & $path -c  $setColor -z $z
                $z+=1
                #Sleeping exec commands to quickly can overload the buffer
                sleep 1.25
            }
            $c=1
        }
    } Else {
        $y+=1
    }
    $x+=1
}

if ($x -eq $y ) {
    write-host "No games running"
    $c=0
}

write-host "Sleeping to check for app running"
sleep 3
}
