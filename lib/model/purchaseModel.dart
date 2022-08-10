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
      country,
  date;

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
      this.country,
      this.date);
}
