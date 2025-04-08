<p align="center">
  <img src="https://github.com/user-attachments/assets/23007c57-36ca-4446-86cd-60d644a1ae90" alt="App Logo" width="120"/>
</p>


# 🛠️ WallFrame Admin

This is the admin panel for the **WallFrame** wallpaper platform. It's a Flutter app designed for admins to securely upload wallpapers to Firebase Storage and save metadata like category and image URL to Firestore.

---

## 🔐 Key Features

- 🔑 **Admin Login** (Firebase Authentication)
- 🖼️ **Upload Wallpapers** to Firebase Storage
- 🗂️ **Assign Categories** to each wallpaper
- ☁️ **Save Metadata** to Firestore (image URL, category)

---

## ⚙️ Tech Stack

- Flutter
- Firebase Authentication
- Firebase Storage
- Firebase Firestore

---

## 🚀 Getting Started

1. **Clone the repo**
   ```bash
   git clone https://github.com/ShivamBari2728/Wallframe-App.git
   
   cd Wallframe-App/wallframeadmin
2. **Install Dependencies**
   ```bash
   flutter pub get
3. **Add Firebase Configuration**
   Download your google-services.json from the Firebase Console and place it in: 
   ```bash
   wallframe/android/app/google-services.json (for Android)
   wallframe/ios/Runner/GoogleService-Info.plist (for IOS)
3. **Run te project**
   ```bash
   flutter run

**⚠️ Ensure Firebase Authentication, Firestore, and Storage are properly set up.**

## Screenshots
<p align="center">
  <img src="https://github.com/user-attachments/assets/0135adcb-c41a-48f9-b5d2-31c9323d340e" alt="Admin Login" width="250"/> 
  <img src="https://github.com/user-attachments/assets/92b496ce-f72c-4708-9ced-24b05d2d282e" alt="Upload Screen" width="250"/> 
</p>
