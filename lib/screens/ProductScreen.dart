import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:kotlinproj/classes/Product.dart';
import 'package:kotlinproj/classes/UserService.dart';
 // Make sure to import your service
import 'package:http/http.dart' as http;
import 'package:kotlinproj/controllers/TokenService.dart';
class ProductScreen extends StatefulWidget {
  final Product product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TokenService _tokenService = TokenService();

  Future<void> addToCart(Product product) async {
    String? token = await _tokenService.getToken();
    try {
      var response = await http.post(
        Uri.http('192.168.1.109:3000', '/api/v1/User/addToCart'),
        headers: {
          "Content-Type": "application/json",
          "token": "$token",
        },
        body: jsonEncode({
          'productId': product.id,
          'quantity': 1,
        }),
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, show a success message
        print('Product added to cart successfully');
      } else {
        // If the server returns an error response, throw an exception.
        throw Exception('Failed to add product to cart');
      }
    } catch (e) {
      print('Failed to add product to cart: $e');
      // Handle error gracefully in your app, e.g., show a snackbar
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserService userService = Get.find();
    final List<Product> otherProducts = userService.productsArray
        .where((p) => p.id != widget.product.id)
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: 380,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/bg.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              widget.product.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                fontFamily: 'Helvetica',
                              ),
                            ),
                            Text(
                              widget.product.description,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 50,
                                    width: 150,
                                    margin: EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Read",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                        children: [
                          Container(
                            height: 200,
                            width: 130,
                            child: Image(
                              image: MemoryImage(base64Decode(widget.product.image)),
                              width: 100,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.favorite_border),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(3, 7),
                                      blurRadius: 20,
                                      color: Color(0xFD3D3D3).withOpacity(.5),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 15,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "4.7",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 350,
              left: 40,
              child: Container(
                height: 80,
                width: 330,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () async{
                    await addToCart(widget.product);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10),
                      Icon(
                        Icons.add_shopping_cart_rounded,
                        size: 28,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Add to cart",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        "\$${widget.product.price.toString()}",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.navigate_next_rounded),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              top: 480,
              left: 45,
              child: Row(
                children: [
                  Text(
                    'You may also ',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 28,
                      fontFamily: 'Roboto-Mono',
                    ),
                  ),
                  Text(
                    'Like... ',
                    style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 28,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 500,
              left: 40,
              child: Container(
                height: 350,
                width: 330,
                child: ListView.builder(
                  itemCount: otherProducts.length,
                  itemBuilder: (context, index) {
                    final otherProduct = otherProducts[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 20,),
                          Container(
                            height: 150,
                            width: 90,
                            child: Image(
                              image: MemoryImage(base64Decode(otherProduct.image)),
                              width: 100,
                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                otherProduct.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'Helvetica',
                                ),
                              ),


                              SizedBox(height: 10),
                              Text(
                                "\$${otherProduct.price}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
