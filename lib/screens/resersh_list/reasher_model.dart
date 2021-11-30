class ResearchModel {
  String ?userId,phone,name,link,imageUrl, token,faculty,email,degree,id;
  int accept;
  List fields;
  ResearchModel({
    //this.phoneview,
    this.degree,
    this.name,
    this.email,
    this.token,
    required this.accept,
    this.link,
    this.faculty,
    this.phone,
    this.userId,
    this.imageUrl,
    this.id,
    required this.fields,

});
}