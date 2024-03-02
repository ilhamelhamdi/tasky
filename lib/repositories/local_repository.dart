abstract class LocalRepository<T> {
  Future<T> getById(String id);

  Future<List<T>> getAll();

  Future<T> create(T object);

  Future<T> update(String id, T newObject);

  Future<void> delete(String id);
}
