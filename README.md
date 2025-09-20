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

git clone https://github.com/dip1vr/AllyCareApp.git
cd AllyCareApp

## Images for Different screen sizes


<img width="453" height="913" alt="Screenshot 2025-09-20 184100" src="https://github.com/user-attachments/assets/b5d0063e-19e9-40c1-beed-9d3d5a0be8b7" />
<img width="523" height="825" alt="Screenshot 2025-09-20 184159" src="https://github.com/user-attachments/assets/d6f211c6-eece-462c-b835-8b8f033aa975" />
<img width="422" height="916" alt="Screenshot 2025-09-20 184128" src="https://github.com/user-attachments/assets/03859f6b-bbe2-4c15-8213-f4408dbc466b" />




<img width="539" height="917" alt="Screenshot 2025-09-20 184547" src="https://github.com/user-attachments/assets/10ce41ea-b416-4f0c-86f9-58ade0eb36fd" />
<img width="443" height="936" alt="Screenshot 2025-09-20 184529" src="https://github.com/user-attachments/assets/039fb25f-bd91-47f9-9ae2-842bedb41689" />
<img width="444" height="934" alt="Screenshot 2025-09-20 184510" src="https://github.com/user-attachments/assets/a859c9c7-1395-4773-b9ad-92ff61bf2187" />



<img width="524" height="910" alt="Screenshot 2025-09-20 184725" src="https://github.com/user-attachments/assets/bf49e28c-8bf6-4fac-8e0a-9d2f33ca7543" />
<img width="438" height="934" alt="Screenshot 2025-09-20 184709" src="https://github.com/user-attachments/assets/5014bc7e-755d-4a13-8117-5a96fc273205" />
<img width="462" height="932" alt="Screenshot 2025-09-20 184647" src="https://github.com/user-attachments/assets/1e86bfc6-33d6-4089-8262-5345cf0cbebe" />



<img width="581" height="991" alt="Screenshot 2025-09-20 184838" src="https://github.com/user-attachments/assets/cc7c51ee-420a-4ab0-be02-5c3ed00d5c95" />
<img width="436" height="934" alt="Screenshot 2025-09-20 184823" src="https://github.com/user-attachments/assets/b499ced5-b0d4-487e-9425-c779ee17fc98" />
<img width="460" height="924" alt="Screenshot 2025-09-20 184808" src="https://github.com/user-attachments/assets/25b268fe-da45-4ad4-8830-6c302bca8fec" />



<img width="533" height="907" alt="Screenshot 2025-09-20 184948" src="https://github.com/user-attachments/assets/390cf4d7-8e63-49f4-8324-b960f2893e95" />
<img width="432" height="937" alt="Screenshot 2025-09-20 184931" src="https://github.com/user-attachments/assets/87ed4720-77d5-4ca3-a082-ed182ae23966" />
<img width="455" height="919" alt="Screenshot 2025-09-20 184910" src="https://github.com/user-attachments/assets/c54e587d-bb10-4f6b-9dd7-1f74b8dc2ed7" />




<img width="512" height="906" alt="Screenshot 2025-09-20 185101" src="https://github.com/user-attachments/assets/d087d6f4-65d7-4e3d-8770-d0ca163f1dfe" />
<img width="437" height="926" alt="Screenshot 2025-09-20 185045" src="https://github.com/user-attachments/assets/a6023264-72b6-4a20-a1d8-da50eaeddda5" />
<img width="449" height="926" alt="Screenshot 2025-09-20 185029" src="https://github.com/user-attachments/assets/5f324f7e-3130-4b05-9059-5d163433662a" />




