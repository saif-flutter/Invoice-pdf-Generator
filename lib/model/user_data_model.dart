class UserModel{
   String invoiceDate;
   String dueDate;
   String byOrganization;
   String byEmail;
   String byAddress;
   String byPhone;
   String toOrganization;
   String toEmail;
   String toAddress;
   String toPhone;
   List<Map<String,dynamic>>  items;
   String itemName;
   String  itemQuantity;
   String itemPrice;
   String description;
   String terms;

  UserModel({
    required this.invoiceDate,
    required this.dueDate,
    required this.byOrganization,
    required this.byEmail,
    required this.byAddress,
    required this.byPhone,
    required this.toOrganization,
    required this.toEmail,
    required this.toAddress,
    required this.toPhone,
    required this.items,
    required this.itemName,
    required this.itemQuantity,
    required this.itemPrice,
    required this.description,
    required this.terms

});

}