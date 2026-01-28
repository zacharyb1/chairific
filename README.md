<div align="center">

# 🪑 Chairific

### *Find Your Perfect Seat - Bias-Free Job Matching*

**An iOS app that revolutionizes hiring by removing bias and focusing on skills, culture, and values.**

[![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-15.0+-blue.svg)](https://www.apple.com/ios/)
[![Firebase](https://img.shields.io/badge/Firebase-Enabled-yellow.svg)](https://firebase.google.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-3.0+-purple.svg)](https://developer.apple.com/xcode/swiftui/)

[🎥 Live Demo](#) • [📸 Screenshots](#screenshots) • [📖 Documentation](docs/)

</div>

---

## 🎯 What is Chairific?

**Chairific is a bias-free job matching platform that keeps identities hidden until the perfect match is made.**

Instead of judging candidates by resumes and photos, Chairific focuses on what truly matters: **skills**, **culture fit**, and **shared values**. Both employers and job seekers remain anonymous until they mutually agree they're a match.

> **The Problem**: Traditional hiring is plagued by unconscious bias and superficial judgments.  
> **The Solution**: Chairific removes prejudice by hiding identities and letting skills and culture drive the match.

---

## ✨ Key Features

### 🎭 **Anonymous, Bias-Free Profiles**
- Employers and employees create anonymous profiles
- No names, photos, or identifying information until reveal
- Focus purely on skills, values, and cultural fit

### 🎯 **Smart Matching Algorithm**
- **Skill-Based**: Match 3 required skills for each position with employee's top 5 skills
- **Culture-Driven**: Both parties answer 10+ targeted questionnaire questions
- **Dual Scoring**: Algorithm combines skill alignment + cultural compatibility

### 🤝 **Reveal and Connect**
- Matches are made based on compatibility scores
- Both parties must agree to reveal identities
- Only then can interview process begin

### 🪑 **Chair-Themed Experience**
- Fun, engaging UI with chair metaphors ("Find your throne", "Take your seat")
- Makes job hunting feel like finding where you truly belong

---

## 📸 Screenshots

<!-- TODO: Add your app screenshots here -->
<!-- Replace with actual images once added to docs/images/ -->

> **📝 Note**: Add screenshots to `docs/images/` directory. See [docs/images/README.md](docs/images/README.md) for guidance.

```
Recommended screenshots:
- Onboarding/Splash Screen
- Profile Creation
- Matching/Swiping Interface  
- Match Reveal Screen
```

---

## 🎥 Demo

<!-- TODO: Add demo GIF here -->
<!-- ![App Demo](docs/images/demo.gif) -->

> **📝 Note**: Record a 10-15 second GIF walkthrough. Tools: [LICEcap](https://www.cockos.com/licecap/), [ScreenToGif](https://www.screentogif.com/), [Kap](https://getkap.co/)

---

## 🏗️ Architecture & Tech Stack

### **Frontend**
- **Swift 5.0+** - Primary programming language
- **SwiftUI 3.0+** - Modern declarative UI framework
- **iOS 15.0+** - Minimum deployment target

### **Backend & Services**
- **Firebase Authentication** - Secure user authentication
- **Firebase Firestore** - NoSQL cloud database
- **Firebase Cloud Storage** - Asset storage

### **Development Tools**
- **Xcode 14+** - IDE
- **Swift Package Manager** - Dependency management

### **Architecture Documents**
- 📐 [System Architecture Diagram](docs/ARCHITECTURE.md) - See how components connect
- 🗄️ [Database Schema (ERD)](docs/DATABASE_SCHEMA.md) - Understand data relationships

---

## 🚀 Getting Started

### Prerequisites

Before running Chairific, ensure you have:

- **macOS Monterey (12.0) or later**
- **Xcode 14.0 or later** ([Download](https://developer.apple.com/xcode/))
- **iOS 15.0+ device or simulator**
- **Active Apple Developer account** (for running on physical devices)
- **Firebase account** ([Sign up free](https://firebase.google.com/))

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/zacharyb1/chairific.git
   cd chairific
   ```

2. **Open the project in Xcode**
   ```bash
   open chairific/chairific.xcodeproj
   ```

3. **Configure Firebase** (Already configured, but here's how to set up your own):
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Add an iOS app with bundle ID: `com.chairific.chairificapp`
   - Download `GoogleService-Info.plist`
   - Replace the existing file at `chairific/chairific/GoogleService-Info.plist`
   - Enable **Authentication** (Email/Password) and **Firestore** in Firebase Console

4. **Install dependencies** (if using Swift Package Manager)
   - Xcode should automatically resolve packages
   - If not, go to **File > Packages > Resolve Package Versions**

5. **Select a target device**
   - Choose an iOS Simulator or connected device
   - Recommended: iPhone 14 Pro or later for best experience

6. **Build and Run**
   - Press `Cmd + R` or click the Play button
   - Wait for build to complete
   - App should launch in simulator/device

### Quick Start Commands

```bash
# Clone repository
git clone https://github.com/zacharyb1/chairific.git

# Navigate to project
cd chairific

# Open in Xcode
open chairific/chairific.xcodeproj

# Build and run from command line (requires xcodebuild)
xcodebuild -scheme chairific -destination 'platform=iOS Simulator,name=iPhone 14 Pro' build
```

---

## 📱 How to Use

### For Job Seekers (Employees)
1. **Sign Up**: Create account with email
2. **Build Profile**: Add your top 5 skills and hobbies
3. **Answer Questions**: Complete cultural fit questionnaire (10+ questions)
4. **Start Swiping**: Review anonymous job positions
5. **Match & Reveal**: When matched, choose to reveal identity

### For Employers
1. **Sign Up**: Create company account
2. **Setup Profile**: Describe company culture and benefits
3. **Post Positions**: Create job listings with 3 required skills each
4. **Answer Questions**: Complete company culture questionnaire
5. **Review Matches**: See compatible candidates and reveal when ready

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/AmazingFeature`)
3. **Commit changes** (`git commit -m 'feat: add amazing feature'`)
4. **Push to branch** (`git push origin feature/AmazingFeature`)
5. **Open a Pull Request**

### Commit Message Convention
We follow [Conventional Commits](https://www.conventionalcommits.org/):
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting)
- `refactor:` - Code refactoring
- `test:` - Test additions or changes
- `chore:` - Maintenance tasks

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## 👤 Contact & Links

- **GitHub**: [@zacharyb1](https://github.com/zacharyb1)
- **Repository**: [chairific](https://github.com/zacharyb1/chairific)
- **Issues**: [Report a bug](https://github.com/zacharyb1/chairific/issues)

---

## 🙏 Acknowledgments

- Firebase for backend infrastructure
- SwiftUI for modern iOS development
- The open-source community

---

<div align="center">

**⭐ Star this repo if you find it helpful!**

*Take a seat with Chairific and discover where you truly belong!* 🪑

</div>
