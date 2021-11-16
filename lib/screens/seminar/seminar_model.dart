class SeminarModel {
  String? seminartitle,
      username,
      location,
      discription,
      link,
      userid,
      from,
      to,
      docId;
  var selectday;
  int? type;
  bool ?isFav;

  SeminarModel(
      {this.location,
      this.to,
      this.link,
      this.from,
      this.type,
      this.isFav,
      this.discription,
      this.username,
      this.selectday,
      this.docId,
      this.seminartitle,
      this.userid});
}
