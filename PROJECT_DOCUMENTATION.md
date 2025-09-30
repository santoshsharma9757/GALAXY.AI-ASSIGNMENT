# Galary.ai Assignment - Flutter Chat Application

## 📋 Project Overview
A modern, feature-rich chat application built with Flutter that mimics ChatGPT's UI/UX, featuring real-time chat, model selection, and persistent storage.

## 🎯 Key Features

### 1. **AI Chat Interface**
- Real-time streaming chat responses with "Typing..." indicator
- Clean message bubble UI without sender/receiver icons
- Automatic keyboard focus on app launch
- Message validation (prevents empty messages)

### 2. **GPT Model Selection**
- Dropdown with multiple AI models (GPT-4o, GPT-4o mini, o1-preview, o1-mini)
- Smart dropdown positioning (adapts to screen space)
- Auto-creates new chat when model is changed

### 3. **Welcome Screen**
- Feature shortcuts (Brainstorm, Create image, Summarize text, etc.)
- "More" button to reveal additional features
- Only visible when no active chat exists

### 4. **Persistent Storage**
- Hive database for local data storage
- Chat history with conversations
- Automatic conversation management

### 5. **Navigation & Screens**
- **App Drawer**: Search functionality, chat history, menu items (New chat, Library, GPTs, Projects)
- **Settings Screen**: User profile, preferences, sign-out
- **Upgrade Screen**: Feature comparison (Free vs Go plan)
- **Temporary Chat Screen**: Privacy-focused chat mode

### 6. **Media & Files**
- Image picker (Camera & Gallery access)
- AI bottom sheet with input options
- SVG icon support throughout the app

### 7. **UI/UX Highlights**
- Custom Lato font family (Google Fonts)
- Consistent color scheme and styling
- Toast notifications for user feedback
- Responsive design with proper spacing

## 🏗️ Architecture

### **Design Pattern**
- **MVVM (Model-View-ViewModel)** with Provider state management
- Clean separation of concerns with feature-based folder structure

### **Folder Structure**
```
lib/
├── config/
│   ├── routes/          # App routing
│   └── theme/           # Theme & styling
├── core/
│   ├── constants/       # App constants (colors, dimensions, strings)
│   ├── models/          # Data models (ChatMessage, ChatConversation)
│   ├── providers/       # State management (ChatProvider)
│   ├── utils/           # Utilities (ToastUtils)
│   └── widgets/         # Reusable widgets
├── features/
│   ├── home/            # Home screen
│   ├── settings/        # Settings screen
│   ├── upgrade/         # Upgrade screen
│   └── temporary_chat/  # Temporary chat screen
└── main.dart            # App entry point
```

## 🛠️ Tech Stack

### **Core**
- **Flutter SDK**: Cross-platform development
- **Dart**: Programming language

### **State Management**
- **Provider**: Reactive state management

### **Database**
- **Hive**: Lightweight local database
- **Hive Flutter**: Flutter integration
- **Hive Generator**: Code generation for adapters

### **UI/UX**
- **Google Fonts**: Custom typography (Lato)
- **Flutter SVG**: SVG icon support
- **Dropdown Button 2**: Enhanced dropdown UI

### **Media**
- **Image Picker**: Camera & gallery access

### **Notifications**
- **CustomSnackbar**: User feedback messages

### **Development Tools**
- **Build Runner**: Code generation
- **Flutter Lints**: Code quality
- **Flutter Launcher Icons**: App icon generation

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  dropdown_button2: ^2.3.9
  flutter_svg: ^2.0.9
  google_fonts: ^6.1.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  image_picker: ^1.0.7
  provider: ^6.1.1
  uuid: ^4.3.3

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  hive_generator: ^2.0.1
  build_runner: ^2.4.8
  flutter_launcher_icons: ^0.13.1
```

## 🚀 Setup & Installation

### **Prerequisites**
- Flutter SDK (3.0+)
- Android Studio / VS Code
- Android/iOS device or emulator

### **Installation Steps**
1. **Clone the repository**
   ```bash
   cd flutter_application_5
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters**
   ```bash
   dart run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 App Configuration

### **App Name**
- **Display Name**: Galary.ai Assignment
- **Package**: com.example.flutter_application_5

### **App Icon**
- Custom ChatGPT icon (`assets/png/chatgpt.png`)
- Generated for Android & iOS platforms

### **Permissions (Android)**
- CAMERA
- READ_EXTERNAL_STORAGE
- WRITE_EXTERNAL_STORAGE

## 🎨 Design System

### **Colors**
- Surface: `#FFFFFF` (White)
- Primary: `#000000` (Black)
- Border: `#E0E0E0` (Light Grey)
- Text Primary: `#000000`
- Text Secondary: `#666666`

### **Typography**
- Font Family: Lato (Google Fonts)
- Sizes: 12px - 24px
- Weights: Regular (400), Medium (500), Bold (700)

### **Spacing**
- Padding: 4px, 8px, 12px, 16px, 20px, 24px, 32px
- Radius: 8px, 12px, 16px, 20px

## ✨ Key Functionalities

### **Chat Management**
1. Start new conversation
2. Stream AI responses
3. Store messages in Hive
4. Display chat history
5. Load previous conversations

### **Model Selection**
1. Select from 4 GPT models
2. Auto-start new chat on model change
3. Display selected model in UI

### **Media Handling**
1. Capture photo (Camera)
2. Select from gallery
3. Toast notifications for success/error

### **User Experience**
1. Auto-focus text field on launch
2. Empty message validation
3. Smooth animations
4. Responsive layouts

## 📊 Data Models

### **ChatMessage**
```dart
- id: String
- conversationId: String
- content: String
- isUser: bool
- timestamp: DateTime
```

### **ChatConversation**
```dart
- id: String
- title: String
- modelUsed: String
- updatedAt: DateTime
```

## 🔄 State Management Flow

1. **User Input** → Text field
2. **Validation** → Check empty message
3. **Send Message** → ChatProvider
4. **Store in Hive** → Local database
5. **Stream Response** → AI simulation
6. **Update UI** → Consumer rebuilds
7. **Save Response** → Hive database

## 📝 Code Quality

- **Linting**: Enabled with flutter_lints
- **Structure**: Feature-based organization
- **Reusability**: Shared widgets and utilities
- **Constants**: Centralized in `app_strings.dart`, `app_colors.dart`, `app_dimensions.dart`
- **Documentation**: Inline comments for complex logic

## 🐛 Known Issues & Solutions

### **Issue 1: Dropdown Positioning**
- **Solution**: Used `dropdown_button2` package for smart positioning

### **Issue 2: Google Fonts Network Error**
- **Solution**: Fonts cached locally after first load

### **Issue 3: Keyboard Auto-Open**
- **Solution**: Implemented `WidgetsBinding.instance.addPostFrameCallback` with `FocusNode.requestFocus()`

## 🎯 Assignment Deliverables

✅ Modern chat UI matching ChatGPT design  
✅ Multiple AI model selection  
✅ Persistent storage with Hive  
✅ State management with Provider  
✅ Image picker integration  
✅ Custom app icon and name  
✅ Drawer with search and history  
✅ Settings and upgrade screens  
✅ Toast notifications  
✅ SVG icon support  
✅ Google Fonts integration  
✅ Clean architecture with proper folder structure  

## 📧 Contact & Support
For any queries regarding this project, please refer to the code documentation or contact the developer.

---

**Built with ❤️ using Flutter**
