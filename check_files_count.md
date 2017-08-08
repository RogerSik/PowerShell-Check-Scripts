Description:

Counts the files in a directory and give a list if -ListFiles is True

Example Usage:
# Basic: Count Files and show result
.\check_files_count.ps1 -Path "C:\" -warning 5 -critical 10 -Listfiles $True

# Count Files with the file extension .ps1 and show result
.\check_files_count.ps1 -Path "C:\*.ps1" -warning 50 -critical 100
