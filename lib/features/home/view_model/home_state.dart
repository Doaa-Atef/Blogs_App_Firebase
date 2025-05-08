part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
class GetBlogsLoading extends HomeState {}
class GetBlogsSuccess extends HomeState {}
class GetBlogsFailure extends HomeState {
  final String error;
  GetBlogsFailure(this.error);
}


class DeleteBlogLoading extends HomeState {}
class DeleteBlogSuccess extends HomeState {}
class DeleteBlogFailure extends HomeState {
  final String error;
  DeleteBlogFailure(this.error);
}


