import 'package:flutter/material.dart';
import '../constants.dart' show Constants,AppColors;

enum ActionItems{
  GROUP_CHAT,ADD_FRIEND,QR_SCAN,PAYMENT,HELP
}

class NavigationIconView{
  final BottomNavigationBarItem item;

  NavigationIconView({Key key,String title,IconData icon,IconData activeIcon}):
    
    item = BottomNavigationBarItem(
      icon: Icon(icon,color:Color(AppColors.TabIconNormal)),
      activeIcon: Icon(activeIcon,color:Color(AppColors.TabIconActive)),
      title: Text(title,style: TextStyle(
        fontSize: 14.0,
        color: Color(AppColors.TabIconNormal)
      ),),
      backgroundColor: Colors.white
    );


}

class HomeScreen extends StatefulWidget{
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  PageController _pageController;
  int _currentIndex = 0;
  List<NavigationIconView> _navigationViews;
  List<Widget> _pages;

  void initState(){
    super.initState();
    _navigationViews = [
      NavigationIconView(
        title:"微信",
        icon: IconData(
          0xe608,
          fontFamily:Constants.IconFontFamily,
        ),
        activeIcon: IconData(
          0xe603,
          fontFamily:Constants.IconFontFamily,
        ),
      ),
      NavigationIconView(
        title:"通讯录",
        icon: IconData(
          0xe600,
          fontFamily:Constants.IconFontFamily,
        ),
        activeIcon: IconData(
          0xe601,
          fontFamily:Constants.IconFontFamily,
        ),
      ),
      NavigationIconView(
        title:"发现",
        icon: IconData(
          0xe606,
          fontFamily:Constants.IconFontFamily,
        ),
        activeIcon: IconData(
          0xe6b3,
          fontFamily:Constants.IconFontFamily,
        ),
      ),
      NavigationIconView(
        title:"我",
        icon: IconData(
          0xe607,
          fontFamily:Constants.IconFontFamily,
        ),
        activeIcon: IconData(
          0xe630,
          fontFamily:Constants.IconFontFamily,
        ),
      ),
    ];
    _pageController = PageController(initialPage: _currentIndex);
    _pages = [
      Container(color: Colors.red,),
      Container(color: Colors.green,),
      Container(color: Colors.blue,),
      Container(color: Colors.brown,),
    ];
  }

  _buildPopupMenuItem(int iconName,String title){
    return Row(
      children: <Widget>[
        Icon(IconData(
            iconName,
            fontFamily:Constants.IconFontFamily,
          ),
          size: 22.0,
          color: const Color(AppColors.AppBarPopupMenuTextColor),
        ),
        Container(width: 12.0),
        Text(
          title,
          style: TextStyle(
            color: const Color(
              AppColors.AppBarPopupMenuTextColor
            ),
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context){
    final BottomNavigationBar botNavBar = BottomNavigationBar(
      fixedColor: const Color(AppColors.TabIconActive),
      items: _navigationViews.map((NavigationIconView view)=>view.item).toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index){
        setState(() {
          _currentIndex = index;       
          _pageController.animateToPage(_currentIndex,duration: Duration(milliseconds: 200),curve: Curves.easeInOut);   
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        title:Text("微信"),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon:Icon(
              IconData(
                0xe610,
                fontFamily: Constants.IconFontFamily,
              ),
              size: 22.0,
            ),
            onPressed: (){
              print("点击了搜索");
            },
          ),
          Container(width: 16.0),
          PopupMenuButton(
            itemBuilder: (BuildContext context){
              return <PopupMenuItem<ActionItems>>[
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe69e,"发起群聊"),
                  value: ActionItems.GROUP_CHAT,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe624,"添加朋友"),
                  value: ActionItems.ADD_FRIEND,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe6a2,"扫一扫"),
                  value: ActionItems.QR_SCAN,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe604,"收付款"),
                  value: ActionItems.PAYMENT,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe63d,"帮助与反馈"),
                  value: ActionItems.HELP,
                ),
              ];
            },
            icon: Icon(
              IconData(
                0xe609,
                fontFamily:Constants.IconFontFamily,
              ),
              size: 22.0,
            ),
            onSelected: (ActionItems selected){
              print("点击的是$selected");
            },
          ),
          Container(width: 16.0),
        ],
      ),
      body: PageView.builder(
        itemBuilder: (BuildContext context,int index){
          return _pages[index];
        },
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index){
          print("当前显示的是$index");
          setState(() {
            _currentIndex = index;            
          });
        },
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}