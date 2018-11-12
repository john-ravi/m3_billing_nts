class Bills {


  /*
Full texts
invoice_number
amount
status
customer_name*/
  String invoice_number;
  String amount;
  String status = "";
  String customer_name = "";

  Bills(this.invoice_number, this.amount, this.status, this.customer_name);




  @override
  String toString() {
    // TODO: implement toString
    return "Name: $customer_name \t Mobile: $invoice_number \t ID: $amount" ;
  }
}
