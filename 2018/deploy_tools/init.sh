scp -r deploy_tools core@$1:
ssh core@$1 sudo mkdir /data
ssh core@$1 sudo cp deploy_tools/valasztas.sqlite3 /data
ssh core@$1 sudo cp deploy_tools/*.service /etc/systemd/system
ssh core@$1 sudo systemctl enable frontend-{1,2,3,4}
ssh core@$1 sudo systemctl start frontend-{1,2,3,4}
