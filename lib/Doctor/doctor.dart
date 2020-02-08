class doctorDetails1{
  String name;
  String emailId;
  String photoUrl;
  String uid;
  String specialization;
  String phoneNumber;
  String address;

  doctorDetails1({this.name, this.emailId, this.photoUrl, this.uid, this.phoneNumber, this.specialization, this.address});

  Map toMap(doctorDetails1 doctorDetails){
    var data=Map<String, String>();
    data['name']=doctorDetails.name;
    data['emailId']=doctorDetails.emailId;
    data['photoUrl']=doctorDetails.photoUrl;
    data['uid']=doctorDetails.uid;

    return data;
  }
  Map toSecondMap(doctorDetails1 doctorDetails){
    var data=Map<String, String>();
    data['name']=doctorDetails.name;
    data['emailId']=doctorDetails.emailId;
    data['photoUrl']=doctorDetails.photoUrl;
    data['uid']=doctorDetails.uid;
    data['phoneNumber']=doctorDetails.phoneNumber;
    data['specialization']=doctorDetails.specialization;
    data['address']=doctorDetails.address;

    return data;
  }

  doctorDetails1.fromMap(Map<String, String> mapData) {
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