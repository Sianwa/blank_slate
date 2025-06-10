```
██████╗ ██╗      █████╗ ███╗   ██╗██╗  ██╗      ███████╗██╗      █████╗ ████████╗███████╗
██╔══██╗██║     ██╔══██╗████╗  ██║██║ ██╔╝      ██╔════╝██║     ██╔══██╗╚══██╔══╝██╔════╝
██████╔╝██║     ███████║██╔██╗ ██║█████╔╝       ███████╗██║     ███████║   ██║   █████╗
██╔══██╗██║     ██╔══██║██║╚██╗██║██╔═██╗       ╚════██║██║     ██╔══██║   ██║   ██╔══╝
██████╔╝███████╗██║  ██║██║ ╚████║██║  ██╗      ███████║███████╗██║  ██║   ██║   ███████╗
╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝      ╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝

```

## 🚀 Get Started with your new mobile app project!

This template provides a basic, ready-to-use Flutter application pre-configured with essential dependencies and services to help you kickstart your mobile development rapidly.

### ✨ Features Included:

* **Navigation:** (Using `go_router` or simple Navigator 2.0 setup)
* **Notifications:** (`firebase_messaging` or `flutter_local_notifications` integration)
* **API Configs:*** Quickly setup API connections in the /api folder using `retrofit` and `dio`.
* **Shared Preferences:** (for simple key-value data storage)
* **User Preferences/Settings:** (basic setup for managing app settings)
* **Clean Project Structure:** (MVVM arch.)
* **Automated Setup Script:** Quickly renames your app and configures package IDs.

---

## 🏁 Getting Started

Follow these simple steps to customize this template into your new unique Flutter application.

### Prerequisites

Before you begin, ensure you have the following installed on your machine:

* [**Flutter SDK**](https://flutter.dev/docs/get-started/install) (Stable channel recommended)
* [**Git**](https://git-scm.com/downloads)

### Usage Instructions:

1.  **Clone the Repository:**
    Start by cloning this template repository to your local machine.

    ```bash
    git clone https://github.com/Sianwa/blank_slate.git my_new_app_name
    ```
    (Replace `my_new_app_name` with your desired project folder name.)

2.  **Navigate to the Project Folder and Run the Setup Script:**
    Change your directory into the newly cloned project folder and execute the setup script.

    ```bash
    cd my_new_app_name
    ./scripts/setup.sh
    ```
    *This script will automate the process of:*
    * Renaming your Flutter application.
    * Updating Android package IDs and directory structures.
    * Updating iOS bundle IDs.
    * Cleaning up the template's Git history to start fresh for your new project.
    * Running `flutter clean` and `flutter pub get`.

3.  **Follow the Prompts:**
    The `setup.sh` script will guide you through the customization process.
    * You will be prompted to **enter your desired App Name** (e.g., "My Awesome App").
    * You will then be prompted to **enter your desired Package ID** (e.g., "com.yourcompany.yourapp"). Ensure this follows the reverse domain format (lowercase, numbers, underscores allowed).

---

## 🚀 Start Building!

Once the script completes successfully, your project is fully customized and ready for development.

* **Run your app:**
    ```bash
    flutter run
    ```
* **Build for Android:**
    ```bash
    flutter build apk
    # or for appbundle:
    flutter build appbundle
    ```
* **Build for iOS (macOS only):**
    ```bash
    flutter build ios
    # or for XCode:
    flutter build ios --no-codesign && open ios/Runner.xcworkspace
    ```

---

## 🧑‍💻 Contributing to the Template (Optional Section)

If you'd like to contribute to improving this template, please feel free to open issues or submit pull requests.

---

## 📄 License (Optional Section)

This project is licensed under the [MIT License](LICENSE).

---
