import 'package:flutter/material.dart';
import 'package:test_ambar/app/data/models/repositoy_model.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildBackGround() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 37, 62, 102),
            Color.fromARGB(255, 197, 202, 233),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );

Widget _actions(String link, Function share) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      IconButton(
        color: Colors.black54,
        tooltip: 'Abrir repositório',
        icon: Icon(Icons.open_in_new),
        onPressed: () async {
          await launch(link);
        },
      ),
      IconButton(
        color: Colors.black54,
        tooltip: 'Compartilhar repositório',
        icon: Icon(Icons.share),
        onPressed: () {
          share(link);
        },
      )
    ],
  );
}

Widget _avatar(String url) {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        fit: BoxFit.fill,
        image: NetworkImage(
          url,
        ),
      ),
    ),
    height: 85,
    width: 85,
  );
}

Widget _ownerName(String name) {
  return FittedBox(
    child: Text(
      name,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _repositoryName(String name) {
  return FittedBox(
    child: Text(
      name,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _descriptionName(String description) {
  return Text(
    description,
    style: TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.normal,
    ),
  );
}

Widget avatarName(RepositoryModel lista) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 16.0),
    alignment: FractionalOffset.centerLeft,
    child: Column(
      children: <Widget>[
        _avatar(lista.owner.avatarUrl),
        _ownerName(lista.owner.login),
      ],
    ),
  );
}

Widget _actionsRepository(RepositoryModel lista, Function share) {
  return Container(
    margin: EdgeInsets.only(left: 50),
    child: Column(
      children: [
        _actions(lista.htmlUrl, share),
        _repositoryName(lista.name),
        SizedBox(height: 15),
        lista.description == null
            ? Text('No description')
            : _descriptionName(lista.description)
      ],
    ),
  );
}

Widget card(RepositoryModel lista, Function share) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(left: 46.0),
    decoration: BoxDecoration(
      color: Colors.blueGrey[400],
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black12,
          blurRadius: 10.0,
          offset: const Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: _actionsRepository(lista, share),
    ),
  );
}
