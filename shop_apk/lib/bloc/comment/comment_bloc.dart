import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_apk/bloc/comment/comment_state.dart';
import 'package:shop_apk/data/repository/comment_repository.dart';

import 'comment_event.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final IcommentRepository repository;
  CommentBloc(this.repository) : super(CommentLoading()) {
    on<CommentInitEvent>((event, emit) async {
      final response = await repository.getComments(event.productId);
      emit(
        CommentResponse(response)
      );
    });
  }
}
