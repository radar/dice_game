<!-- Auto-generated guidance for AI coding agents working on the DiceGame Ruby gem -->
# DiceGame — AI assistant instructions

Keep guidance short and actionable. Focus on the small Ruby gem in this repository (lib/dice_game). Key patterns, workflows, and files are listed below so an agent can be productive quickly.

1. Project overview
- This is a small Ruby gem that models a dice-based game. Core logic lives in `lib/dice_game.rb` and the object types are under `lib/dice_game/` (Die, Game, Simulator, Sticker, Upgrades).
- The gem uses Zeitwerk for autoloading (see `lib/dice_game.rb` where `Zeitwerk::Loader.for_gem` is used and `loader.setup; loader.eager_load`). Keep file/class naming consistent with Zeitwerk expectations.

2. Big-picture architecture
- Single gem/library (no separate services). Responsibilities:
  - DiceGame: scoring rules and helpers (`lib/dice_game.rb`). Methods include `calculate`, `calculation_output`, helpers for pairs/triples/quads/etc.
  - Die: die representation, faces can include Sticker objects (`lib/dice_game/die.rb`). Use `Die.build` and `Die.random` when creating test/sample dice.
  - Sticker: two concrete sticker types live under `sticker/` (`Addition`, `Multiplier`), and `Sticker.build` parses sticker strings like "3x" or "+5`.
  - Game: interactive game loop and round/upgrade logic (`lib/dice_game/game.rb`). Read `TARGET_SCORES` and `add_upgrade` for upgrade behavior.
  - Upgrades: factory modules for generating dice or stickers (`lib/dice_game/upgrades`).

3. Naming & code patterns to follow
- Zeitwerk-compatible constants and file paths (e.g., `DiceGame::Sticker::Multiplier` in `lib/dice_game/sticker/multiplier.rb`).
- Stickers are objects (respond to `apply(score)`, `to_s`, `inspect`). When adding stickers to dice, the die stores sticker instances inside its `faces` array.
- Tests use RSpec (see `spec/`); follow existing spec style for examples and assertions.

4. Developer workflows (commands)
- Install and setup: `bin/setup` (installs dependencies via bundler). If missing or you need to repeat: `bundle install`.
- Run tests: `rake spec` or `bundle exec rake spec` (Rakefile defines an RSpec task). Running the single-file tests with RSpec is fine for targeted checks: `rspec spec/game_spec.rb`.
- Run interactive console: `bin/console` (allows manual exercise of classes).
- Packaging: `bundle exec rake install` and `bundle exec rake release` (see README for release steps).

5. Useful examples from repo (copy/paste friendly)
- Calculate score (core behavior): `DiceGame.new.calculate(1, 2, 3, 4, 5)` — uses numeric rolls and bonuses.
- Create a die with a sticker: `sticker = DiceGame::Sticker::Multiplier.new(value: 2); die = DiceGame::Die.new(faces: [1,2,3,4,5,sticker])`.
- Add an upgrade in `Game`: `game.add_upgrade(:add_die)` or `game.add_upgrade(:add_sticker)`.

6. Tests & expectations
- Unit tests in `spec/` are the canonical behavior source. When changing behavior, update or add specs.
- When writing new code, include 1-2 focused specs: happy path + one edge case (e.g., sticker interactions, straight detection). Use existing examples in `spec/dice_game_spec.rb`.

7. What not to change lightly
- Public scoring constants (PAIR_BONUS, TRIPLE_BONUS, etc.) in `lib/dice_game.rb` — many specs assume these values. If changing, run the full test suite.
- Zeitwerk loader setup and class/file names — renaming files or classes requires matching constants and paths.

8. Where to look first for context
- `lib/dice_game.rb` — scoring rules and helpers (start here to understand game logic).
- `lib/dice_game/die.rb` — how dice and stickers are represented.
- `lib/dice_game/game.rb` — interactive flow and upgrade logic.
- `spec/` — concrete usage and expected outputs.

9. Small heuristics for edits
- Prefer adding methods on existing classes over global helpers.
- Keep sticker behavior object-oriented: new sticker types should implement `apply(score)` and `to_s`.
- Avoid adding external dependencies unless strictly necessary; keep gem small and testable.

If anything in this file is unclear or missing, point to the exact file/line you want more detail about and I will expand the instructions.
