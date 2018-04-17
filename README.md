# backup.sh
Loop dumps all mysql database and project files

Some things to consider to make this fully automated:
1. Make a mysqldump user/pass file
2. SSH Key

Create whatever filename you want so mysqldump won't prompt you with a password
`[mysqldump]
user=your_user
password=your_pass`