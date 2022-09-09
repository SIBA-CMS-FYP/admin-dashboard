class TechGetReq {
  TechGetReq({
    required this.row,
  });
  late final List<Row> row;

  TechGetReq.fromJson(Map<String, dynamic> json) {
    row = List.from(json['row']).map((e) => Row.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['row'] = row.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Row {
  Row({
    required this.Name,
    required this.CMS,
    required this.courseTitle,
    required this.Course_Code,
    required this.isWithdraw,
    required this.isTeacherAcp,
    required this.isHODAcept,
  });
  late final String Name;
  late final String CMS;
  late final String courseTitle;
  late final String Course_Code;
  late final int isWithdraw;
  late final int isTeacherAcp;
  late final int isHODAcept;

  Row.fromJson(Map<String, dynamic> json) {
    Name = json['Name'];
    CMS = json['CMS'];
    courseTitle = json['course_title'];
    Course_Code = json['Course_Code'];
    isWithdraw = json['isWithdraw'];
    isTeacherAcp = json['isTeacherAcp'];
    isHODAcept = json['isHODAcept'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Name'] = Name;
    _data['CMS'] = CMS;
    _data['course_title'] = courseTitle;
    _data['Course_Code'] = Course_Code;
    _data['isWithdraw'] = isWithdraw;
    _data['isTeacherAcp'] = isTeacherAcp;
    _data['isHODAcept'] = isHODAcept;
    return _data;
  }
}
