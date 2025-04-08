<p align="center">
  <img src="https://github.com/user-attachments/assets/815b2659-4285-4ae5-94e0-e187dc2354ba" alt="App Logo" width="120"/>
</p>

# 🎨 Wallframe Wallpaper App

This repository contains **two Flutter applications**:

1. **Wallframe App**  — for users to explore, view, and set wallpapers.
2. **Wallframe Admin App** — for managing wallpapers and categories via a simple dashboard with authentication.

Both apps use **Firebase** and share a common backend structure.

---

## 🚀 Apps

### 📱 Wallframe Wallpaper App
- 📁 Category-wise wallpaper browsing
- 📲 Set wallpaper on **Home Screen**, **Lock Screen**, or **Both**
- 🔄 Image caching for faster loading (using `flutter_cache_manager`)
- ☁️ Images hosted on **Firebase Storage**
- 📄 Metadata managed with **Cloud Firestore**
- ✅ Built with `Provider` for smooth state management
- Uses `flutter_cache_manager` and `wallpaper_manager_plus`
- No authentication required

> 📄 Detailed setup in [`/wallframe/README.md`](wallframe/README.md)

---

### 🛠️ Wallframe Admin Dashboard
- Firebase Authentication (email/password)
- Upload wallpapers with category tags
- Store image URLs in Firestore
- Images stored in Firebase Storage

> 📄 Detailed setup in [`/wallframeadmin/README.md`](wallframeadmin/README.md)

---

## 🧰 Tech Stack (Both Apps)

- **Flutter**
- **Firebase (Storage + Firestore)**
- `wallpaper_manager_plus`
- `flutter_cache_manager`
- `provider`

---
## 🛠️ Setup Instructions

Each app has its own dependencies and Firebase configuration.

- Make sure to add:
  - `google-services.json` for Android in both apps
  - `GoogleService-Info.plist` for iOS in both apps

See individual READMEs for complete setup.

---


Developed by 👨‍💻 [Shivam Bari](https://github.com/ShivamBari2728)

