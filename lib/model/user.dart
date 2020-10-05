class Users {

  final String currentuser, productowner;

  var _id;
  Users(this.currentuser, this.productowner);
  Users.withID(this._id, this.currentuser, this.productowner);

  dynamic getId() {
    return this._id;
  }

  String getCurrentUser() {
    return currentuser;
  }

  String getProdOwner() {
    return productowner;
  }

 
}