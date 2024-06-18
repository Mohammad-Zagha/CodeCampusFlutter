import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kotlinproj/classes/UserService.dart';
import 'package:kotlinproj/controllers/TokenService.dart';
import 'dart:convert';
import '../CustomWidgets/base64Image.dart'; // Ensure you have this import

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<dynamic> products = [];
  double totalPrice = 0.0;
  bool cartNotFound = false;
  final TokenService _tokenService = TokenService();
  final UserService userService = Get.find();
  @override
  void initState() {
    super.initState();
    fetchCart();
  }

  Future<void> fetchCart() async {
    String? token = await _tokenService.getToken();
    var url = Uri.http('192.168.1.109:3000', '/api/v1/User/viewCart');
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "token": "$token"
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['message'] == "Cart not found.") {
        setState(() {
          cartNotFound = true;
        });
      } else {
        setState(() {
          products = data['products'];
          totalPrice = data['totalPrice'].toDouble();
        });
      }
    } else if (response.statusCode == 404) {
      final data = jsonDecode(response.body);
      if (data['message'] == "Cart not found.") {
        setState(() {
          cartNotFound = true;
        });
      }
    }
  }

  Future<void> removeFromCart(String productId) async {
    String? token = await _tokenService.getToken();
    var url = Uri.http('192.168.1.109:3000', '/api/v1/User/removeFromCart');
    var body = jsonEncode({
      'productId': productId,
    });

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "token": "$token"
      },
      body: body,
    );

    if (response.statusCode == 200) {
      await fetchCart();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item removed from cart successfully'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to remove item from cart'),
        ),
      );
    }
  }

  Future<void> checkoutCart(int ammount) async {
    await userService.makeBookPayment(context, ammount);

  }

  void updateQuantity(int index, int quantity) {
    setState(() {
      products[index]['quantity'] = quantity;
      calculateTotal();
    });
  }

  void calculateTotal() {
    double total = 0.0;
    for (var product in products) {
      total += product['product']['price'] * product['quantity'];
    }
    setState(() {
      totalPrice = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: cartNotFound
          ? Center(child: Text('Your cart is empty.'))
          : products.isEmpty
          ? Center(child: Text('Your cart is empty.'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              padding: EdgeInsets.all(8.0),
              itemBuilder: (context, index) {
                final product = products[index]['product'];
                final quantity = products[index]['quantity'];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  shadowColor: Colors.grey.withOpacity(0.2),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.memory(
                            base64Decode(product['image']),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Price: \$${product['price']}',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Quantity: $quantity'),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove, color: Colors.grey),
                                        onPressed: () {
                                          if (quantity > 1) {
                                            updateQuantity(index, quantity - 1);
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add, color: Colors.grey),
                                        onPressed: () {
                                          updateQuantity(index, quantity + 1);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () async {
                                          await removeFromCart(product['id']);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await checkoutCart(totalPrice.toInt());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
