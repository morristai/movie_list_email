echo "Starting Mailing Task"
cd C:\Users\shanglieh\Documents\movie_list
Get-ChildItem $Path | Where{$_.Name -Match ".*.txt"} | Remove-Item 
echo "$(get-date -f yyyy-MM-dd) Movie List" > "$(get-date -f yyyy-MM-dd)-movie_list.txt"
Get-ChildItem 'D:\電影' | Where-Object { $_.CreationTime.Date -lt (Get-Date).Date } | Sort CreationTime -Descending | Select-Object CreationTime,Name | Format-Table -Wrap >> "$(get-date -f yyyy-MM-dd)-movie_list.txt"
tree 'D:\電影' /F >> "$(get-date -f yyyy-MM-dd)-movie_list.txt"
Start-Process -FilePath "C:\Users\shanglieh\Documents\movie_list\send_email.exe"
echo "Done!"


