class ModelTheses {
  String? thesesStatus,
      nameTheses,
      linkTheses,
      degreeTheses,
      assistantSupervisors,
      nameSupervisors,
      userId,id;
  bool? isFav;

  ModelTheses(
      {this.isFav,
        this.degreeTheses,
        this.assistantSupervisors,
        this.linkTheses,
        this.nameTheses,
        this.thesesStatus,
        this.nameSupervisors,
        this.userId,
        this.id});
}
