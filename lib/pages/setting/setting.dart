import 'package:flutter/material.dart';
import 'package:nhh_calendar/providers/providers.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildSettingBody(context),
    );
  }

  ListView _buildSettingBody(context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Card(
          child: ListTile(
            leading: Icon(Icons.brightness_4),
            title: Text('Dark Mode'),
            trailing: Switch(
              activeColor: Theme.of(context).accentColor,
              value: Provider.of<Settings>(context).darkMode,
              onChanged: (value) =>
                  Provider.of<Settings>(context, listen: false).switchDarkMode =
                      value,
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Jalali Date'),
            trailing: Switch(
              activeColor: Theme.of(context).accentColor,
              value: Provider.of<Settings>(context).showJalaliDate,
              onChanged: (value) =>
                  Provider.of<Settings>(context, listen: false).showJalaliDate =
                      value,
            ),
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Settings'),
      leading: IconButton(
        color: Colors.white,
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
    );
  }
}
