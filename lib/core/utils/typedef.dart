import 'package:bigsizeship_mobile/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultFutureVoid = ResultFuture<void>;
typedef DataMap = Map<String, dynamic>;
