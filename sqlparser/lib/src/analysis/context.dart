part of 'analysis.dart';

class AnalysisContext {
  final List<AnalysisError> errors = [];
  final AstNode root;
  final String sql;
  final TypeResolver types = TypeResolver();

  AnalysisContext(this.root, this.sql);

  void reportError(AnalysisError error) {
    errors.add(error);
  }

  ResolveResult typeOf(Typeable t) {
    if (t is Column) {
      return types.resolveColumn(t);
    } else if (t is Variable) {
      return types.inferType(t);
    } else if (t is Expression) {
      return types.resolveExpression(t);
    }

    throw StateError('Unknown typeable $t');
  }
}