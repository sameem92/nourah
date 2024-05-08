import 'package:get/get.dart';
import 'package:producer_family_app/storage/database/cart_db_controller.dart';
import 'package:producer_family_app/storage/models/cart.dart';

class CartGetxController extends GetxController {
  RxList<Cart> cartProducts = <Cart>[].obs;
  var isLoading = true.obs;
  final CartDbController _cartDbController = CartDbController();
static CartGetxController get to =>Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    readItems();
    super.onInit();
  }
  Future <void>refreshCart()async{
  await  readItems();

  }

  Future<bool> createItem({required Cart cart}) async {
    int id = await _cartDbController.create(cart);
    // cartProducts.add(cart);
    if (id != 0) {
      cart.id = id;
      cartProducts.add(cart);
      return true;
    }
    return false;

    // return id != 0;
  }

  Future readItems() async {
    isLoading(true);
    try {
      var show = await _cartDbController.read();
    if (show != null) {
      cartProducts.value = show;
    }
    } finally {
      isLoading(false);
    }
  }




  Future<bool> updateItem({required Cart updatedCart}) async {
    bool status = await _cartDbController.update(updatedCart );
    if (status) {
      int index = cartProducts.indexWhere((element) => element.id == updatedCart.id);
      // if (index != -1) cartProducts.removeAt(index);
      if (index != -1){
      cartProducts[index]=updatedCart ;
      return true;

    }}
    return false;

    // return status;
  }

  Future<bool> deleteItem({required int id}) async {
    bool status = await _cartDbController.delete(id);
    if (status) {
      cartProducts.removeWhere((element) => element.id == id);
      return true;

    }
    return false;
  }
  Future<bool> cleanCart() async {
    bool status = await _cartDbController.cleanCart();
    if(status) {
     { cartProducts.clear();
         _totalPrice = 0;
       _counter = 0;}
    }
    return status;
  }


int _counter=0;
  int get counter=>_counter;

  dynamic _totalPrice=0;
  dynamic get totalPrice=>_totalPrice;

   addTotalPrice(dynamic productPrice){
  _totalPrice=
      _totalPrice+productPrice;
  }

   removeTotalPrice(dynamic productPrice){
    _totalPrice=
        _totalPrice-productPrice;
  }

  dynamic getTotalPrice(){
return _totalPrice;  }
//
  addCounterCustom(int count){
    _counter= _counter+ count;
  }
  removeCounterCustom(int count){
    _counter= _counter- count;
  }
   addCounter(){
    _counter++;
   }
   removeCounter(){
    _counter--;
   }
  int getCounter(){
return _counter;
}


}
