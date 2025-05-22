# Zenovate Worknest

Zenovate Worknest is a Flutter-based Employee & Intern Management System designed for hackathons and rapid prototyping. It provides a modern, Kanban-style interface for managing users, tasks, attendance, and performance reviews.

## Features

- **User Authentication**: Simulated login and sign-up with role-based access (Admin, Manager, Employee, Intern).
- **Dashboard**: Quick stats and shortcuts for common actions.
- **Directory**: View and manage employee/intern profiles.
- **Task Management**: Kanban board for tracking tasks by status and priority.
- **Attendance Tracking**: Simple check-in/check-out and daily summaries.
- **Performance Reviews**: Submit and view feedback.
- **Admin Panel**: Generate reports, manage roles, and backup/restore data.
- **Modern UI**: Responsive, themed interface with navigation drawer.

## Screenshots
![Untitled design (8)](https://github.com/user-attachments/assets/259113b8-7b82-4824-86e8-5fc1d0a3e53b)

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio, VS Code, or any Flutter-compatible IDE

### Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/yourusername/zenovate_worknest.git
   cd zenovate_worknest
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Run the app:**
   ```sh
   flutter run
   ```

## Folder Structure

- `lib/`
  - `main.dart` - App entry point and UI
  - `models/` - Data models (User, Task)
  - `services/` - Business logic (Auth, Task)
- `android/`, `ios/`, `web/`, `linux/`, `macos/`, `windows/` - Platform-specific code

## Demo Accounts

- **Admin:**  
  Email: `admin@zenovate.com`  
  (No password required for demo)
  Later Firebase with admin password will be release.

- **Manager:**  
  Email: `manager@zenovate.com`  
  (No password required for demo)
  Later Firebase with google authentication will be release.

## Notes

- This app uses in-memory data and [shared_preferences](https://pub.dev/packages/shared_preferences) for session persistence.
- No backend is required; all data resets on restart.
- Ideal for hackathons, demos, and rapid prototyping.
- Further the datas will be stored in mongo DB and Firebase cloudstore.

