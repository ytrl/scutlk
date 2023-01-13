param(
	[Parameter(Position=0)][string]$run,
    [Parameter(Position=1)][string]$1,
    [Parameter(Position=2)][string]$2,
    [Parameter(Position=3,ValueFromRemainingArguments=$true)][string[]]$3
)
$query = "$1 $2 $3"
$Aliases = @{

<# ------------------------------------------------------------------------------------------------------------------

    Add your own shortcuts!
       
        -  al = a shortened version of your desired shortcut alias (recommend 2 letters)
        -  alias = your desired shortcut alias
        -  args = if your shortcut can be launched with parameters (e.g. query on youtube)
    
    Call your shortcuts in Run, with `s <al/alias> <args>`
    (e.g. `s gl how to tie a tie`)

    "<link/path>"                                                  = @('<al>'   ,'<alias>') : regular syntax

------------------------------------------ USER EDITING STARTS HERE ------------------------------------------------- #>


#    ! LINK/PATH                                                    ! ALIASES

    <#  PRODUCTIVITY  #>       # notion

    "https://classsroom.google.com"                                = @('cl'     ,'classroom')
    "notion://www.notion.so/11phya-048083216ced42e79f29104593512136"= @('phy'     ,'physics')
    "notion://www.notion.so/12ecob-d43847ad4b0147f38bb39e19dfe7f6a5"= @('eco'     ,'econ')
    "notion://www.notion.so/11frec-fd34a8876f074f739ff99eeb8e85368a"= @('fre'     ,'francais')
    "notion://www.notion.so/11lsd-77af953cda7841eb83a2796d4eb9e185" = @('leg'     ,'legal')
    "notion://www.notion.so/11mmee-8039465670524c199a640388293331f6"= @('met'     ,'methods')
    "notion://www.notion.so/11litf-d8430b4aafb64c0f83bed0e21f224897"= @('lit'     ,'literature')

    <#  BOOKMARKS / ESSENTIALS #>

    "https://www.google.com/search?q=$query"                       = @('g'      ,'google')
    "https://www.desmos.com/calculator"                            = @('dm'     ,'desmosGraph')
    "https://suzannecoryhs-vic.compass.education/"                 = @('co'     ,'compass')
    "https://github.com/search?q=$query"                           = @('gh'     ,'github')
    "https://www.educationperfect.com/"                            = @('ep'     ,'educationPerfect')
    "https://edrolo.com.au/account/courses/"                       = @('edr'    ,'edrolo')
    
    <# MORE PRODUCTIVITY #>
    "C:\Program Files\Adobe\Adobe Photoshop 2023\Photoshop.exe"    = @('psd'     ,'photoshop')
    "C:\Program Files\VEGAS\VEGAS Pro 16.0\vegas160.exe"           = @('veg'     ,'vegas')
    "C:\Program Files\Microsoft Office\root\Office16\POWERPNT.EXE" = @('pp'      ,'powerpoint')
    "C:\Program Files\Microsoft Office\root\Office16\WINWORD.EXE"  = @('wrd'     ,'word')
    
    <#  GSUITE  #>
 
    "https://docs.google.com/document/u/0/?tgif=d&q=$query"        = @('do'     ,'docs')
    "https://docs.google.com/presentation/u/0/?tgif=d&q=$query"    = @('sl'     ,'slides')
    "https://docs.google.com/spreadsheets/u/0/?tgif=d&q=$query"    = @('sh'     ,'sheets')
    "https://sites.google.com/new?tgif=d&q=$query"                 = @('si'     ,'sites')

    <#  LEISURE  #>

    "https://www.pinterest.com.au/search/pins/?q=$query"           = @('pin'    ,'pinterest')
    "https://twitter.com/search?q=$query"                          = @('tw'     ,'twitter')
    "https://www.youtube.com/results?search_query=$query"          = @('yt'     ,'youtube')
    "https://www.instagram.com"                                    = @('ig'     ,'instagram')
    "C:\Program Files (x86)\Steam\steam.exe"                       = @('sm'     ,'steam')
    "steam://rungameid/730"                                        = @('csgo'   ,'csgo')
    "discord://discord.com"                                        = @('dcd'    ,'discord')
    
    <#  SYSTEM APPS  #>

    "taskmgr"                                                      = @('tm'     ,'taskManager')
    "control"                                                      = @('ct'     ,'controlPanel')
    "powershell"                                                   = @('wt'     ,'powershell')
}
    <#  TOOLS/SCOOP APPS  #>   

    $everything_alias                                              =   'ev'    #,'everything'  # search for any file/folder on your desktop (e.g. `s ev <query>`) (rq. everything.exe)
    $ytdownloader_alias                                            =   'ytdl'  #,'ytDownload'  # simple youtube downloader as mp4 or mp3 (e.g. `s ytdl mp4 <output name> <url>`) (rq. yt-dlp + ffmpeg)
        $dls = "$env:userprofile\downloads" # specify a default folder to download to if you want ($dls = <path>)

    $translate_alias                                               =   'tr'    #,'translate'   # translate with deepL (e.g. `s tr <langfrom> <langto> <query>)
    $textgrab_alias                                                =   'tg'    #,'textgrab'   # screenshot or 'snip' any text and copy it to clipboard
    $docto_alias                                                   =   'pdf'   #,'convertpdf'  # converts word, excel, powerpoint files to pdf (e.g. `s cv <doctype> <path>`)(rq. office authenticated)

    $shutdown_alias                                                =   'off'   #,'shutdown' 
    $restart_alias                                                 =   'rst'   #,'restart'
    $advancedboot_alias                                            =   'abo'   #,'advancedBoot'

