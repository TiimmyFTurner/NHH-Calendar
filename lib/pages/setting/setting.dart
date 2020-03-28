import 'package:flutter/material.dart';
import 'package:nhh_calendar/providers/providers.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildSettingBody(context),
    );
  }

  ListView _buildSettingBody(context) => ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          ListTile(
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
          Divider(height: 0),
          ListTile(
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
          Divider(height: 0),
          SizedBox(height: 24),
          Center(
            child: InkWell(
              child: Text(
                "WWW.NasleHipHop.Com",
                style: TextStyle(color: Colors.grey),
              ),
              onTap: _launchURL,
            ),
          ), 
          Center(
            child: Text(
              "\nNHH Calendar  0.5\nCopyright \u00a9 2020 NasleHipHop",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      );

  AppBar _buildAppBar(BuildContext context) => AppBar(
        title: Text('Settings'),
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      );

  _launchURL() async {
    const url = 'https://naslehiphop.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
