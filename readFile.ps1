#--------------------------------------------------------------------------------- 
## Header ###
# This script is written to read detailed shared folders list 
# for the runShareFolderPolicy.bat file. And find shared with everyone directories.
# author        "iffet Kurukose"
# date          15.08.2016
# contact       oguz.iffet@gmail.com
#---------------------------------------------------------------------------------

$reader = [System.IO.File]::OpenText("detailedShareList.txt")
try {
	$sharedFoldersArray = @()
	$securityPrincipalArray = @()

    for() {
        $line = $reader.ReadLine()
        if ($line -eq $null) { break }
        # process the line
        if ($line -ne "") { 
			
			if($line.StartsWith("SharedFolderName")) {
				$arr = @($line.split(':'))
				$sharedFoldersArray += $arr[1].Trim()

			}
			if($line.StartsWith("SecurityPrincipal")) {
				$arr2 = @($line.split(':'))
				$securityPrincipalArray += $arr2[1].Trim()
			} 
		}
    }
	$i = 0
	foreach ($element in $securityPrincipalArray) {
		if ($element -eq "Everyone") {
			echo $sharedFoldersArray[$i]
		}
		$i = $i + 1;
	}
	
}
finally {
    $reader.Close()
}
#---------------------------------------------------------------------------------