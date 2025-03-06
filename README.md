# iOS_lab3
## Implementation Decisions

### 1. **Архитектура и паттерны**
Проект построен на основе **MVVM (Model-View-ViewModel)**, что обеспечивает разделение логики представления (UI) и бизнес-логики.  

- **Model (Hero.swift)** – представляет данные о супергероях, включая их характеристики, изображение и параметры внешности.  
- **ViewModel (ViewModel.swift)** – управляет состоянием приложения, загружает данные о героях и сохраняет избранных героев с использованием `UserDefaults`.  
- **View (ContentView.swift, FavoritesView.swift)** – отвечает за отображение данных, обрабатывает пользовательские действия и передает их в `ViewModel`.

### 2. **Работа с API**
Используется **Superhero API**, откуда загружаются данные о супергероях.  

- **Формат API**: JSON-файл со списком всех героев.  
- **Метод загрузки**: `URLSession` с `async/await` для асинхронного выполнения запросов.  
- **Обработка данных**: Используется `JSONDecoder` для преобразования JSON в модель `Hero`.  

### 3. **Асинхронность**
Метод `fetchHero()` использует `async/await`, чтобы не блокировать UI при загрузке данных.  
- После успешного выполнения запроса выборка случайного героя происходит на `MainActor`, чтобы обновить UI в главном потоке.  

### 4. **Работа с избранным**
Для управления избранными героями используется `UserDefaults`:  
- Герои сохраняются в формате JSON.  
- При изменении списка избранных `favorites` автоматически вызывается метод `saveFavorites()`.  
- Данные загружаются из памяти при запуске `ViewModel`.  

### 5. **SwiftUI и анимации**
Для улучшения пользовательского опыта применены:  
- **`AsyncImage`** – загружает изображение героя с плавной анимацией.  
- **`transition(.scale(scale: 0.8).combined(with: .opacity))`** – анимация появления картинки.  
- **`animation(.spring(response: 0.7, dampingFraction: 0.7))`** – мягкая анимация смены героя.  
- **`NavigationStack`** – используется для навигации между главным экраном и экраном избранных героев.  

### 6. **UI и взаимодействие**
- **Контент**: В `ContentView` показывается случайный герой с его характеристиками.  
- **Кнопки**:  
  - `Roll Hero` 🎲 – загружает случайного героя.  
  - `Heart ❤️` – добавляет героя в избранное.  
  - `Star ⭐` – открывает список избранных героев.  
  - `Trash 🗑` – удаляет героя из избранного.  
- **Выравнивание данных**: `HStack` с `frame(minWidth:alignment:)` используется для ровного отображения характеристик.  

### 7. **Обработка ошибок**
Если загрузка изображения героя не удалась, вместо него отображается красный фон (`Color.red`).  

---

Это основные решения, принятые при разработке. Если что-то нужно уточнить или доработать, скажи! 🚀
