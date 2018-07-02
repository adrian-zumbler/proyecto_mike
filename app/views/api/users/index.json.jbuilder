json.id @user.id
json.name @user.name
json.first_last_name @user.first_last_name
json.second_last_name @user.second_last_name
json.id @user.id
json.email @user.email
json.username @user.username
json.birth_date @user.birth_date.strftime("%Y-%M-%dT%H:%M:%S.%L")