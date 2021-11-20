class ProjectModel {
  String? descriptionProject,
      leaderName,
      memberProjectName,
      projectStatus,
      projectName,
      college,
      department,
      userId,
      id;
  bool? isFav;

  ProjectModel(
      {this.isFav,
      this.descriptionProject,
      this.leaderName,
      this.projectName,
      this.memberProjectName,
      this.projectStatus,
      this.college,
      this.department,
      this.userId,
      this.id});
}
