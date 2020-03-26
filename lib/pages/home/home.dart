import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nhh_calendar/Pages/eventDetail/eventDetail.dart';
import 'package:nhh_calendar/providers/providers.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:line_icons/line_icons.dart';

import 'package:nhh_calendar/pages/setting/setting.dart';

class HomePage extends StatefulWidget {
  final Map<DateTime, List> events;
  HomePage(this.events);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Map<DateTime, List> _events;

  List _selectedEvents;

  AnimationController _animationController, _eventAnimationController;

  Animation<Offset> _eventAnimation;

  CalendarController _calendarController;

  DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    _events = widget.events;
    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animationController.forward();
    _eventAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _eventAnimation = Tween(begin: Offset(0, -1.5), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _eventAnimationController,
          curve: Curves.fastLinearToSlowEaseIn),
    );
    _eventAnimationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    _eventAnimationController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) async {
    await _eventAnimationController.reverse();
    setState(() {
      _selectedEvents = events;
      _selectedDay = day;
    });
    await _eventAnimationController.forward();
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('NHH Calendar'),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(LineIcons.gear),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SettingPage()),
          ),
        )
      ],
    );
  }

  String formatter(Date d) {
    final f = d.formatter;
    return "  ${f.wN} ${f.d} ${f.mN} ${f.yyyy}";
  }

  TableCalendar _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle(color: Colors.white.withOpacity(.6)),
        weekdayStyle: TextStyle(color: Colors.white),
      ),
      calendarStyle: CalendarStyle(
        holidayStyle: TextStyle(color: Colors.white.withOpacity(.6)),
        weekendStyle: TextStyle(color: Colors.white.withOpacity(.6)),
        todayStyle: TextStyle(
          color: Colors.deepOrange,
          fontSize: 18,
        ),
        weekdayStyle: TextStyle(color: Colors.white),
        selectedColor: Theme.of(context).accentColor,
        todayColor: Colors.white.withOpacity(.6),
        markersColor: Colors.blue[100].withOpacity(.6),
        outsideDaysVisible: false,
        markersPositionBottom: 0.1,
      ),
      headerStyle: HeaderStyle(
        rightChevronIcon: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 18,
        ),
        leftChevronIcon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 18,
        ),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
    );
  }

  Widget _buildEventList() {
    return Expanded(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: _selectedEvents
            .map(
              (event) => Hero(
                transitionOnUserGestures: true,
                tag: 'Event${event['name']}',
                child: FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _eventAnimationController,
                    curve: Curves.easeIn,
                  ),
                  child: SlideTransition(
                    position: _eventAnimation,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 8,
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child: ListTile(
                        leading: Icon(Icons.cake),
                        title: Text(event['name']),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => EventDetail()),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildJalaliDate() {
    String date = formatter(Gregorian.fromDateTime(_selectedDay).toJalali());
    Widget jalali = FadeTransition(
      opacity: CurvedAnimation(
          parent: _eventAnimationController, curve: Curves.ease),
      child: Chip(
        label: Text(
          date,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(.8),
        elevation: 4,
      ),
    );

    return Provider.of<Settings>(context).showJalaliDate ? jalali : Container();
  }

  Widget _buildFloatingActionButton() => SizedBox(
        width: 70,
        height: 40,
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Text('Today'),
          onPressed: () {
            _calendarController.setSelectedDay(
              DateTime.now(),
              runCallback: true,
            );
          },
        ),
      );

  Widget _buildHomeBody() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _buildTableCalendar(),
        _buildJalaliDate(),
        _buildEventList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(),
      backgroundColor: Theme.of(context).primaryColor,
      appBar: _buildAppBar(),
      body: _buildHomeBody(),
    );
  }
}
