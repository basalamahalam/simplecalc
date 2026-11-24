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
- [ ] Build the release bundle: `flutter build appbundle --release`.
- [ ] Enable **Play App Signing** and upload the `.aab` through Play Console (do not reuse the debug-adjacent signing this repo verifies builds with — generate or use your own upload key per Play Console's instructions).

## 5. Closed testing (required for new personal developer accounts)
- [ ] Google requires new personal developer accounts to run a closed test with **at least 20 opted-in testers for 14 continuous days** before production access is granted. Set this up under Testing → Closed testing before expecting a production release.

## 6. Store listing assets
- [ ] App icon: 512×512 PNG (export a high-res render of the same glyph used in `assets/icon/icon.png`).
- [ ] Feature graphic: 1024×500.
- [ ] At least 2 phone screenshots (run the app and capture the calculator screen).
- [ ] Short description (≤ 80 characters).
- [ ] Full description (≤ 4000 characters).

## 7. Technical compliance (already satisfied by this repo — verify, don't redo)
- [ ] **Target API level**: Play currently requires a target API level of at least 35 (Android 15). This project ships with `targetSdk 36` (Android 16) — compliant, confirm it hasn't drifted before each release.
- [ ] **64-bit support**: satisfied by Flutter's default build (arm64-v8a + x86_64 included).
- [ ] **16 KB native-library page-size alignment**: satisfied by building with this Flutter version (3.41+); re-verify if you upgrade Flutter significantly before release.
- [ ] **App Bundle format**: upload the `.aab` from `flutter build appbundle --release`, not an `.apk`.
- [ ] **Permissions**: this app requests none — nothing to justify in the Play Console permissions declaration.

## 8. Submit
- [ ] Complete the remaining Play Console setup steps it prompts for, then submit for review.
