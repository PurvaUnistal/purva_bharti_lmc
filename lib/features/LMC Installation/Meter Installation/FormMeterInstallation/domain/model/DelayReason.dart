class DelayReason {
  dynamic id;
  String? name;
  DelayReason({this.name, this.id});

  static getCheckData() {
    List<DelayReason> delayReasonList = [];
    delayReasonList.add(DelayReason(id: "1", name: "Select Delay Reason"));
    delayReasonList.add(DelayReason(id: "2", name: "Pipeline not charged"));
    delayReasonList.add(DelayReason(id: "3", name: "Contractor not available"));
    delayReasonList.add(DelayReason(id: "4", name: "Customer hold"));
    delayReasonList.add(DelayReason(id: "5", name: "Customer unavailable"));

    return delayReasonList;
  }

  @override
  String toString() {
    // TODO: implement toString
    return name.toString();
  }
}
