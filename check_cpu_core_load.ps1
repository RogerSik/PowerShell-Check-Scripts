(Get-WmiObject -Query "select Name, PercentProcessorTime from Win32_PerfFormattedData_PerfOS_Processor") | foreach-object { write-host "$($_.Name): $($_.PercentProcessorTime)" };
