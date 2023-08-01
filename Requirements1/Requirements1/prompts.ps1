#Rhaje Evans-Harris    #Student ID: 010765647

#Prompt the user until key 5 is pressed
do {
    # Display the menu
    Write-Host "Menu:"
    Write-Host "1. List .log files in Requirements1 folder"
    Write-Host "2. List files in Requirements1 folder in alphabetical order"
    Write-Host "3. Show current CPU and memory usage"
    Write-Host "4. List running processes sorted by virtual size"
    Write-Host "5. Exit"

    # Get the user input
    $choice = Read-Host "Enter your choice"

    #Process the user input
    switch ($choice) {
        1 {
            #Step B1: List .log files in Requirements folder with current date and redirect to DailyLog.txt
            $logFiles = Get-ChildItem -Filter "*.log" | Select-Object -ExpandProperty Name
            $logFilesWithDate = "$(Get-Date) - $($logFiles -join ', ')"
            Add-Content -Path ".\DailyLog.txt" -Value $logFilesWithDate
        }
        2 {
            #Step B2: List files in Requirements folder in alphabetical order and redirect to C916contents.txt
            $files = Get-ChildItem | Select-Object Name
            $files | Sort-Object -Property Name | Format-Table -AutoSize | Out-File -FilePath ".\C916contents.txt"
        }
        3 {
            #Step B3: Show current CPU and memory usage
            $cpuUsage = Get-CimInstance -Class Win32_Processor | Select-Object -ExpandProperty LoadPercentage
            $memoryUsage = Get-CimInstance -Class Win32_OperatingSystem | Select-Object -Property FreePhysicalMemory, TotalVisibleMemorySize

            Write-Host "CPU Usage: $cpuUsage%"
            Write-Host "Free Physical Memory: $($memoryUsage.FreePhysicalMemory) KB"
            Write-Host "Total Visible Memory: $($memoryUsage.TotalVisibleMemorySize) KB"
        }
        4 {
            #Step B4: List running processes sorted by virtual size in grid format
            Get-Process | Sort-Object -Property VM | Format-Table -Autosize | Out-String
        }
        5 {
            #Step B5: Exit the script
            break
        }
        default {
            #Invalid Choice
            Write-Host "Invalid Choice! Please try again."
        }
    }
} while ($choice -ne "5")

#Exception handling for System.OutOfMemoryException
try {
    #Step D: Your code that may throw an OutOfMemoryException
}
catch [System.OutOfMemoryException] {
    Write-Host "An OutOfMemoryException occurred!"
}

#Take screenshots and save them in Requirements folder
#Step E: Code to capture screenshots goes here

#Compress all files in Requirements1 Folder to a ZIP archive
Compress-Archive -Path ".\Requirements1\" -Destination ".\Requirements1.zip"