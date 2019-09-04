json.user_name @message.user.name
json.text @message.text
json.time @message.created_at.strftime("%Y/%m/%d %H:%M")
json.image @message.image.url