# Custom Settings

Local dev-environment tweaks that aren't part of vanilla Flutter/VS Code
defaults, and why each one exists.

## Mobile Workarounds

Context: hot reload doesn't work with my physical phone (traced to a firmware
bug on that phone model, not a Flutter/adb config issue). Workflow instead:
develop with hot reload on Linux desktop, then periodically `flutter build apk`
/ `flutter install` to check the real device.

### Linux desktop window defaults to phone portrait size

To make the Linux desktop window mirror a phone screen while developing UI
(same rendering engine/gesture model as Android, so it's a closer preview
than Chrome web), the default GTK window size was changed from the Flutter
template's `1280x720` desktop default to `412x915` (a common Android logical
portrait resolution).

**File changed:** `flutter_template/linux/runner/my_application.cc`

```cpp
// Before
gtk_window_set_default_size(window, 1280, 720);

// After
// Default to a phone-portrait aspect ratio (approx. Pixel logical size)
// so the desktop window mirrors a mobile screen during UI development.
gtk_window_set_default_size(window, 412, 915);
```

This only sets the *initial* window size on launch — the window is still
freely resizable afterwards.

#### How to undo

Revert the line in `my_application.cc` back to:

```cpp
gtk_window_set_default_size(window, 1280, 720);
```

Then rebuild: `flutter build linux` (or just `flutter run -d linux` again).

#### Caveat

Neither the Linux desktop window nor Chrome web perfectly replicates real
phone pixel density, safe-area/notch insets, or touch behavior. Always
confirm on-device (`flutter build apk`) before calling a screen done —
overflow/spacing issues on small screens tend to only show up there.

### Linux desktop app not hot reloading on save

Symptom: debug session running fine in VS Code, but saving `main.dart` does
nothing — no reload happens.

Cause: VS Code's Dart/Flutter extension does **not** hot reload on save by
default; you have to trigger it manually (debug toolbar lightning-bolt icon,
or its keybind) unless a setting is enabled. Confirmed the toolchain itself
was fine — `flutter run -d linux` + pressing `r` in the terminal reloaded
successfully.

**Fix:** added to `~/.config/Code/User/settings.json` (global, applies to
all projects):

```json
"dart.flutterHotReloadOnSave": "always"
```

#### How to undo

Remove that line from `~/.config/Code/User/settings.json`, or set it to
`"never"`. Saving will then require a manual reload again.

#### Follow-up: reload "succeeds" but nothing visually changes

After the setting above, VS Code did show a hot reload popup on save, but
edited text still didn't appear. Different cause this time — nothing to do
with VS Code or the toolchain. See [[../02 Fundementals/01 Flutter Functions|Flutter Functions]]
("Hot Reload" section): the widget tree was built directly inside `main()`,
which hot reload never re-runs, so the edit was never actually re-executed.
Fixed by moving the UI into a proper widget class with a `build()` method.

## Formatter: wrap lines more aggressively

Default `dart format` / VS Code format-on-save only wraps once a line
exceeds 80 columns, which often keeps things like `LinearGradient` color
lists or multi-property `TextStyle`s packed on one line. Prefer them broken
out one-per-line more often, closer to what shows up in a lot of tutorial
videos.

**Fix:** added to `analysis_options.yaml` (Dart 3.7+ reads a `formatter`
section here — respected by both the `dart format` CLI and VS Code's
format-on-save automatically, no extension setting needed):

```yaml
formatter:
  page_width: 60
```

Applied to `flutter_template/analysis_options.yaml` on 2026-09-05.

### How to undo

Remove the `formatter:` block from `analysis_options.yaml` (or set
`page_width: 80` to restore the default). Reload VS Code / restart the
Dart analysis server to pick up the change either way.

## Applying this to future projects: `flutter-create-mobile`

Vanilla `flutter create` has no support for custom user templates (checked
`flutter create --help` — `--template` only accepts the fixed built-in types:
app, module, package, plugin, etc.), so there's no official hook to make new
projects start with these patches automatically.

Instead, a wrapper script lives at `~/.local/bin/flutter-create-mobile`
(already on `PATH`). Use it exactly like `flutter create`:

```sh
flutter-create-mobile my_new_app
```

It runs `flutter create "$@"`, then patches the newly generated project:

- `linux/runner/my_application.cc` — `sed`-patches the default window size
  from `1280, 720` to `412, 915` (the mobile-portrait tweak above). Skipped
  with a note if the project has no Linux platform folder.
- `analysis_options.yaml` — inserts the `formatter: page_width: 60` block
  right after the `flutter_lints` include (the aggressive-wrapping tweak
  above). Skipped with a note if the file isn't found.

### How to undo (script)

Delete or stop using `~/.local/bin/flutter-create-mobile`, and use plain
`flutter create` instead. This doesn't affect any project already created —
only future invocations of the wrapper.
