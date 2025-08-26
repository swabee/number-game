# number_game by swabeeh

A new Flutter project.


#setup step

1. git clone https://github.com/swabee/number-game.git
2. flutter clean
3. flutter pub get
4. flutter run/flutter run -v


#Project structed

```bash
📦lib
 ┣ 📂backend
 ┃ ┗ 📜hive_storage_service.dart
 ┣ 📂constant
 ┃ ┣ 📜app_constants.dart
 ┃ ┗ 📜app_level_condition.dart
 ┣ 📂custom
 ┃ ┣ 📜button_custom.dart
 ┃ ┣ 📜container_custom.dart
 ┃ ┣ 📜iconbutton_custom.dart
 ┃ ┣ 📜scafold_custom.dart
 ┃ ┣ 📜textfield_custom.dart
 ┃ ┗ 📜text_custom.dart
 ┣ 📂errors
 ┃ ┣ 📜common_error_response.dart
 ┃ ┣ 📜error_response.dart
 ┃ ┣ 📜exceptions.dart
 ┃ ┗ 📜failures.dart
 ┣ 📂features
 ┃ ┣ 📂app_data
 ┃ ┃ ┣ 📂data
 ┃ ┃ ┃ ┣ 📂datasources
 ┃ ┃ ┃ ┃ ┗ 📜app_data_local_data_source.dart
 ┃ ┃ ┃ ┣ 📂models
 ┃ ┃ ┃ ┃ ┗ 📜app_data_model.dart
 ┃ ┃ ┃ ┗ 📂repositories
 ┃ ┃ ┃ ┃ ┗ 📜app_data_repository_impl.dart
 ┃ ┃ ┣ 📂domain
 ┃ ┃ ┃ ┣ 📂entities
 ┃ ┃ ┃ ┃ ┗ 📜app_data_entity.dart
 ┃ ┃ ┃ ┣ 📂repositories
 ┃ ┃ ┃ ┃ ┗ 📜app_data_repository.dart
 ┃ ┃ ┃ ┗ 📂usecases
 ┃ ┃ ┃ ┃ ┣ 📜get_app_data_usecase.dart
 ┃ ┃ ┃ ┃ ┗ 📜update_app_data_usecase.dart
 ┃ ┃ ┗ 📂presentation
 ┃ ┃ ┃ ┣ 📂bloc
 ┃ ┃ ┃ ┃ ┣ 📜app_data_bloc.dart
 ┃ ┃ ┃ ┃ ┣ 📜app_data_event.dart
 ┃ ┃ ┃ ┃ ┗ 📜app_data_state.dart
 ┃ ┃ ┃ ┣ 📂pages
 ┃ ┃ ┃ ┗ 📂widgets
 ┃ ┃ ┃ ┃ ┣ 📜home_best_score_tile.dart
 ┃ ┃ ┃ ┃ ┗ 📜home_settings_dialouge.dart
 ┃ ┣ 📂game_base
 ┃ ┃ ┣ 📂data
 ┃ ┃ ┃ ┣ 📂datasources
 ┃ ┃ ┃ ┣ 📂models
 ┃ ┃ ┃ ┗ 📂repositories
 ┃ ┃ ┣ 📂domain
 ┃ ┃ ┃ ┣ 📂entities
 ┃ ┃ ┃ ┣ 📂repositories
 ┃ ┃ ┃ ┗ 📂usecases
 ┃ ┃ ┗ 📂presentation
 ┃ ┃ ┃ ┣ 📂bloc
 ┃ ┃ ┃ ┃ ┣ 📜game_base_bloc.dart
 ┃ ┃ ┃ ┃ ┣ 📜game_base_event.dart
 ┃ ┃ ┃ ┃ ┗ 📜game_base_state.dart
 ┃ ┃ ┃ ┣ 📂pages
 ┃ ┃ ┃ ┃ ┗ 📜game_base_page.dart
 ┃ ┃ ┃ ┗ 📂widgets
 ┃ ┣ 📂game_daily_task
 ┃ ┃ ┣ 📂data
 ┃ ┃ ┃ ┣ 📂datasources
 ┃ ┃ ┃ ┃ ┗ 📜daily_game_local_data_source.dart
 ┃ ┃ ┃ ┣ 📂models
 ┃ ┃ ┃ ┗ 📂repositories
 ┃ ┃ ┃ ┃ ┗ 📜daily_game_repository_impl.dart
 ┃ ┃ ┣ 📂domain
 ┃ ┃ ┃ ┣ 📂entities
 ┃ ┃ ┃ ┣ 📂repositories
 ┃ ┃ ┃ ┃ ┗ 📜daily_game_repositroy.dart
 ┃ ┃ ┃ ┗ 📂usecases
 ┃ ┃ ┃ ┃ ┗ 📜get_daily_game_history_usecase.dart
 ┃ ┃ ┗ 📂presentation
 ┃ ┃ ┃ ┣ 📂bloc
 ┃ ┃ ┃ ┃ ┣ 📜game_daily_task_bloc.dart
 ┃ ┃ ┃ ┃ ┣ 📜game_daily_task_event.dart
 ┃ ┃ ┃ ┃ ┗ 📜game_daily_task_state.dart
 ┃ ┃ ┃ ┣ 📂pages
 ┃ ┃ ┃ ┃ ┗ 📜daily_task_page.dart
 ┃ ┃ ┃ ┗ 📂widgets
 ┃ ┃ ┃ ┃ ┗ 📜custom_calender.dart
 ┃ ┣ 📂game_home
 ┃ ┃ ┣ 📂data
 ┃ ┃ ┃ ┣ 📂datasources
 ┃ ┃ ┃ ┣ 📂models
 ┃ ┃ ┃ ┗ 📂repositories
 ┃ ┃ ┣ 📂domain
 ┃ ┃ ┃ ┣ 📂entities
 ┃ ┃ ┃ ┣ 📂repositories
 ┃ ┃ ┃ ┗ 📂usecases
 ┃ ┃ ┗ 📂presentation
 ┃ ┃ ┃ ┣ 📂bloc
 ┃ ┃ ┃ ┃ ┣ 📜game_home_bloc.dart
 ┃ ┃ ┃ ┃ ┣ 📜game_home_event.dart
 ┃ ┃ ┃ ┃ ┗ 📜game_home_state.dart
 ┃ ┃ ┃ ┣ 📂pages
 ┃ ┃ ┃ ┃ ┗ 📜game_home_page.dart
 ┃ ┃ ┃ ┗ 📂widgets
 ┃ ┃ ┃ ┃ ┣ 📜game_screen_bottm_bar_custom.dart
 ┃ ┃ ┃ ┃ ┣ 📜home_button_custom.dart
 ┃ ┃ ┃ ┃ ┣ 📜home_game_daily_challange_tile.dart
 ┃ ┃ ┃ ┃ ┗ 📜shake_number_widget.dart
 ┃ ┣ 📂game_rewards
 ┃ ┃ ┣ 📂data
 ┃ ┃ ┃ ┣ 📂datasources
 ┃ ┃ ┃ ┃ ┗ 📜game_rewards_local_data_source.dart
 ┃ ┃ ┃ ┣ 📂models
 ┃ ┃ ┃ ┃ ┗ 📜reward_data_model.dart
 ┃ ┃ ┃ ┗ 📂repositories
 ┃ ┃ ┃ ┃ ┗ 📜game_reward_repositroy_impl.dart
 ┃ ┃ ┣ 📂domain
 ┃ ┃ ┃ ┣ 📂entities
 ┃ ┃ ┃ ┃ ┗ 📜reward_data_entity.dart
 ┃ ┃ ┃ ┣ 📂repositories
 ┃ ┃ ┃ ┃ ┗ 📜game_rewards_repositroy.dart
 ┃ ┃ ┃ ┗ 📂usecases
 ┃ ┃ ┃ ┃ ┣ 📜fetch_all_game_reward_history_usecase.dart
 ┃ ┃ ┃ ┃ ┗ 📜update_game_reward_history_usecase.dart
 ┃ ┃ ┗ 📂presentation
 ┃ ┃ ┃ ┣ 📂bloc
 ┃ ┃ ┃ ┃ ┣ 📜game_rewards_bloc.dart
 ┃ ┃ ┃ ┃ ┣ 📜game_rewards_event.dart
 ┃ ┃ ┃ ┃ ┗ 📜game_rewards_state.dart
 ┃ ┃ ┃ ┣ 📂pages
 ┃ ┃ ┃ ┃ ┗ 📜game_reward_map_page.dart
 ┃ ┃ ┃ ┗ 📂widgets
 ┃ ┗ 📂game_session
 ┃ ┃ ┣ 📂data
 ┃ ┃ ┃ ┣ 📂datasources
 ┃ ┃ ┃ ┃ ┗ 📜game_local_data_source.dart
 ┃ ┃ ┃ ┣ 📂models
 ┃ ┃ ┃ ┃ ┗ 📜game_data_model.dart
 ┃ ┃ ┃ ┗ 📂repositories
 ┃ ┃ ┃ ┃ ┗ 📜game_data_repositroy_impl.dart
 ┃ ┃ ┣ 📂domain
 ┃ ┃ ┃ ┣ 📂entities
 ┃ ┃ ┃ ┃ ┗ 📜game_data_entity.dart
 ┃ ┃ ┃ ┣ 📂repositories
 ┃ ┃ ┃ ┃ ┗ 📜game_data_repository.dart
 ┃ ┃ ┃ ┗ 📂usecases
 ┃ ┃ ┃ ┃ ┣ 📜end_game_session_usecase.dart
 ┃ ┃ ┃ ┃ ┣ 📜get_last_game_session_usecase.dart
 ┃ ┃ ┃ ┃ ┗ 📜start_game_session_usecase.dart
 ┃ ┃ ┗ 📂presentation
 ┃ ┃ ┃ ┣ 📂cubit
 ┃ ┃ ┃ ┃ ┗ 📜game_session_cubit.dart
 ┃ ┃ ┃ ┣ 📂pages
 ┃ ┃ ┃ ┃ ┗ 📜game_play_session_screen.dart
 ┃ ┃ ┃ ┗ 📂widgets
 ┣ 📂service_locator
 ┃ ┗ 📜service_locator.dart
 ┣ 📂utils
 ┃ ┗ 📜usecase.dart
 ┗ 📜main.dart

...

#Architecture

Our app follows a Clean Architecture + BLoC pattern, which ensures scalability, testability, and separation of concerns.

Layers
Presentation :- Bloc/Cubit + Pages + Widgets
Data layer :- DataSources + Model + Repository 
Domain layer :- Entity + Repository + Usecase


#Game Rules 

1.Game Board
 - The board is a square grid (rowLength × rowLength), default size = 6×6 (36 cells).
 - Initially, only the first 4 rows are filled with random numbers (1–9).
  The remaining rows are empty (null).
 - Numbers can be added later by the player (via addNumbers).

2.Selecting Numbers

 - A player can select two cells at a time.
 - A cell is blocked if:
      - It has a number, and
      - It has not been matched already (not faded).
 - Only unblocked cells can be selected.

3. Matching Rules

  Two selected numbers match if:
   - They are neighbors (path clear between them):
       1. Same row → all cells between them must be empty/unmatched.
       2. Same column → all cells between them must be empty/unmatched.
       3. Same diagonal → all cells between them must be empty/unmatched.
   -  They satisfy number condition:
       1. Both numbers are equal, OR
       2. Their sum = 10.

   ✅ If matched
       -The indexes are added to matched (numbers fade).
       -Player’s score increases by 2 points.
       
   ❌ If invalid
        - The pair is added to invalidPair (for shake animation).
        - Selection is cleared.

4. Game Modes
   - Normal Mode: No timer.
   - Daily Challenge Mode:
      - Starts with a countdown (timeRemaining).
      - Timer decreases every second.
      - If timer hits 0 → game ends as failed.
      - If player’s score reaches the required score → game ends as completed.
    
5. Hints

      - Player can request a hint.
      - Game scans the board for any valid pair (neighbor + match rule)
      - The first available pair is highlighted (hintPair)
  
6. Adding Numbers
    - Player can add 12 random numbers (1–9) into the board
        - Fills empty cells first.
        - If still space left → adds a new row of empty slots at the bottom.
     
    - Each time addNumbers is used → the addRowUsed counter decreases.
  
7. Game Completion

    - Success (Daily Challenge):
       - Player’s score ≥ required score before time runs out.
       - A congratulation popup is shown, rewards updated.
     
    - Failure:
       - Timer runs out before completing required score.
       - Or player cannot make further valid matches

8. Persistence

   - Game state is saved/loaded using use cases (startGameSession, endGameSession, getLastGameSession).
   - If the last game was not finished  → it resumes.
        
     



