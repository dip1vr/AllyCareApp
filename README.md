# AllyCare App

## 📌 Overview
AllyCare App is a responsive, production-ready mobile application built using **Flutter**.  
The app includes **Authentication, Assessment Module, and Appointment Module**, following **Clean Architecture principles**.  
It uses **GetX** for state management and routing.

---

## 📌 Architecture Decisions
- **Clean Architecture**: Project is divided into three layers:
  - `data/` – handles Firestore integration and local storage
  - `domain/` – contains business logic and models
  - `presentation/` – UI screens and widgets
- **Dumb Widgets**: Widgets only display data; all logic resides in controllers/services
- **Routing**: Page navigation implemented using **GetX** instead of TabBar for switching between modules

---

## 📌 State Management Choices
- **GetX** is used for:
  - Reactive state management
  - Page navigation
  - Handling UI updates on Firestore data changes
- Controllers manage business logic and provide data to UI widgets

---

## 📌 Features Implemented
- Firebase Authentication (Email/Password)
- Firestore Integration with offline caching and pagination
- Hero Animations for smooth transitions
- Appointment booking with Firestore write
- Responsive design for small phones, large phones, and tablets
- Custom theming for consistent colors, typography, and spacing
- Page navigation between modules (GetX)

### ⚠️ Features Not Implemented
- Favorites feature (using SharedPreferences) – skipped due to time constraints
- TabBar-based switching between Challenges and Workout Routines – replaced with page navigation via GetX

---

## 📌 Challenges Faced
- Implementing **offline caching** with Firestore  
- Matching **Figma design** for multiple screen sizes  
- Handling **animations** (Hero + transitions) smoothly  
- Deciding between **TabBar vs GetX page navigation** for simplicity  

---

## 📌 How to Run the App
1. Clone the repository:
```bash
git clone https://github.com/dip1vr/AllyCareApp.git
cd AllyCareApp
