class ProjectModel {
  String? descriptionProject,
      leaderName,
      memberProjectName,
      projectStatus,
      projectName,
      userId,id;
  bool? isFav;

  ProjectModel(
      {this.isFav,
      this.descriptionProject,
      this.leaderName,
      this.projectName,
      this.memberProjectName,
      this.projectStatus,
      this.userId,
      this.id});
}
