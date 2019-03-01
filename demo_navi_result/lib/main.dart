import 'package:flutter/material.dart';

class Product {
  final String productName;
  final String productID;
  Product(this.productName, this.productID);
}

void main() {
  runApp(MaterialApp(title: '页面跳转返回数据', home: FirstPage()));
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('demo'),
      ),
      body: Center(
        child: RouteButton(),
      ),
    );
  }
}

class RouteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        print('ssssss');
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             ProductDetail(product: Product('s', 's'))));

        _navigationTo(context);
      },
      child: Text('click'),
    );
  }
}

_navigationTo(BuildContext context) async {
  final result = await Navigator.push(
      //等待
      context,
      MaterialPageRoute(
        // builder: (context) => ProductDetail(product: Product('s', 's')))

        builder: (context) => ProductList(
            products: List.generate(20, (i) => Product('商品名称-$i', '商品ID-$i'))),
      ));

  print('$result');
  Scaffold.of(context).showSnackBar(SnackBar(content: Text('$result')));



}

class ProductList extends StatelessWidget {
  final List<Product> products;
  ProductList({Key key, @required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('productList'),
        ),
        body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(products[index].productName),
              onTap: () {
                Product pro = products[index];
                Navigator.pop(context, '${pro.productName},${pro.productID}');
              },
            );
          },
        ));
  }
}

class ProductDetail extends StatelessWidget {
  final Product product;
  ProductDetail({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('${product.productName}'),
      ),
      body: Center(
        child: Text('${product.productName}${product.productID}'),
      ),
    );
  }
}
