class DelayStatusModel {
  dynamic id;
  String? name;
  DelayStatusModel({ this.name, this.id});


  static getDelayStatusData() {
    List<DelayStatusModel> listOfDelayStatus = [];
    listOfDelayStatus.add(DelayStatusModel(
        id: "1",
        name: "Yes"
    )
    );
    listOfDelayStatus.add(DelayStatusModel(
        id: "2",
        name: "No"
    )
    );

    return listOfDelayStatus;
  }

  @override
  String toString() {
    // TODO: implement toString
    return name.toString();
  }
}