class ModelProductItem {


  /*

Full texts
id
seller
item_name
unit_cost
no_of_units
start_date
end_date
tax

  */

  String id;
  String item_name;
  String unit_cost;
  String no_of_units;
  String start_date;
  String end_date;
  String tax;


  ModelProductItem.named({this.id, this.item_name, this.unit_cost, this.no_of_units,
      this.start_date, this.end_date, this.tax});





  @override
  String toString() {
    // TODO: implement toString
    return "Name: $item_name \t Cost: $unit_cost \t Quantity: $no_of_units" ;
  }
}
