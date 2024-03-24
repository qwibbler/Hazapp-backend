json.message @message
json.user do
  json.id @user.id
  json.username @user.username
  json.displayname @user.displayname
  json.roleName @user.role_name
  json.maslaId @user.masla_id
end
