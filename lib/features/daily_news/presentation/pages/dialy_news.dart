import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/widgets/article_tile.dart';

class DialyNews extends StatelessWidget {
  const DialyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  _buildAppbar() {
    return AppBar(
      title: const Text(
        'Dialy News',
        style: TextStyle(color: Colors.black, fontSize: 25),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticleState>(
      builder: (_, state) {
        if (state is RemoteArticlesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }

        if (state is RemoteArticlesError) {
          return const Center(child: Icon(Icons.refresh));
        }

        if (state is RemoteArticlesDone) {
          return ListView.builder(
            itemBuilder: (ctx, idx) {
              return ArticleWidget(article: state.articles![idx]);
            },
            itemCount: state.articles!.length,
          );
        }

        return const SizedBox();
      },
    );
  }
}
