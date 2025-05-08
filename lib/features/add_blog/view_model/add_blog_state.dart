part of 'add_blog_cubit.dart';

@immutable
sealed class AddBlogState {}

final class AddBlogInitial extends AddBlogState {}
final class AddBlogLoading extends AddBlogState {}
final class AddBlogSuccess extends AddBlogState {}
final class AddBlogError extends AddBlogState {

  final String message;
  AddBlogError(this.message);
}
