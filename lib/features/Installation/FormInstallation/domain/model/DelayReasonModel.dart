class DelayReasonModel {
  dynamic id;
  String? name;
  DelayReasonModel({this.name, this.id});

  static getCheckData() {
    List<DelayReasonModel> delayReasonList = [];
    delayReasonList.add(DelayReasonModel(id: "1", name: "Select Delay Reason"));
    delayReasonList.add(DelayReasonModel(id: "2", name: "Pipeline not charged"));
    delayReasonList.add(DelayReasonModel(id: "3", name: "Contractor not available"));
    delayReasonList.add(DelayReasonModel(id: "4", name: "Customer hold"));
    delayReasonList.add(DelayReasonModel(id: "5", name: "Customer unavailable"));

    return delayReasonList;
  }

  @override
  String toString() {
    // TODO: implement toString
    return name.toString();
  }
}
