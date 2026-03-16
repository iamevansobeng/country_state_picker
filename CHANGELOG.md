## 0.1.2

- DOCS: added dartdoc comments across public API (widgets, models, and helpers)
- FIX: replaced deprecated `DropdownButtonFormField.value` with `initialValue`

## 0.1.1

- DOCS: removed internal screenshot note from README
- DOCS: switched screenshot links to absolute GitHub raw URLs for reliable pub.dev rendering
- META: improved package description wording in `pubspec.yaml`

## 0.1.0

- NEW: `initialCountry` — pre-select a country by name or ISO2 code on mount
- NEW: `initialState` — pre-select a state by name or state code (requires `initialCountry`)
- NEW: `showStateField` — hide the state dropdown for country-only pickers
- NEW: `enabled` — make both dropdowns read-only (e.g. review screens)
- NEW: `countryFilter` — restrict the country list to a subset by name or ISO2 code
- PERF: JSON asset is now decoded once per session (static cache) instead of on every mount
- FIX: deprecated `Color.withOpacity` replaced with `withValues(alpha:)`
- EXAMPLES: split into separate files; added Pre-selected, Country Only, and Filtered (G7 / BRICS / ECOWAS) tabs

## 0.0.1

- TODO: Describe initial release.

## 0.0.2

- ADDED InputDecoration as Param

## 0.0.3

- ADDED COMMENTS AND COMPLETE DOCUMENTATION

## 0.0.6

- FIX: Reset state dropdown when country changes to prevent null value error

## 0.0.5

- HINT TEXT FOR COUNTRY AND STATE (👋 @julianasalafia )
- Validation for Country and State
