class PurchaseModel {
  String id,
      model,
      firebaseId,
      productName,
      quantity,
      unitPrice,
      vendorName,
      vendorId,
      description,
      country;

  PurchaseModel(
      this.firebaseId,
      this.id,
      this.model,
      this.productName,
      this.quantity,
      this.unitPrice,
      this.vendorName,
      this.vendorId,
      this.description,
      this.country);
}
