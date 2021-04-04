echo "Starting Mailing Task"
cd C:\Users\shanglieh\Documents\movie_list
# Remove all .txt file
Get-ChildItem $Path | Where{$_.Name -Match ".*.txt"} | Remove-Item 
# init file
echo "$(get-date -f yyyy-MM-dd) Movie List" > "$(get-date -f yyyy-MM-dd)-movie_list.txt"
# 電影
Get-ChildItem 'D:\電影' | Where-Object { $_.CreationTime.Date -lt (Get-Date).Date } | Sort CreationTime -Descending | Select-Object CreationTime,Name | Format-Table -Wrap >> "$(get-date -f yyyy-MM-dd)-movie_list.txt"
# 電影詳細
tree 'D:\電影' /F >> "$(get-date -f yyyy-MM-dd)-movie_list.txt"
# 電視劇
Get-ChildItem 'D:\電視劇' | Where-Object { $_.CreationTime.Date -lt (Get-Date).Date } | Sort CreationTime -Descending | Select-Object CreationTime,Name | Format-Table -Wrap >> "$(get-date -f yyyy-MM-dd)-movie_list.txt"
# 電視劇詳細
Get-ChildItem 'D:\電視劇' -Depth 1 | Where-Object { $_.CreationTime.Date -lt (Get-Date).Date } | Sort CreationTime -Descending | Format-Table -Wrap >> "$(get-date -f yyyy-MM-dd)-movie_list.txt"
# Start Email process
Start-Process -FilePath "C:\Users\shanglieh\Documents\movie_list\send_email.exe"
echo "Done!"


