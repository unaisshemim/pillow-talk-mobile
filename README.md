# 💕 Pillow Talk Mobile

**A couple wellbeing app built with Flutter that helps strengthen relationships through better communication and shared experiences.**

<div align="center">
  <img src="assets/logo/icon.png" alt="Pillow Talk Logo" width="120" height="120">
</div>

---

## 📱 About

Pillow Talk is a comprehensive mobile application designed to enhance communication and strengthen relationships between couples. The app provides tools for meaningful conversations, relationship analytics, goal tracking, and personalized insights to help couples build deeper connections.

### ✨ Key Features

- 🏠 **Personalized Dashboard** - Mood tracking, relationship activities, and progress monitoring
- 💬 **Advanced Chat System** - Voice messages, sentiment analysis, and conversation insights
- 👥 **Partner Management** - Connect with your partner, share goals, and track relationship milestones
- 🔔 **Smart Notifications** - Love notes, activity reminders, and relationship insights
- 📊 **Analytics & Insights** - Conversation analytics and relationship progress tracking
- 🎯 **Goal Setting** - Shared relationship goals with progress tracking
- 🎨 **Beautiful UI** - Modern design with light/dark theme support
- 🔒 **Privacy & Security** - Secure data handling with privacy controls

---

## 🛠 Technology Stack

| Technology | Version | Purpose |
|------------|---------|---------|
| **Flutter** | SDK ^3.8.1 | Cross-platform mobile development |
---

## 📋 Prerequisites

Before running this project, make sure you have the following installed:

### Required Software
- **Flutter SDK**: `3.32.7` or higher
- **Dart SDK**: Included with Flutter
- **Android Studio** or **Xcode** (for device/emulator)
- **VS Code** (recommended) with Flutter extensions

### System Requirements
- **macOS**: 10.14 or higher (for iOS development)
- **Windows**: 10 or higher
- **Linux**: 64-bit distribution
- **RAM**: 8GB minimum, 16GB recommended
- **Storage**: 10GB free space

---

## 🚀 Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/unaisshemim/pillow_talk_mobile.git
cd pillow_talk_mobile
```

### 2. Install Flutter Dependencies
```bash
flutter pub get
```

### 3. Verify Flutter Installation
```bash
flutter doctor
```
Ensure all checkmarks are green before proceeding.

### 4. Generate App Icons (Optional)
```bash
flutter pub run flutter_launcher_icons:main
```

### 5. Generate Splash Screen (Optional)
```bash
flutter pub run flutter_native_splash:create
```

---

## 🏃‍♂️ Running the Project

### Development Mode

#### Run on Android Emulator/Device
```bash
flutter run
```

#### Run on iOS Simulator/Device (macOS only)
```bash
flutter run -d ios
```

#### Run on Chrome (Web Development)
```bash
flutter run -d chrome
```

### Production Build

#### Android APK
```bash
flutter build apk --release
```

#### Android App Bundle (recommended for Play Store)
```bash
flutter build appbundle --release
```

#### iOS (macOS only)
```bash
flutter build ios --release
```

---

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point
├── common/                   # Shared components and utilities
├── features/                 # Feature-based modules
│   ├── home/                # Home dashboard
│   ├── chat/                # Chat and messaging
│   ├── partner/             # Partner management
│   ├── profile/             # User profile and settings
│   ├── notifications/       # Notification management
│   └── onboarding/          # App onboarding flow
├── utils/                   # Utilities and helpers
│   ├── constant/            # App constants (colors, sizes)
│   ├── theme/               # Theme configuration
│   └── helpers/             # Helper functions
└── router.dart              # Navigation configuration

assets/
├── logo/                    # App icons and branding
└── icons/                   # UI icons and graphics
```

---

## 🎨 Design System

### Color Palette
- **Primary**: Amber (#FBA63A) - Warmth and connection
- **Secondary**: Teal (#6EA7D3) - Trust and communication
- **Neutral**: Grayscale palette for text and backgrounds
- **Error**: Red for alerts and warnings
- **Success**: Green for positive feedback

### Typography
- Responsive font sizing based on screen dimensions
- Material Design typography guidelines
- Support for multiple font weights

---

## 🔧 Configuration

### App Configuration
- **Package Name**: `com.example.pillow_talk`
- **Min SDK**: Android 21 (Android 5.0)
- **Target SDK**: Latest Android
- **iOS Deployment**: iOS 11.0+

### Environment Setup
The app uses environment-based configuration for different deployment stages:
- Development
- Staging  
- Production

---

## 📱 Features Overview

### 🏠 Home Dashboard
- **Mood Tracking**: Daily mood selection with insights
- **Activity Cards**: Suggested couple activities
- **Progress Tracking**: Relationship milestones and goals
- **Quick Actions**: Fast access to chat and partner features

### 💬 Chat System
- **Voice Messages**: Record and send voice notes
- **Session Management**: Organized conversation history
- **Sentiment Analysis**: Understand conversation tone
- **Topic Suggestions**: AI-powered conversation starters

### 👥 Partner Management
- **Partner Connection**: Search and connect with your partner
- **Shared Goals**: Set and track relationship objectives
- **Analytics Dashboard**: Relationship insights and progress
- **Milestone Tracking**: Celebrate relationship achievements

### 🔔 Notifications
- **Love Notes**: Sweet daily reminders
- **Activity Suggestions**: Personalized couple activities
- **Goal Reminders**: Progress notifications
- **Anniversary Alerts**: Important date reminders

---

## 🧪 Testing

### Run Tests
```bash
flutter test
```

### Run Tests with Coverage
```bash
flutter test --coverage
```

### Widget Testing
```bash
flutter test test/widget_test.dart
```

---

## 🚀 Deployment

### Android Deployment
1. **Generate Signed APK**:
   ```bash
   flutter build apk --release
   ```

2. **Generate App Bundle** (recommended):
   ```bash
   flutter build appbundle --release
   ```

3. **Upload to Google Play Console**

### iOS Deployment (macOS only)
1. **Build for iOS**:
   ```bash
   flutter build ios --release
   ```

2. **Archive in Xcode**
3. **Upload to App Store Connect**

---

## 🐛 Troubleshooting

### Common Issues

#### Flutter Doctor Issues
```bash
flutter doctor --verbose
```

#### Clear Build Cache
```bash
flutter clean
flutter pub get
```

#### Reset iOS Simulator
```bash
flutter run -d ios --debug
```

#### Android Build Issues
```bash
cd android
./gradlew clean
cd ..
flutter run
```

---

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Commit changes**: `git commit -m 'Add amazing feature'`
4. **Push to branch**: `git push origin feature/amazing-feature`
5. **Open a Pull Request**

### Development Guidelines
- Follow Dart/Flutter coding standards
- Write meaningful commit messages
- Add tests for new features
- Update documentation as needed

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 💬 Support

For support and questions:
- **Email**: support@pillowtalk.com
- **GitHub Issues**: [Create an issue](https://github.com/unaisshemim/pillow_talk_mobile/issues)
- **Documentation**: [Wiki](https://github.com/unaisshemim/pillow_talk_mobile/wiki)

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design for UI guidelines
- The open-source community for valuable packages
- All contributors who helped build this project

---

<div align="center">
  <p>Made with ❤️ for couples everywhere</p>
  <p><strong>Building stronger relationships through better communication</strong></p>
</div>
