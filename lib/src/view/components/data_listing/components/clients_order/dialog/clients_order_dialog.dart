import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:req_livestream_helper/src/controller/app_controller.dart';
import 'package:req_livestream_helper/src/data/data_helper.dart';
import 'package:req_livestream_helper/src/view/components/base_components/base_coming_up_animation_wrap.dart';
import 'package:req_livestream_helper/src/view/components/base_components/base_rounded_border_wrap.dart';
import 'package:req_livestream_helper/src/view/components/base_components/base_scroll_view_list.dart';
import 'package:req_livestream_helper/src/view/components/base_components/base_text.dart';
import 'package:req_livestream_helper/src/view/components/data_listing/components/clients_order_list_listing.dart';
import 'package:req_livestream_helper/src/view/theme.dart';

// ignore: must_be_immutable
class ClientsOrderDialog extends StatelessWidget {
  List<ClientOrder> clientsOrder;
  ClientsOrderDialog({super.key, required this.clientsOrder});
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(40),
      child: ComingUpAnimation(
        child: RoundedBorderWrap(
          backgroundColor: AppTheme.primaryBackgroundColor,
          borderColor: AppTheme.primaryBorderColor,
          padding: 10,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              RoundedBorderWrap(
                backgroundColor: AppTheme.primaryBackgroundColor,
                borderColor: AppTheme.primaryBorderColor,
                padding: 10,
                child: ClientsOrderInfo(clientsOrder),
              ),
              RoundedBorderWrap(
                backgroundColor: AppTheme.primaryBackgroundColor,
                borderColor: AppTheme.primaryBorderColor,
                padding: 10,
                child: BaseScrollViewList(
                  cardWidget: ({item}) => ClientOrderCard(cOrder: item),
                  data:
                      clientsOrder.where((cO) => cO.client.isNotEmpty).toList(),
                  height: h >= 700 ? h * 0.51 : h * 0.21,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClientOrderCard extends StatefulWidget {
  final ClientOrder cOrder;
  const ClientOrderCard({super.key, required this.cOrder});

  @override
  State<ClientOrderCard> createState() => _ClientOrderCardState();
}

class _ClientOrderCardState extends State<ClientOrderCard> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return RoundedBorderWrap.base(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  print('print');
                  setState(() {
                    show = !show;
                  });
                },
                child: RoundedBorderWrap.base(
                  child: Icon(
                    show ? Icons.expand_less : Icons.expand_more,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Text(widget.cOrder.client),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BaseText(widget.cOrder.products.length.toString()),
                    SizedBox(width: 20),
                    BaseText(
                      NumberFormat.currency(
                        locale: 'pt_BR',
                        symbol: 'R\$',
                      ).format(
                        DataHelper.getProductsTotalPerClient(
                          widget.cOrder.products,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (show)
            RoundedBorderWrap.base(
              child: BaseScrollViewList(
                height: MediaQuery.of(context).size.height * 0.15,
                data: widget.cOrder.products,
                cardWidget: ({item}) => ProductCard(item),
              ),
            ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  Product product;
  ProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedBorderWrap.base(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BaseText('#${product.cod} - ${product.dsc}'),
          Row(
            children: [
              BaseText(product.prodSize),
              SizedBox(width: 10),
              BaseText(
                NumberFormat.currency(
                  locale: 'pt_BR',
                  symbol: 'R\$',
                ).format(product.price),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ClientsOrderInfo extends StatelessWidget {
  List<ClientOrder> clientsOrder;

  ClientsOrderInfo(this.clientsOrder, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseText('Informações da live'.toUpperCase()),
        SingleClientsOrderInfo(
          label: 'Numero de clientes na live (compra)',
          value: DataHelper.getClientsSelledTotal(clientsOrder).toString(),
        ),
        SingleClientsOrderInfo(
          label: 'Quantidade de produtos vendidos',
          value: DataHelper.getProductsQtdTotal(clientsOrder).toString(),
        ),
        // SingleClientsOrderInfo(label: 'Produtos disponiveis', value: 'TO-DO'),
        // SingleClientsOrderInfo(label: 'Produtos indisponiveis', value: 'TO-DO'),
        SingleClientsOrderInfo(
          label: 'Valor vendido em produtos',
          value: NumberFormat.currency(
            locale: 'pt_BR',
            symbol: 'R\$',
          ).format(DataHelper.getProductsTotal(clientsOrder)),
        ),
        RoundedBorderWrap.base(
          child: Column(
            children: [
              BaseText('Indicadores'),

              SingleClientsOrderInfo(
                label: 'Produtos/Clientes (media)',
                value: 'TO-DO',
              ),

              SingleClientsOrderInfo(
                label: 'Peca de roupa (produto) preferido(a)',
                value: 'TO-DO',
              ),

              SingleClientsOrderInfo(
                label: 'Tamanho preferido',
                value: 'TO-DO',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SingleClientsOrderInfo extends StatelessWidget {
  String label;
  dynamic value;
  SingleClientsOrderInfo({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return RoundedBorderWrap.base(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), BaseText(value)],
      ),
    );
  }
}
