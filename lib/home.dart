import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_database/database.dart';
import 'package:crud_database/product.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController subnamecontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();

  Stream? ProductStream;

  getontheload() async {
    ProductStream = await DatabaseMethods().getProductDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allProductDetails() {
    return StreamBuilder(
      stream: ProductStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Name: " + ds["Name"],
                                    style: TextStyle(
                                        color: Colors.amber,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    namecontroller.text = ds["Name"];
                                    subnamecontroller.text = ds["subName"];
                                    pricecontroller.text = ds["price"];
                                    EditTheProductDetails(ds["Id"]);
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await DatabaseMethods()
                                        .DeleteProductDetails(ds["Id"]);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            Text("price: " + ds["price"],
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                            Text("subName: " + ds["subName"],
                                style: TextStyle(
                                    color: Colors.amber,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => product()));
          },
          child: Icon(Icons.add)),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CRUD",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Column(
          children: [
            Expanded(child: allProductDetails()),
          ],
        ),
      ),
    );
  }

  Future EditTheProductDetails(String id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
              width: 300,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.cancel),
                        ),
                        SizedBox(
                          width: 60.0,
                        ),
                        Text(
                          "Edit",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Details",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text("Name",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: namecontroller,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "subName",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: subnamecontroller,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "price",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        controller: pricecontroller,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic> updateInfo = {
                            "Name": namecontroller.text,
                            "subName": subnamecontroller.text,
                            "Id": id,
                            "price": pricecontroller.text,
                          };
                          await DatabaseMethods()
                              .UpdateProductDetails(id, updateInfo)
                              .then((value) {
                            Navigator.pop(context);
                          });
                        },
                        child: Text("Update"))
                  ]),
            ),
          ));
}
