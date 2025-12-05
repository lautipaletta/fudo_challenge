import 'package:fudo_challenge/config/routes/routes.dart';

class AppRoutes {
  static final Route login = Route(name: 'login', path: '/login');
  static final Route posts = Route(name: 'posts', path: '/posts');
  static final Route createPost = Route(
    name: 'create-post',
    path: '/create-post',
  );
}
