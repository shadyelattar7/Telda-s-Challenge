# 🎬 Telda’s Mobile Engineer Challenge 
Welcome to my submission for the **Telda Mobile Engineer Challenge**. This is a simple yet fun movie app that interacts with [The Movie DB API](https://www.themoviedb.org) to deliver a search and discovery experience. The app was built to demonstrate architectural best practices, modularity, and clean code structure.  

## 📱 Features 
- 🔍 Search for movies by title 
- 🧲 Display of popular movies when search is empty 
- 📅 Grouping movies by release year 
- 🎞 Movie details view with:   
 - Title, overview, image, tagline, revenue, release date, status  
 - Similar movies (up to 5)   
 - Top 5 actors & 5 directors grouped and sorted by popularity 
- ⭐ Simulated watchlist toggle
 - 📉 Image caching and placeholder support for failed loads 

## 🛠️ Tech Stack 
- **UIKit** (UI implementation) 
- **MVVM** architecture
 - **Combine** for reactive bindings and data flow
 - **Swift Package Manager (SPM)** for modularization
 - **URLSession** for network handling 

## 🧱 Architecture 
The app follows a clean, scalable MVVM architecture with a modular project setup:  
- `Network`: Handles API calls with full abstraction.
 - `Domain`: Contains Models & Use Cases.
 - `Presentation`: Views and ViewModels.
Each layer is decoupled to ensure separation of concerns and ease of testability or extension.

## 🚀 Getting Started 
1. Clone the repository:     ```bash     git clone https://github.com/shadyelattar7/Telda-s-Challenge.git     ``` 
2. Open the `.xcodeproj` or `.xcworkspace` file in Xcode. 
3. Add your **TMDB API key** in the appropriate configuration file. 
4. Run on any iPhone simulator or device (iOS 14+ supported). 

## 📸 Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/cc4612a1-091b-42b3-84b6-9972346e9880" alt="Screenshot 1" width="45%" />
  <img src="https://github.com/user-attachments/assets/1398b035-fb30-4e22-99c0-eb25cdc055d5" alt="Screenshot 2" width="45%" />
</p>

## 📝 Notes 
- The watchlist is simulated (not persisted). 
- Network layer includes abstraction for clean and reusable code.
 - Focus was placed on clarity, modularity, and performance. 





