class ToDo {
  ToDo(this._Title, this._time);

  ToDo.fromJson(Map<String, dynamic> paz)
      : _Title = paz["title"],
        _time = DateTime.parse(paz["time"]);

  String _Title;
  DateTime _time;

  String get Title => _Title;

  set Title(String value) {
    _Title = value;
  }

  DateTime get time => _time;

  set time(DateTime value) {
    _time = value;
  }

  Map<String, dynamic> toJson() {
    return {'title': this.Title, "time": this.time.toIso8601String()};
  }
}
