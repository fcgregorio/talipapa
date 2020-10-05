class Product {
  final String prodName, prodDescription, prodOwner,_type;
  final String prodPrice;
  final String prodImages;
  var _id;
  Product(this.prodOwner, this.prodName, this.prodPrice,
      this.prodDescription, this.prodImages,this._type );
  Product.withID(this._id, this.prodOwner, this.prodName, this.prodPrice,
      this.prodDescription, this.prodImages,this._type);

  dynamic getId() {
    return this._id;
  }

  String getProdName() {
    return prodName;
  }

  String getProdOwner() {
    return prodOwner;
  }

  String getProdDescription() {
    return prodDescription;
  }

  String getProdPrice() {
    return prodPrice;
  }

  String getProdImages() {
    return prodImages;
  }
  String getType() {
    return _type;
  }
}
