import 'package:covid/ses.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(

      

      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.black,
        
        
      ),
      home: 
      
      new HomePage("COVID"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<User>> _getUsers() async {

    var data = await http.get("https://api.covid19india.org/data.json");
  
    var jsonData = json.decode(data.body);
  
    List<User> users = [];
    
    
   // print(jsonData);
    
    for(var u in jsonData["cases_time_series"]){
     

      User user = User(u["dailyconfirmed"], u["dailyconfirmed"], u["date"], u["totalconfirmed"], u["totalrecovered"]);
    
      users.add(user);
    
    }

  

    return users;

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold (

      
        



      appBar: new AppBar(
        title: new Text("DATE WISE DATA"),

        


      ),
      body: 
      
      
      
      Container(
          child: FutureBuilder(
            future: _getUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              
              if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: Text("Loading...")
                  )
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                    
                    shape: RoundedRectangleBorder(
                      
      borderRadius: BorderRadius.circular(15.0),
    ),
    
                child: new Container(
                  width: 200,
                  color: Colors.redAccent,
                  padding: EdgeInsets.all(5.0),
                  child: new Column(
                    children: <Widget>[
                      
                      new Text('Date: '+snapshot.data[index].date ,textAlign: TextAlign.left,textScaleFactor: 1.7,),
                      new Text('Daily Confirmed: '+snapshot.data[index].dailyconfirmed,textScaleFactor: 1.25),
                      new Text('Total Confirmed: '+snapshot.data[index].totalconfirmed,textScaleFactor: 1.25),
                      new Text('Total Recovered: '+snapshot.data[index].totalrecovered,textScaleFactor: 1.25),
                    ],
                  ),
                ),
              );
                  },
                );
              }
            },
          ),
        ),
        
      );
  }
}

class DetailPage extends StatelessWidget {

  final User user;

  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(user.date),
        )
    );
  }
}


class User {
  final String index;
  final String dailyconfirmed;
  final String date;
  final String totalconfirmed;
  final String totalrecovered;

  User(this.index, this.dailyconfirmed, this.date, this.totalconfirmed, this.totalrecovered);

}



class HomePage extends StatefulWidget {
  String username;
  HomePage(this.username);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context3) => Scaffold(
              appBar: AppBar(
                title: const Text('COVID19'),
                 
                backgroundColor: Colors.black,
              ),
              body: CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      title: Text('Sessions'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.mic),
                      title: Text('Speakers'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.school),
                      title: Text('Partners'),
                    ),
                  ],
                ),
                tabBuilder: (BuildContext context, int index) {
                  assert(index >= 0 && index <= 2);
                  switch (index) {
                    case 0:
                      return new MyHomePage();
                      break;
                    case 1:
                      return new MyHomePage2();
                      break;
                    case 2:
                      return new MyHomePage3();
                      break;
                  }
                  return null;
                },
              ),
              
            ),
      );
  
  }
}




class MyHomePage2 extends StatefulWidget {
  

  @override
  _MyHomePage2State createState() => new _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {

  Future<List<User2>> _getUsers() async {

    var data = await http.get("https://api.covid19india.org/data.json");
  
    var jsonData = json.decode(data.body);
  
    List<User2> users = [];
    
    
   // print(jsonData);
  
    for(var u in jsonData["statewise"]){
    

      User2 user = User2(u["confirmed"],u["confirmed"], u["deaths"], u["state"], u["recovered"],u["statecode"]);
      
      
      users.add(user);
    
    }

  

    return users;

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold (

      
        



      appBar: new AppBar(
        title: new Text("STATE WISE DATA"),

        


      ),
      body: 
      
      
      
      Container(
          child: FutureBuilder(
            future: _getUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              
              if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: Text("Loading...")
                  )
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                    
                    shape: RoundedRectangleBorder(
                      
      borderRadius: BorderRadius.circular(15.0),
    ),
    
                child: new Container(
                  width: 200,
                  color: Colors.redAccent,
                  padding: EdgeInsets.all(5.0),
                  child: new Column(
                    children: <Widget>[
                      
                      new Text('State: '+snapshot.data[index].state ,textAlign: TextAlign.left,textScaleFactor: 1.7,),
                      new Text('Total Confirmed: '+snapshot.data[index].confirmed,textScaleFactor: 1.25),
                      new Text('Total Recovered: '+snapshot.data[index].recovered,textScaleFactor: 1.25),
                      new Text('Total Deaths: '+snapshot.data[index].deaths,textScaleFactor: 1.25),
                    ],
                  ),
                ),
              );
                  },
                );
              }
            },
          ),
        ),
        
      );
  }
}




