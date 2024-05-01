import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: 380,
              padding: EdgeInsets.all(20),
              // Set to your preferred width
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/bg.png'), // Replace with your asset
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
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Text(
                              'Crushing & Influence',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                fontFamily: 'Helvetica'
                              ),
                            ),
                            Text(
                              'When the earth was flat and everyone wanted to win the game of the best and people and winning were all games with all the things you have.',
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
                                    child: Center(child: Text("Read", style: TextStyle(fontWeight: FontWeight.bold),)),
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
                            child: Image.asset(
                              'assets/books/book1.jpg', // Replace with your asset
                              width: 100, // Set to your preferred width
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border)),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
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
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      Icon(Icons.add_shopping_cart_rounded,size: 28,color: Colors.grey,),
                      SizedBox(width: 10,),
                      Text("Add to cart",style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        fontWeight:  FontWeight.w800,
                        color: Colors.black87
                      ),),
                      Spacer(),
                      Icon(Icons.navigate_next_rounded)
                    ],
                  )
            )),
            Positioned(
                top: 450,
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
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10,),
                        Icon(Icons.payment,size: 28,color: Colors.grey,),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15,),
                            Text("Buy now",style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 18,
                                fontWeight:  FontWeight.w800,
                                color: Colors.black87
                            ),),
                            Expanded(child:  Text(
                              'Instent delevry (PDF copy)',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.grey,
                                fontSize: 13,
                              ),),)

                          ],
                        ),
                        Spacer(),
                        Icon(Icons.attach_money_outlined,size: 20,color: Colors.grey[900],),
                        Text("45",style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                            fontWeight:  FontWeight.w800,
                            color: Colors.black87
                        ),),
                        SizedBox(width: 10,)
                      ],
                    ),
                )),
            Positioned(
              top: 550,
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
                        color: Colors.black
                    ),
                  ),
                ],
              ),),
            Positioned(
                top: 600,
                left: 40,
                child: Container(
                  height: 250,
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
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Column(
                      children: [
                        SizedBox(height: 18,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Container(
                              width:130,
                              child: Text(
                                'Crushing & Influence',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    fontFamily: 'Helvetica'
                                ),
                              ),
                            ),
                              SizedBox(width: 65,),
                            Container(
                              height: 150,
                              width: 90,
                              child: Image.asset(
                                'assets/books/book1.jpg', // Replace with your asset
                                width: 100, // Set to your preferred width
                              ),
                            ),
                          ],
                        ),
                    
                      ],
                    )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
