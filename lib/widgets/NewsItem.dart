import 'package:coronapp/models/news.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsItem extends StatelessWidget {
  final News news;

  NewsItem(this.news);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                child: Image.network(
                  news.imageUrl,
                  height: 100,
                  width: 100,
                ),
                margin: EdgeInsets.all(5),
              ),
              Container(
                width: 110,
                margin: EdgeInsets.all(5),
                child: Text(
                  "Fonte: ${news.source.name}",
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
          Container(
            height: 120,
            width: 270,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  width: double.infinity,
                  child: Text(
                    "Título: ${news.title}(${news.author})",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  width: double.infinity,
                  child: Text(
                    "Data da publicação: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(news.publishedAt))}",
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  width: double.infinity,
                  child: Text(
                    "Conteúdo: ${news.content}",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
