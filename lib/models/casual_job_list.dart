class CasualJobList{
  int? id;
  String? casual_job_id;
  String? job_title;
  int? client_id;
  int? city_id;
  int? no_of_casuals;
  String? outlet_name;
  String? reporting_person;
  String? designation;
  int? event_type;
  String? start_date;
  String? end_date;
  String? shift_time_start;
  String? shift_time_end;
  int? payment_type;
  int? amount;
  String? job_description;
  String? message_for_casual;
  List<dynamic>? things_to_bring;
  int? status;
  int? quantity;

  toMap() {
    var map = Map<String, dynamic>();
    map['jobId'] = id;
    map['jobName'] = job_title;
    map['jobAmount'] = amount;
    map['jobQuantity'] = quantity;

    return map;
  }
}