json.array! @messages do |message|
  json.text message.text
  json.image message.image.url
  json.time message.created_at.strftime("%Y/%m/%d %H:%M")
  json.user_name message.user.name
  json.id message.id
end