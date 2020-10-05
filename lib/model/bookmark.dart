class Bookmark {
  final String _prodName, _bookmarkOwner, _prodOwner, _prodDescription, _type;
  final String _prodPrice;
  final String _prodImages;
  var _id;
  Bookmark(this._bookmarkOwner, this._prodName, this._prodPrice,
      this._prodOwner, this._prodDescription, this._prodImages, this._type);
  Bookmark.withID(
      this._id,
      this._bookmarkOwner,
      this._prodName,
      this._prodPrice,
      this._prodOwner,
      this._prodDescription,
      this._prodImages,
      this._type);

  dynamic getId() {
    return this._id;
  }

  String getbookmarkOwner() {
    return _bookmarkOwner;
  }

  String getProdName() {
    return _prodName;
  }

  String getProdPrice() {
    return _prodPrice;
  }

  String getProdOwner() {
    return _prodOwner;
  }

  String getProdDescription() {
    return _prodDescription;
  }

  String getProdImages() {
    return _prodImages;
  }

  String getType() {
    return _type;
  }
}
