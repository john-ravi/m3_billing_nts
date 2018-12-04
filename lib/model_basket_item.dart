import 'model_product_items.dart';

class ModelBasketItem {
  /*
  * 
  * 
id	seller_name	customer_name	master_list_items	quantity	is_in_basket	delivery_boy_id	master_start_date_time	master_event_interval	customer_id	seller_id	item_id
*/
  ModelProductItem modelProductItem;
  int purchaseQuantity;
  int id;
  String seller_name, customer_name, master_list_item, quantity;
  bool is_in_basket;
  String delivery_boy_id;
  DateTime master_start_date_time;
  int master_event_interval, customer_id, seller_id, item_id;

  ModelBasketItem.named(
      {this.modelProductItem, this.id, this.seller_name, this.purchaseQuantity,
        this.customer_name,
        this.master_list_item,
        this.quantity,
      this.is_in_basket,
        this.delivery_boy_id,
      this.master_start_date_time,
      this.master_event_interval,
        this.customer_id,
        this.seller_id,
        this.item_id
      });

  @override
  String toString() {
    return "Basket Item $master_list_item \t quantity requested $purchaseQuantity";
  }
}
