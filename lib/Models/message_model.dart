class message_model
{
  final String message;
  final String id;
   dynamic time;

  message_model(this.message,this.id,this.time);
  factory message_model.fromJson(json_data)
  {
    return message_model(json_data['message'],json_data['id'],json_data['time']);

  }
}