/* import 'package:bicycle/pages/Cycle.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  Animation animation;
  AnimationController controller;
  List<BoxShadow> shadowList = [
    BoxShadow(
      color: Colors.grey[300],
      blurRadius: 5,
      offset: Offset(0, 1),
    ),
  ];
  List<Cycle> cycle;
  TextStyle textStyle = TextStyle(
    fontSize: 20,
  );
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    cycle = Cycle.getUsers();
    controller=AnimationController(vsync: this,duration: Duration(seconds: 2));
    animation=Tween<double>(begin: 0,end: 1.0).animate(controller);
    controller.addListener(() { 
      setState(() {
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      drawer: Drawer(),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: shadowList,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                        icon: Icon(Icons.menu, color: Color(0xFF333945)),
                        onPressed: () {
                          setState(() {
                            key.currentState.openDrawer();
                          });
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.title, style: textStyle),
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: shadowList,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                        icon:
                            Icon(Icons.shopping_cart, color: Color(0xFF333945)),
                        onPressed: () {
                          setState(() {});
                        }),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cycle.length-1,
              itemBuilder: (context,index){
                return buildListItem(cycle[index].heroTag, cycle[index].title, cycle[index].imgPath, cycle[index].price);
              }),
          ),
           SizedBox(height: 10),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  child: CircularProgressIndicator(
                    value: animation.value,
                    
                  ),
                ),
              ),
              CircleAvatar(
                maxRadius: 32,
                backgroundColor: Color(0xFF333945),
                child: Text("${(animation.value*100).floor()}%",style: TextStyle(color:Colors.white)),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          
            controller..reset()..forward();
         
        }),
    );
  }
  Widget buildListItem(int heroTag,String title,String imgPath,String price)
  {
    return InkWell(
      onTap: (){},
        child: Card(
        color: Colors.amber,
        child: Container(
          width: 200,
          height:200,
          child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Hero(
                    tag: cycle[heroTag].heroTag,
                    child: Container(
                      width:75,
                      height:75,
                      decoration: BoxDecoration(
                        shape:BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image: NetworkImage('${cycle[heroTag].imgPath}'),
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                  ),
                  Text('${cycle[heroTag].title}',style: textStyle),
                  Text('\$ ${cycle[heroTag].price}',style: textStyle),
                  SizedBox(height:10),
                ],
              )),
        ),
      ),
    );
  }
}
 */