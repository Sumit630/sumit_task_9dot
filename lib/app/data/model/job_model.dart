class JobModel {
  final int id;
  final String jobName;
  final String jobType;
  final String location;
  final String salary;
  final String stateName;
  final String createdAt;

  JobModel({
    required this.id,
    required this.jobName,
    required this.jobType,
    required this.location,
    required this.salary,
    required this.stateName,
    required this.createdAt,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'],
      jobName: json['job_name'] ?? '',
      jobType: json['job_type_name'] ?? '',
      location: json['job_location'] ?? '',
      salary: json['salary'] ?? '',
      stateName: json['state_name'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}