<# --------------------------------------- USER EDITING STOPS HERE -------------------------------------------------- #>

Foreach($applink in $Aliases.Keys) { # loops hashtable
	if ($appstart){continue}
	if ($run -in $Aliases.$applink){
		$appstart = $applink
}
}

if ($run -eq "edit"){ # edit the script in windows notepad
    start-process notepad.exe $PSScriptRoot\scutl.ps1
}

if ($run -eq $shutdown_alias){
    stop-computer
}
if ($run -eq $restart_alias){
    restart-computer
}
if ($run -eq $advancedboot_alias){
    shutdown.exe /r /o
}

if ($run -eq $translate_alias -or $run -eq "translate"){ # translate detection

    $langfrom = $1
    $langto = $2
    $query = $3
    start-process "https://www.deepl.com/en/translator#$langfrom/$langto/$query" -windowstyle hidden
    exit
}

if ($run -eq $docto_alias -or $run -eq "convertpdf"){ # pdf convert detection

    $doctype = $1
    $pathtodoc = $2
    $pathfolder = (get-item $pathtodoc).Directory.FullName
    $filename = Split-Path $pathtodoc -leaf
    $trustedloc = "$env:userprofile\AppData\Roaming\Microsoft\Word\STARTUP\$filename"
    Copy-Item -Path $pathtodoc -Destination $trustedloc
    if ($doctype -eq "docx" -or $doctype -eq "doc"){
        $cvformat = "wdFormatPDF"
    }
    if ($doctype -eq "pptx" -or $doctype -eq "ppt"){
        $cvformat = "ppFormatPDF"
    }
    if ($doctype -eq "xlsx" -or $doctype -eq "xls"){
        $cvformat = "xlFormatPDF"
    }
    $cvcmd = Docto -f $trustedloc -o $pathfolder -t $cvformat
    $cvcmd
    remove-item $trustedloc
    start-process $pathfolder
    exit
}

if ($run -eq "$ytdownloader_alias" -or $run -eq "download"){ # ytdl detection

    $format = $1
    $oname = $2
    $url = "$3"

    if ($format -eq "mp3"){
        yt-dlp.exe -f 'ba' -x --audio-format mp3 $url -o "$oname.mp3" -P $dls
        Start-Process $dls
        exit
    }

    if ($format -eq "mp4"){
        yt-dlp.exe -f mp4 $url -o "$oname.mp4" -P $dls
        Start-Process $dls
        exit
    }
}

if ($run -eq "$everything_alias" -or $run -eq "everything"){ # everything.exe detection

    $query = @"
    "$1 $2 $3
"@
    Start-Process everything.exe -windowstyle hidden -ArgumentList @("-s $query")
    exit
}

if ($run -eq "$textgrab_alias" -or $run -eq "textgrab"){ # text-grab detection
    powershell -windowstyle hidden -command "text-grab.exe"
    exit
}

if ($run -eq "install"){
    $appsfolder = (get-item $PSScriptRoot).Parent.Parent.FullName
    powershell scoop install $1
    start-process $appsfolder\$1\current
}
if ($run -eq "uninstall"){
    powershell scoop uninstall $1
}
if ($run -eq "maintain"){
    powershell scoop update *
    powershell scoop cleanup *
}

<# -------------------------------------- Help -------------------------------------- #>

if (!$run){
	@"

      .      \   ,
   .          o     .                 .                   .            .
     .         \                 ,             .                .
               #\##\#      .                              .        .
             #  #O##\###                .                        .
   .        #*#  #\##\###                       .                     ,
        .   ##*#  #\##\##               .                     .
      .      ##*#  #o##\#         .                             ,       .
          .     *#  #\#     .                    .             .          ,
                      \          .                         .
____^/\___^--____/\____O______________/\/\---/\___________---______________
   /\^   ^  ^    ^                  ^^ ^  \ ^          ^       ---
         --           -            --  -      -         ---  __       ^
   --  __                      ___--  ^  ^                         --  __    
scutlk 1.1 titan by x.gd/brryan                               (x.gd/kzwkzw)


"@ | Write-Output
    Write-Host "    all commands are called with 's <command>'. list of commands below:   " -ForegroundColor Green
    @"

    - edit/open the script 's edit'
    
        Tools  's <arg1> <arg2> <arg3>'

    - youtube downloader  (ytdl <mp3/mp4> <output name> <url>)
    - search for any file/folder  (ev <query>)
    - snip on-screen text to clipboard  (tg)
    - convert word/ppt/excel to pdf  (pdf <docx/pptx/xlsx> <filepath>)
    - scoop (install/uninstall/maintain) (maintain updates and cleans up all apps)

        Launchables  's <name> <query>'
    
    - Google  (g)
    - G-suite  (do,sh,sl,si)
    - Notion (phy,eco,fre,leg,met,lit)
    - Misc Prod (ep,edr)
    - Misc Creativity (psd,veg,pp,wrd)
    - Compass  (co)
    - Youtube  (yt)
    - Twitter  (tw)
    - Pinterest  (pin)
    - Desmos graph  (dm)
    - Games (sm,csgo,dcd)
    - Github  (gh)

        System 's <command>'
    
    - control panel  (ct)
    - task manager  (tm)
    - shut down  (off)
    - restart  (rst)
    - advanced boot  (abo)
"@ | Write-Output
    Start-Sleep 2147483
    exit
}

start-process $appstart
