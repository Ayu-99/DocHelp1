class patientDetails{
  String name;
  String emailId;
  String photoUrl;
  String uid;

  patientDetails({this.name, this.emailId, this.photoUrl, this.uid});

  Map toMap(patientDetails patientDetails){
    var data=Map<String, String>();
    data['name']=patientDetails.name;
    data['emailId']=patientDetails.emailId;
    data['photoUrl']=patientDetails.photoUrl;
    data['uid']=patientDetails.uid;

    return data;
  }

  patientDetails.fromMap(Map<String, String> mapData) {
    this.name = mapData['name'];
    this.emailId = mapData['emailId'];
    this.photoUrl = mapData['photoUrl'];
    this.uid = mapData['uid'];
  }

  String get _name => name;
  String get _emailId => emailId;
  String get _photoUrl => photoUrl;
  String get _uid => uid;

  set _photoUrl(String photoUrl) {
    this.photoUrl = photoUrl;
  }

  set _name(String name) {
    this.name = name;
  }

  set _emailId(String emailId) {
    this.emailId = emailId;
  }

  set _uid(String uid) {
    this.uid = uid;
  }

}