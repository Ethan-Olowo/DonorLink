# DonorLink

DonorLink is a multi-platform Flutter application designed to streamline the management of donors, organisations, and reviewers for donation and charity ecosystems. The app integrates with Firebase and M-Pesa to provide secure authentication, data storage, and payment processing, supporting a modular and scalable architecture for real-world deployment.

---

## 🚀 Project Purpose

DonorLink aims to:
- Connect donors, organisations, and reviewers in a unified platform
- Simplify donation management and approval workflows
- Enable transparent reviews and ratings for organisations
- Provide real-time data visualization and reporting
- Support secure, multi-role access and payment integration

---

## ✨ Features

- **Multi-role dashboards:** Separate interfaces for Admins, Donors, Organisations, and Reviewers
- **Firebase integration:** Authentication, Firestore database, and storage
- **M-Pesa integration:** Secure mobile payments for donations
- **User authentication & registration:** Email/password login, password reset
- **Organisation approval workflow:** Admin and reviewer approval for organisations
- **Donation management:** Track, approve, and review donations and appointments
- **Data visualization:** Charts and reports for donations, interactions, and reviews
- **Modular codebase:** Clear separation of Models, Database, Resources, and Views
- **Theming and loading screens:** Consistent UI/UX across platforms
- **Unit/widget tests:** Located in the `test/` directory

---

## 🛠️ Setup & Startup Guide

### 1. Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (see `pubspec.yaml` for version)
- Firebase project (for Auth, Firestore, Storage)
- M-Pesa API credentials (if using payment features)

### 2. Required Configuration Files
Obtain these files from the project maintainer or your Firebase console:
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `macos/Runner/GoogleService-Info.plist`

Place them in the specified directories.

### 3. Environment Variables
Create a `.env` file at the project root for API keys and secrets (Firebase, M-Pesa, etc.). Use `.env.example` as a template:

```bash
cp .env.example .env
# Edit .env with your real values
```

**Never commit your real .env file or sensitive config files to version control.**

### 4. Install Dependencies

```bash
flutter pub get
```

### 5. Run the App

```bash
flutter run
```

---

## 📁 Codebase Structure

- `lib/Models/` — Data models for users, donations, reviews, etc.
- `lib/Database/` — Database access and business logic for each role
- `lib/resources/` — UI components, charts, validators, and utilities
- `lib/views/` — Screens for login, registration, dashboards, etc.
- `assets/` — Images and static assets
- `test/` — Unit and widget tests

---

## 📊 Main Modules & Roles

- **Admin:** Approves/rejects reviewers and organisations, manages users
- **Donor:** Browses organisations, makes donations, views history
- **Organisation:** Manages profile, receives/approves donations
- **Reviewer:** Reviews organisations, submits feedback

---

## 📦 Dependencies

Key packages (see `pubspec.yaml` for full list):
- `firebase_core`, `firebase_auth`, `cloud_firestore`, `firebase_storage`
- `flutter_dotenv`, `http`, `intl`, `fl_chart`, `google_fonts`, `file_picker`
- `cupertino_icons`, `hexcolor`

---

## 🧪 Testing

Run unit and widget tests:

```bash
flutter test
```

---

## 📚 Further Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [M-Pesa API Docs](https://developer.safaricom.co.ke/daraja/apis/post/safaricom-sandbox)

For more details, see code comments and individual module docs.
