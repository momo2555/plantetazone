import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantetazone/view/messages/messagesPage.dart';
import 'package:plantetazone/view/newPost/newPost.dart';
import 'package:plantetazone/view/profile/profilePage.dart';
import 'package:plantetazone/view/search/searchPage.dart';

import 'home/homePage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  @override
  int _pageIndex = 2;
  late TabController _tabController;
  late List<Widget> _pages;
  late List<Widget> _pageName;
  @override
  void initState() {
   
    _tabController = TabController(length: 2, vsync: this);
    
    _pages = [
      HomePage(),
      SearchPage(),
      MessagesPage(),
      ProfilePage()
    ];
   
      super.initState();
      
  
  }

  Widget build(BuildContext context) {
    _pageName = [
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Image.asset('assets/logos/title_home.png',
                              fit: BoxFit.contain,
                              height: 58,
                          ),]
                  ),
                //Text("Explorer",   style: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.w300)), 
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Rechercher ..."
                  ),
                  
                ),
                Text("Ma messagerie", style: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.w300)), 
                Text("Mon Profil",     style: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.w300)),
          ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
                // Status bar color
                statusBarColor:Theme.of(context).backgroundColor
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          //centerTitle: true,
          title: _pageName[_pageIndex],
          titleSpacing: 20,
          bottom: _pageIndex == 2
              ? TabBar(
                  controller: _tabController,
                  indicatorColor: Theme.of(context).accentColor,
                  labelStyle: TextStyle(fontWeight: FontWeight.w400),
                  labelColor: Theme.of(context).primaryColorDark,
                  tabs: const <Widget>[
                    Tab(
                      text: "Messages",
                    ),
                    Tab(text : "Notifications"),
                    
                  ],
                )
              : null),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      //new post button
      floatingActionButton: FloatingActionButton(
        elevation: 0.2,
        //backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          Navigator.pushNamed(context, '/newPost');
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) => setState(() {
          _pageIndex = value;
        }),
        
        showSelectedLabels: true,
        showUnselectedLabels: true,
        fixedColor: Theme.of(context).accentColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Theme.of(context).primaryColor,
        //selectedItemColor: Theme.of(context).accentColor,
        backgroundColor: Theme.of(context).backgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explorer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline_rounded),
            label: 'Messagerie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profil',
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
