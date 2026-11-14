// TODO: Put public facing types in this file.

/// Checks if you are awesome. Spoiler: you are.
class CommandRunner{
  Future<void> run(List<String> input) async {
    print('Output for input: $input');
  }
}
