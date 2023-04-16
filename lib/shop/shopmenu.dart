import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class ShopMenu extends StatefulWidget {
  const ShopMenu( {Key? key, required this.menuindex}) : super(key: key);
  final int menuindex;

  @override
  State<ShopMenu> createState() => _ShopMenuState();
}

class _ShopMenuState extends State<ShopMenu> {
  bool isHome=false;
  bool isAddProduct=false;
  bool isOrder=false;
  final storage = FlutterSecureStorage();

  @override
  void initState(){
    super.initState();
    if(widget.menuindex==1){
      isHome=true;
    }
    else if(widget.menuindex==2){
      isAddProduct=true;

    }
    else if(widget.menuindex==3){
      isOrder=true;

    }


  }
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(

            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/signup2.png'))), child: null,
          ),
          Container(
            alignment: Alignment.center,
            child: Text("Build Your Online Shop",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20),),
          ),
          ListTile(
            leading: Icon(Icons.home,),
            title: listtileText("Home"),
            onTap: () => {
              Navigator.pushNamed(context, '/shopdashboard')
            },
            selected: isHome,
            selectedTileColor: Colors.black12,
            selectedColor: Colors.green[800],

          ),
          ListTile(
            leading: Icon(Icons.energy_savings_leaf_sharp,),
            title: listtileText("Add Products"),
            onTap: (){
             setState(() {
               isHome=false;
               isAddProduct=true;

             });
             Navigator.pushNamed(context, '/add-product');

            },

            selected:isAddProduct,
            selectedTileColor: Colors.black12,
            selectedColor: Colors.green[800],

          ),
          ListTile(
            leading: Icon(Icons.shopping_bag,),
            title: listtileText("orders"),
            onTap: () async {
              setState(() {
                isHome=false;
                isAddProduct=false;
                isOrder=true;

              });
              Navigator.pushNamed(context, '/viewordervendor');


            },

            selected:isOrder,
            selectedTileColor: Colors.black12,
            selectedColor: Colors.green[800],

          ),
          ListTile(
            leading: Icon(Icons.logout,),
            title: listtileText("Logout"),
            onTap: () async {

              await storage.delete(key: "token");
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);

            },


            selectedColor: Colors.green[800],

          ),


        ],
      ),

    );
  }
}
Widget listtileText(String txt){
  return Text(txt,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),);
}