class User2 {
  final String index;
  final String confirmed;
  final String deaths;
  final String state;
  final String recovered;
  final String statecode;

  User2(this.index, this.confirmed, this.deaths, this.state, this.recovered,this.statecode);

}








class MyHomePage3 extends StatefulWidget {
  

  @override
  _MyHomePage3State createState() => new _MyHomePage3State();
}

class _MyHomePage3State extends State<MyHomePage3> {

  Future<List<User3>> _getUsers() async {

    var data = await http.get("http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=c36f881ca1de4228860e4893bc948b45");
  
    var jsonData = json.decode(data.body);
  
    List<User3> users = [];
    
    
   // print(jsonData);
  
    for(var u in jsonData["articles"]){
    
     
      if (u["urlToImage"]!=null){
      User3 user = User3(u["title"],u["title"], u["description"], u["url"], u["urlToImage"]);
      
      
      users.add(user);}
    
    }



    return users;

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold (

      
        



      appBar: new AppBar(
        title: new Text("TOP HEADLINES"),

        


      ),
      body: 
      
      
      
      Container(
          child: FutureBuilder(
            future: _getUsers(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              
              if(snapshot.data == null){
                return Container(
                  child: Center(
                    child: Text("Loading...")
                  )
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                    
                    shape: RoundedRectangleBorder(
                      
      borderRadius: BorderRadius.circular(15.0),
    ),
    
                child: new Container(
                  width: 100,
                  color: Colors.redAccent,
                  padding: EdgeInsets.all(5.0),
                  child: new Column(
                    children: <Widget>[
                      
                  //    new Image.network(snapshot.data[index].urli),
                    new Image.network(snapshot.data[index].urli,fit: BoxFit.fill,
  loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
  if (loadingProgress == null || snapshot.data[index].urli==null ) return child;
    return Center(
      child: CircularProgressIndicator(
      value: loadingProgress.expectedTotalBytes != null ? 
             loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
             : null,
      ),
    );
  },
),  
                      new Text('Title: '+snapshot.data[index].title ,textAlign: TextAlign.left,textScaleFactor: 1.3),
                      new SizedBox(height: 2.0,),
                      new Text('Description: '+snapshot.data[index].description,textScaleFactor: 1.3),
                      new RaisedButton(onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Sessions(snapshot.data[index].url)),
  );
},textColor: Colors.white, child: new Text("Show More!"),
                      ),
                  //    new Text('Total Recovered: '+snapshot.data[index].url,textScaleFactor: 1.25),
                    //  new Text('Total Deaths: '+snapshot.data[index].urli,textScaleFactor: 1.25),
                    ],
                  ),
                ),
              );
                  },
                );
              }
            },
          ),
        ),
        
      );
  }
}




class User3 {
  final String index;
  final String title;
  final String description;
  final String url;
  final String urli;
  

  User3(this.index, this.title, this.description, this.url, this.urli);

}

class Sessions extends StatefulWidget {
  String url;
  Sessions(this.url);
  
  @override
  _SessionsState createState() => _SessionsState(url);
}

class _SessionsState extends State<Sessions> {
  String url;
  var isLoading=true;
  _SessionsState(this.url);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("News"),
        ),
        body: Column(
          children: [
            Expanded(
                child: WebView(
                    key: UniqueKey(),
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: url,
                    onPageFinished: (_) {
              setState(() {
                isLoading = false;
              });
            },
            ),
            
            )
          
          ],
        ));
  }
}