echo "Starting Mailing Task"
cd C:\Users\shanglieh\Documents\movie_list
Get-ChildItem $Path | Where{$_.Name -Match ".*.txt"} | Remove-Item 
tree 'D:\電影' /F > "$(get-date -f yyyy-MM-dd)-movie_list.txt"
echo "Done!"