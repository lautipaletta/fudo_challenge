import 'package:dio/dio.dart';
import 'package:fudo_challenge/features/posts/data/data_sources/posts_data_source.dart';
import 'package:fudo_challenge/features/posts/data/model/create_post_dto.dart';
import 'package:fudo_challenge/features/posts/data/model/post_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'remote_posts_data_source.g.dart';

@RestApi()
abstract class RemotePostsDataSource implements PostsDataSource {
  factory RemotePostsDataSource(Dio dio) => _RemotePostsDataSource(dio);

  @GET('/posts')
  @override
  Future<List<PostDto>> getPosts({@Query('userId') int? userId});

  @POST('/posts')
  @override
  Future<PostDto> createPost({@Body() required CreatePostDto dto});
}
