class Product {
  final String _prodName, _prodDescription;
  final double _prodPrice;
  final List<String> _prodImages;
  Product(
      this._prodName, this._prodPrice, this._prodDescription, this._prodImages);
  String getProdName() {
    return _prodName;
  }

  String getProdDescription() {
    return _prodDescription;
  }

  double getProdPrice() {
    return _prodPrice;
  }

  List<String> getProdImages() {
    return _prodImages;
  }
}
