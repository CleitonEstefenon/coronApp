import 'dart:convert';
import 'package:coronapp/models/news.dart';
import 'package:coronapp/utils/date_utils.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:coronapp/models/user.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final User user;
  static final from = DateUtils.dateToString(DateTime.now());
  static final to = DateUtils.dateToString(DateTime.now());
  String newsUrl =
      'http://newsapi.org/v2/everything?q=coronavirus&language=pt&from=$from&to=$to&apiKey=96151502a3d2498399c93fcca45593c4';
      
  HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indexTab = 0;

  var newsData;
  List articles;
  List<News> news;
  var refreshNews = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Future<String> getData() async {
    refreshNews.currentState.show();

    var response = await http.get(
      Uri.encodeFull(widget.newsUrl),
      headers: {"Accept": "application/json"},
    );

    this.setState(() {
      newsData = jsonDecode(response.body);
      articles = newsData["articles"] as List;
      news = articles.map<News>((json) => News.fromJson(json)).toList();
    });

    return "OK";
  }

  Widget _getBody() {
    switch (_indexTab) {
      case 0:
        return RefreshIndicator(
          key: refreshNews,
          child: ListView.builder(
              itemCount: news == null ? 0 : news.length,
              itemBuilder: (BuildContext context, int index) {
                //return NewsItem(news[index]);
                News noticia = news[index];
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        leading: CircleAvatar(
                          child: Image.network(noticia.imageUrl),
                          backgroundColor: Colors.transparent,
                          maxRadius: 32,
                        ),
                        title: Text(
                          "Título: ${noticia.title}(${noticia.author})",
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Data da publicação: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(noticia.publishedAt))}",
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              "Conteúdo: ${noticia.content}",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: Text(
                              "Fonte: ${noticia.source.name}",
                              textAlign: TextAlign.start,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                );
              }),
          onRefresh: getData,
        );
        break;
      case 1:
        return Container(
          height: 200,
          color: Theme.of(context).accentColor,
        );
        break;
      case 2:
        return Container(
          height: 200,
          color: Colors.green,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notícias do dia"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                radius: 30,
                backgroundImage: MemoryImage(base64.decode(widget.user.photo)),
              ),
              accountName: Text(widget.user.name.toUpperCase()),
              accountEmail: Text(widget.user.email),
            ),
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text('Item de menu 1'),
              subtitle: Text('Subtítulo 1'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                debugPrint('Clicou no menu 1');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Item de menu 1'),
              subtitle: Text('Subtítulo 1'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                debugPrint('Clicou no menu 2');
              },
            ),
          ],
        ),
      ),
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _indexTab,
        onTap: (int idx) => setState(() {
          _indexTab = idx;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.new_releases,
              color: Colors.white,
            ),
            title: Text(
              'Diagnóstico',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.accessibility,
              color: Colors.white,
            ),
            title: Text(
              'Diagnóstico',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.new_releases,
              color: Colors.white,
            ),
            title: Text(
              'Diagnóstico',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
