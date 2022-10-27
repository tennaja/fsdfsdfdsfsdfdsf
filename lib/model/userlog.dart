class Logstatus {
  String log_id;
  String log_status;
  String log_userid;
  String log_date;
  Logstatus({
    required this.log_id,
    required this.log_status,
    required this.log_userid,
    required this.log_date,
  });

  factory Logstatus.fromJson(Map<String, dynamic> json) {
    return Logstatus(
      log_id: json['log_id'] as String,
      log_status: json['log_status'] as String,
      log_userid: json['log_userid'] as String,
      log_date: json['log_date'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'log_id': log_id,
        'log_status': log_status,
        'log_userid': log_userid,
        'log_date': log_date,
      };
}
