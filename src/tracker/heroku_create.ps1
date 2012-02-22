git init
heroku create tracker1 --stack cedar
heroku addons:add mongohq:free

. {.\heroku_deploy.ps1}