import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:kpw_admin_blog/services/post.dart';
import 'package:kpw_admin_blog/components/posts.dart';

@Component(
    selector: 'my-app', 
    styleUrls: const ['app_component.css'],
    directives: const [ROUTER_DIRECTIVES],
    providers: const [PostService, ROUTER_PROVIDERS],
    templateUrl: 'app_component.html')
@RouteConfig(const [
  const Route(
      path: '/dashboard',
      name: 'Dashboard',
      component: Dashboard,
      useAsDefault: true),
  const Route(
      path: '/detail/:id', 
      name: 'PostDetail', 
      component: PostDetailComponent),
  const Route(
      path: '/posts', 
      name: 'Posts', 
      component: PostsComponent)
])
class AppComponent {
    String title = 'Admin Blog Post';
}
