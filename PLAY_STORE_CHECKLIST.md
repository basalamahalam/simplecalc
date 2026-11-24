# Play Console Submission Checklist for SimpleCalc

This is a manual checklist. Everything below has to be done by you, in your own Google Play Console account — none of it can be done from this repo, because it needs your developer account, your signing identity, and your judgment calls on store copy.

## 1. Developer account & app creation
- [ ] Have (or create) a Google Play Console developer account.
- [ ] Create a new app: name "SimpleCalc", default language, category **Tools** or **Productivity**, free app.

## 2. App content questionnaires
- [ ] **Data safety form** → declare "No data collected" (this app genuinely collects nothing — see `PRIVACY_POLICY.md`).
- [ ] **Content rating questionnaire** → answer "No" to violence, sexual content, gambling, user-generated content, etc. Expected result: **Everyone**.
- [ ] **Target audience and content** → select an appropriate age range; declare the app is **not** primarily designed for children (it has no child-specific design and makes no such claim).
- [ ] **Ads** → declare **No ads** (the app has none).
- [ ] **Government apps / Financial features / Health** → not applicable, answer accordingly.

## 3. Privacy policy
- [ ] Host `docs/privacy_policy.html` somewhere public (e.g. GitHub Pages, any static host) and put that URL in the Play Console "Privacy policy" field.

## 4. Build and sign
- [ ] Generate your own upload keystore (one time): `keytool -genkey -v -keystore ~/simplecalc-upload-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias simplecalc`.
- [ ] Create `android/key.properties` (this file is gitignored — never commit it) with:
  ```
  storePassword=<password you set above>
  keyPassword=<password you set above>
  keyAlias=simplecalc
  storeFile=/absolute/path/to/simplecalc-upload-key.jks
  ```
  Once this file exists, `android/app/build.gradle.kts` automatically signs release builds with it instead of the debug key.
- [ ] Build the release bundle: `flutter build appbundle --release`. (Without `key.properties`, this still succeeds but produces a debug-signed `.aab` — that's expected for local verification only and must never be uploaded to Play Console.)
- [ ] Enable **Play App Signing** in Play Console and upload the `.aab` signed with your own upload key from the step above.

## 5. Closed testing (required for new personal developer accounts)
- [ ] Google requires new personal developer accounts to run a closed test with **at least 20 opted-in testers for 14 continuous days** before production access is granted. Set this up under Testing → Closed testing before expecting a production release.

## 6. Store listing assets
- [ ] App icon: 512×512 PNG (export a high-res render of the same glyph used in `assets/icon/icon.png`).
- [ ] Feature graphic: 1024×500.
- [ ] At least 2 phone screenshots (run the app and capture the calculator screen).
- [ ] Short description (≤ 80 characters).
- [ ] Full description (≤ 4000 characters).

## 7. Technical compliance (already satisfied by this repo — verify, don't redo)
- [ ] **Target API level**: since August 31, 2026, Play requires *new* app submissions and updates to target API 36 (Android 16); apps already published only need API 35 (Android 15) to stay discoverable to users on newer devices. This project ships with `targetSdk 36` — compliant with the stricter new-app requirement already. Confirm it hasn't drifted before each release, and expect this floor to move again roughly a year after each future Android release.
- [ ] **64-bit support**: satisfied by Flutter's default build (arm64-v8a + x86_64 included).
- [ ] **16 KB native-library page-size alignment**: satisfied by building with this Flutter version (3.41+); re-verify if you upgrade Flutter significantly before release.
- [ ] **App Bundle format**: upload the `.aab` from `flutter build appbundle --release`, not an `.apk`.
- [ ] **Permissions**: this app requests none — nothing to justify in the Play Console permissions declaration.

## 8. Submit
- [ ] Complete the remaining Play Console setup steps it prompts for, then submit for review.
