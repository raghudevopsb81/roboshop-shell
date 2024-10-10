source common.sh
app_name=dispatch

print_heading "Copy Dispatch Service file"
cp dispatch.service /etc/systemd/system/dispatch.service &>>$log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32m  SUCCESS \e[0m"
else
  echo -e "\e[31m  FAILURE \e[0m"
fi

print_heading "Install GoLang"
dnf install golang -y &>>$log_file
echo $?

app_prerequisites

print_heading "Copy Download Application Dependencies"
go mod init dispatch &>>$log_file
go get &>>$log_file
go build &>>$log_file
echo $?

print_heading "Start Application Service"
systemctl daemon-reload &>>$log_file
systemctl enable dispatch &>>$log_file
systemctl restart dispatch &>>$log_file
echo $?
