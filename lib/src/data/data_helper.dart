import 'package:req_livestream_helper/src/controller/app_controller.dart';

class DataHelper {
  static int getClientsSelledTotal(List<ClientOrder> clientsOrder) {
    return clientsOrder.where((cO) => cO.client.isNotEmpty).toList().length;
  }

  static double getProductsTotal(List<ClientOrder> clientsOrder) {
    return clientsOrder.fold(
      0.0,
      (t, clientOrder) =>
          t + clientOrder.products.fold(0.0, (t, product) => t + product.price),
    );
  }

  static int getProductsQtdTotal(List<ClientOrder> clientsOrder) {
    return clientsOrder.fold(
      0,
      (t, clientOrder) => t + clientOrder.products.length,
    );
  }
}
