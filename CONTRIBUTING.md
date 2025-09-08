# Contributing 🤝

Thank you for your interest in contributing to this project! Your help makes it better for everyone.

## Code of Conduct 📝

By participating, you agree to abide by our [Contributor Code of Conduct](CODE_OF_CONDUCT.md).

## Getting Started

### Build the extractor

To build the extractor, use the following command:

```sh
./scripts/create-extractor-pack.sh
```

This will create the extractor pack in the `./extractor-pack` directory.

### Installing Dependencies

To install the dependencies of the queries, run the following command:

```sh
codeql pack install ./ql/lib
```

This will install the necessary dependencies for the library queries.
Alternatively, you can install them using VSCode's CodeQL extension.

### Compiling the Library

To compile the library queries, run:

```sh
codeql pack create ./ql/lib
```

You can also install these packs into the CodeQL home directory using:

```sh
codeql pack install --output=$HOME/.codeql/packages ./ql/lib
```

This will allow your to use the library on your local machine with CodeQL CLI.

### Run Tests

To run all tests:

```sh
./scripts/run-tests.sh
```

Or use VSCode's test runner for supported tests.

## Submitting a Pull Request

1. Fork and clone the repository
2. Create a new branch: `git checkout -b my-feature`
3. Make your changes and add tests if needed
4. Ensure all tests pass
5. Push your branch and open a pull request

### Tips for a Successful PR

- Keep changes focused and minimal
- Write clear commit messages
- Add or update tests as needed

## Reporting Issues & Discussions

- Report bugs or request features via [GitHub Issues](https://github.com/advanced-security/codeql-extractor-iac/issues)
- Use [GitHub Discussions](https://github.com/advanced-security/codeql-extractor-iac/discussions) for questions and ideas

## License 📄

Contributions are released under the [MIT License](LICENSE.md).

## Resources

- [How to Contribute to Open Source](https://opensource.guide/how-to-contribute/)
- [Using Pull Requests](https://help.github.com/articles/about-pull-requests/)
- [GitHub Help](https://help.github.com)

---

If you have any questions, open an issue or start a discussion. Thank you for helping improve this project! 🚀
