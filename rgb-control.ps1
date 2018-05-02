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
$path = $PSScriptRoot + "\RGBFusionTool.exe"
$zones = & $path --list
sleep 3


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
            $build=""
            if ($c -eq 0) {
                $m=0
                foreach ($zone in $zones) {
                    if ($zone  -like "*A_LED") {
                        #Get Color and turn it into RGB HEX
                        [long]$long = $XmlDocument.LED_info.Area_info[$m].But_Arg[0].startColor
                        $hex = '{0:X}' -F $long
                        $rgb = $hex.substring(2)

                        #Gets Brightness from XML and turns into a percentage
                        $bright = ([int]$XmlDocument.LED_info.Area_info[$m].Bri + 1) * 10
                        
                        #Gets Pattern
                        $pattern = [int]$XmlDocument.LED_info.Area_info[$m].Pattern_Type
                        $speed = (50 / [int]$XmlDocument.LED_info.Area_info[$m].Speed)

                        switch ( $pattern ) {
                            #Static
                            0 { $type=" --color="+$rgb+" --brightness="+$bright }
                            #Pulse
                            1 { $type=" --pulse="+$rgb+" --fadeon="+$speed+" --fadeoff="+$speed+" --maxbrightness="+$bright+" --minbrightness=0" }
                            #Flash
                            #4 { $type=" --flash="+$rgb+"  --count=1 --interval=10 --maxbrightness="+$bright+" --minbrightness=0" } #--flashcycle=1  --count=1 --time=1 --interval=4
                            #Color Cycle
                            9 { $type=" --cycle="+$speed+" --brightness="+$bright }
                            #Double Flash
                            #11 { $type="double flash" }
                            #Failsafe
                            default { $type = " --color="+$rgb+" --brightness="+$bright }
                        }
                        
                        $build += " --zone="+$m+$type
                    } elseif ($zone -like "*D_LED_TYPE_2") {
                        #write-host "digital TBA"
                    } elseif ($zone -like "*NA") {
                        #Do nothing as no zone exists
                    } else {
                        write-host "shouldn't occur"
                    }
                    $m+=1
                }


                & $path $build.split(" ")
                write-host $path $build.split(" ")
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