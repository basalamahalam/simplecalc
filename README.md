# SimpleCalc

A simple four-function calculator app built with Flutter, targeting Android.

- Standard arithmetic (`+`, `-`, `×`, `÷`), decimals, percent, backspace, and clear.
- Follows standard operator precedence (`×`/`÷` before `+`/`-`), e.g. `2+3×4` = `14`.
- No network access, no accounts, no ads, no analytics — nothing is collected. See [`PRIVACY_POLICY.md`](PRIVACY_POLICY.md).

## Running the app

```bash
flutter pub get
flutter run
```

## Running the tests

```bash
flutter test
```

## Building a release bundle

```bash
flutter build appbundle --release
```

Produces `build/app/outputs/bundle/release/app-release.aab`.

## Publishing to Google Play

Everything related to submitting this app to Google Play Console — the developer account, signing, store listing, and the current policy checklist — is covered in [`PLAY_STORE_CHECKLIST.md`](PLAY_STORE_CHECKLIST.md).
