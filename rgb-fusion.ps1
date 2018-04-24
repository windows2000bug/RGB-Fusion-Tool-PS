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

#Run once as it won't change
$zones = & $path --list
sleep 3

$path = $PSScriptRoot + "\RGBFusionTool.exe"
$games = (Get-Item $(dir $PSScriptRoot\profiles\*xml) ).Basename

$c=0

while ($true) {
    $x=0
    $y=0
    ForEach ($check in $games) {
        $process = get-process $check -ErrorAction SilentlyContinue
    
        if ($process -ne $null ) {
            write-host "Game Running, $check"           
            [xml]$XmlDocument = Get-Content -Path $PSScriptRoot\profiles\$check.xml

            if ($c -eq 0) {
                $m=0
                foreach ($zone in $zones) {

                    if ($zone  -like "*A_LED") {
                        [long]$long = $XmlDocument.LED_info.Area_info[$m].But_Arg[0].startColor
                        $hex = '{0:X}' -F $long
                        $rgb = $hex.substring(2)

                        #Gets Brightness from XML and turns into a percentage
                        $bright = ([int]$XmlDocument.LED_info.Area_info[$m].Bri + 1) * 10
                        write-host "zone" + $m
                        & $path -z $m -c $rgb  -b $bright
                        #Sleeping exec commands to quickly can overload the buffer
                        sleep 2
                    } elseif ($zone -like "*D_LED_TYPE_2") {
                        #write-host "digital TBA"
                    } elseif ($zone -like "*NA") {
                        #Do nothing as no zone
                    } else {
                        write-host "shouldn't occur"
                    }
                    $m+=1
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
