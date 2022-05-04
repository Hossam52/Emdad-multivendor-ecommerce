//
abstract class VendorOrderStates {}

class IntitalVendorOrderState extends VendorOrderStates {}

//
class EditItemPriceState extends VendorOrderStates {}

class EditAdditionalItemPriceState extends VendorOrderStates {}

class EditShippingPriceState extends VendorOrderStates {}

//GetVendorOrder online fetch data
class GetVendorOrderLoadingState extends VendorOrderStates {}

class GetVendorOrderSuccessState extends VendorOrderStates {}

class GetVendorOrderErrorState extends VendorOrderStates {
  final String error;
  GetVendorOrderErrorState({required this.error});
}

//QuoteOrder online fetch data
class QuoteOrderLoadingState extends VendorOrderStates {}

class QuoteOrderSuccessState extends VendorOrderStates {}

class QuoteOrderErrorState extends VendorOrderStates {
  final String error;
  QuoteOrderErrorState({required this.error});
}