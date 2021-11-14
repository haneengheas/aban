class SeminarModel {
  String? seminartitle, username, location, discription, link, userid, from, to;
  DateTime? selectday;
  int? type;

  SeminarModel(
      {this.location,
      this.to,
      this.link,
      this.from,
      this.type,
      this.discription,
      this.username,
      this.selectday,
      this.seminartitle,
      this.userid});
}
