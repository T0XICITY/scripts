cls
#Script merges 2 specific collumns from 2 different CSV files into 1 file 

#Specify the main list to add entries
$mainList = Read-Host -Prompt 'Specify the Main-List to be extended by another one'
$mainList = Import-Csv $mainList ";"

#Specify the second list
$secondList = Read-Host -Prompt 'Specify the Second-List to extract values from'
$secondList = Import-Csv $secondList ";"

#Print Main-List Names
$ColNamesMain =  $mainList[0].psobject.Properties.name
echo "Main-List contains the following column names:" 
##Write-Output $ColNames

#Print Secon-List Names
$ColNamesSecond =  $secondList[0].psobject.Properties.name
echo "Second-List contains the following column names:" 
##Write-Output $ColNames

#Input Rev-Value
$revValue = Read-Host -Prompt 'Enter the reference value and make sure that it is included in both files (ex. Host IP)'
if($ColNamesMain -NotContains $revValue -OR $ColNamesSecond -NotContains $revValue){
	throw "One of the lists does not contain the defined column name"
}

#Specify value to be adopted
$addValue = Read-Host -Prompt 'Specify the values to be adopted'
if($ColNamesMain -NotContains $addValue -OR $ColNamesSecond -NotContains $addValue){
	throw "One of the lists does not contain the defined column name"
}


#Check which values are included in both lists and add any missing values.
foreach ($system2 in $secondList){ 
	foreach($system1 in $mainList){
		#Tausche hier gehen Input gegen was ist zu prüfen ip oder Host name
		if($system1.$revValue -eq $system2.$revValue){
			#Check if value in Main is currently Empty
			if([string]::IsNullOrWhiteSpace($system1.$addValue)){
				#Check if value exists in Second
				if(![string]::IsNullOrWhiteSpace($system2.$addValue)){
				#add value to Main-List
				$system1.$addValue = $system2.$addValue
				Write-Host added: $system2.$addValue "for" $system1.$revValue 
				}		
			}			
		}
	}
}

#Save to new List
$mainList | Export-Csv C:\Users\*****\Desktop\Merged.csv