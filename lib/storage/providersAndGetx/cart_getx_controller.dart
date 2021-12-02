import 'package:get/get.dart';
import 'package:producer_family_app/storage/database/cart_db_controller.dart';
import 'package:producer_family_app/storage/models/database/cart.dart';

class CartGetxController extends GetxController {
  RxList<Cart> cartProducts = <Cart>[].obs;
  CartDbController _cartDbController = CartDbController();

  @override
  void onInit() {
    // TODO: implement onInit
    readItems();
    super.onInit();
  }

  Future<bool> createItem({required Cart cart}) async {
    int id = await _cartDbController.create(cart);
    if (id != 0) {
      cart.id = id;
      cartProducts.add(cart);
    }
    return id != 0;
  }

  Future<void> readItems() async {
    cartProducts.value = await _cartDbController.read();

  }

  Future<bool> updateItem({required int id}) async {
    bool status = await _cartDbController.delete(id);
    if (status) {
      int index = cartProducts.indexWhere((element) => element.id == id);
      if (index != -1) cartProducts.removeAt(index);
    }
    return status;
  }

  Future<bool> deleteItem({required int id}) async {
    bool status = await _cartDbController.delete(id);
    if (status) {
      cartProducts.removeWhere((element) => element.id == id);
    }
    return status;
  }

  Future<bool> cleanCart() async {
    bool status = await _cartDbController.cleanCart();
    if(status) cartProducts.clear();
    return status;
  }
}
