# Subject Tracker

A clean and modern Flutter app to track student subjects, marks, and grades.

## Features

- **Add Subjects**: Input subject name and mark (0–100)
- **Duplicate Prevention**: Prevents adding subjects with the same name
- **Grade System**: Automatic grade calculation (A, B, C, F)
- **Subject List**: View all subjects with swipe-to-delete functionality
- **Summary Dashboard**: 
  - Total subjects, passing & failing count
  - Average mark
  - Grade distribution with progress bars
- **Dark Mode Support**: Beautiful light & dark themes
- **Responsive UI**: Works well on different screen sizes


## Tech Stack

- Flutter
- Provider (State Management)
- Material 3 Design

## Project Structure
```
lib/
├── main.dart
├── provider/
│   └── subject_provider.dart
|   └── appstate_provider.dart     # Navigation & Theme state
├── models/
│   └── Subject.dart
├── pages/
│   ├── main_screen.dart
│   ├── subject_page.dart
│   ├── subjectlist_page.dart
│   └── summary_page.dart
└── widgets/
     └── appbar.dart

 ```



## How to Run the App

### Prerequisites

- Flutter SDK installed (`flutter --version`)
- Android Studio / VS Code
- Android Emulator or iOS Simulator / Physical Device

### Steps

1. **Clone or Download** the project

2. **Navigate to project folder**:
   ```bash
   cd subject-tracker
3. **Install dependencies and Run the app::
   ```bash
      flutter pub get
      flutter run
## How to Use

## Steps

1. **Go to "Add Subject" tab

2. **Enter Subject Name and Mark → Tap Add Subject
3. **View all entries in "Subject List" tab (swipe left to delete)
4. **Check statistics and grade distribution in "Summary" tab
5. **Toggle between Light and Dark mode using the switch in the AppBar
