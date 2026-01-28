# Contributing to Chairific

First off, thank you for considering contributing to Chairific! It's people like you that make Chairific such a great tool for bias-free job matching.

## Code of Conduct

By participating in this project, you are expected to uphold our Code of Conduct of being respectful and inclusive to all contributors.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When you create a bug report, include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples**
- **Describe the behavior you observed and what you expected**
- **Include screenshots if possible**
- **Note your environment**: iOS version, device model, Xcode version

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, include:

- **Use a clear and descriptive title**
- **Provide a detailed description of the suggested enhancement**
- **Explain why this enhancement would be useful**
- **List any examples of similar functionality in other apps**

### Pull Requests

1. **Fork the repository** and create your branch from `main`
2. **Follow the coding style** of the existing codebase
3. **Write clear commit messages** using conventional commits format
4. **Update documentation** if you're changing functionality
5. **Test your changes** thoroughly on iOS Simulator and physical device if possible
6. **Submit a pull request** with a clear description of changes

## Development Setup

1. Clone your fork:
   ```bash
   git clone https://github.com/YOUR-USERNAME/chairific.git
   cd chairific
   ```

2. Open in Xcode:
   ```bash
   open chairific/chairific.xcodeproj
   ```

3. Build and run the project (Cmd+R)

## Coding Conventions

### Swift Style Guide

- Follow [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- Use meaningful variable and function names
- Keep functions small and focused
- Add comments for complex logic
- Use SwiftUI best practices

### File Organization

- Group related files in appropriate directories
- Views go in `Views/` subdirectories by feature
- Controllers/ViewModels go in `Controllers/`
- Keep assets organized in `Assets.xcassets`

### Naming Conventions

- **Views**: Use descriptive names ending with "View" (e.g., `ProfileView`, `SwipingView`)
- **ViewModels**: Name them after the view they support with "ViewModel" suffix
- **Functions**: Use camelCase with action verbs (e.g., `fetchUserProfile()`)
- **Variables**: Use camelCase for variables and constants

## Commit Message Guidelines

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>: <description>

[optional body]

[optional footer]
```

### Types

- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that don't affect code meaning (formatting, etc.)
- **refactor**: Code change that neither fixes a bug nor adds a feature
- **perf**: Performance improvements
- **test**: Adding or correcting tests
- **chore**: Changes to build process or auxiliary tools

### Examples

```bash
feat: add employer profile editing functionality
fix: resolve crash when loading empty profile
docs: update installation instructions in README
refactor: simplify matching algorithm logic
```

## Testing Guidelines

- Test your changes on multiple iOS versions if possible
- Test on both iPhone and iPad simulators
- Verify that existing functionality still works
- Test edge cases (empty data, network failures, etc.)

## Documentation

- Update README.md if you change functionality
- Add inline comments for complex logic
- Update architecture docs if you change system design
- Keep code self-documenting when possible

## Questions?

Feel free to:
- Open an issue with your question
- Reach out to the maintainers
- Check existing issues and pull requests

## Recognition

Contributors will be recognized in the project. Thank you for your contributions!

---

**Happy Contributing!** 🪑
