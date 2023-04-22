import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomerMenu extends StatefulWidget {
  const CustomerMenu({Key? key}) : super(key: key);

  @override
  State<CustomerMenu> createState() => _CustomerMenuState();
}

class _CustomerMenuState extends State<CustomerMenu> {
  final storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(

            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/signup2.png'))), child: null,
          ),
          // Container(
          //   alignment: Alignment.center,
          //   child: Text("Build Your Online Shop",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 20),),
          // ),
          ListTile(
            leading: Icon(Icons.home,),
            title: listtileText("Home"),
            onTap: () => {
              Navigator.pushNamed(context, '/customerdashboard')
            },
            //selected: isHome,
            selectedTileColor: Colors.black12,
            selectedColor: Colors.green[800],

          ),
          ListTile(
            leading: Icon(Icons.shopping_cart,),
            title: listtileText("Orders"),
            onTap: () => {
              Navigator.pushNamed(context, '/order')
            },
            //selected: isHome,
            selectedTileColor: Colors.black12,
            selectedColor: Colors.green[800],

          ),
          ListTile(
            leading: Icon(Icons.question_mark,),
            title: listtileText("My Questions"),
            onTap: () => {
              Navigator.pushNamed(context, '/viewquestions')
            },
            //selected: isHome,
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

  Widget listtileText(String txt){
    return Text(txt,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),);
  }
}
