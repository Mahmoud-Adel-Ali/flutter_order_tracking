# 📦 Flutter Order Tracking Notification System

A complete Flutter-based mobile application for tracking order statuses in a B2B pharmacy flow. This system provides real-time push notifications and visual tracking for order status changes (Pending → Confirmed → Shipped → Delivered) using Firebase Cloud Messaging.

---

## 🚀 Features

- 🔔 Push notifications for order status changes  
- 📈 Visual progress line (stepper) showing order status  
- 📱 Works in Foreground, Background, and Terminated states  
- 🎨 Follows iSUPPLY branding and user experience guidelines  
- 🌐 Firebase integration for messaging and data flow  

---

## 📽️ Demo Video

Watch the full demonstration on YouTube / Google Drive:  
[🔗 Demo Video Link](https://your-video-link.com)

---

## 🛠️ Tech Stack

- ✅ Flutter 3.x
- ✅ Dart
- ✅ Firebase Cloud Messaging (FCM)
- ✅ Flutter Local Notifications
- ✅ Firebase Core & Initialization
- ✅ VS Code

---

## 🧪 How It Works

### ▶️ Foreground Mode
- The app is open
- Status change triggers an instant in-app notification
- UI updates with the new order status step

### ⬇️ Background Mode
- The app is minimized
- A system-level push notification appears at the top
- App updates the tracking line when resumed

### ❌ Terminated Mode
- The app is completely closed
- A Firebase notification is triggered
- Notification is received and shown in the system tray

---
## 📂 Project Structure

```bash
lib/
├── main.dart
├── core/
│   └── firebase_service.dart
│   └── utils/
├── features/
│   ├── notifications/
│   ├── order_tracking/
│   └── ui/




