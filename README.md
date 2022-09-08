### Description

This package provides drop-down items for selecting countries and states.

##### Features

- Select Country
- Select State per selected country

##### Parameters

| Param            | Required | Default |       Type        |                             Description                             |
| ---------------- | :------: | :-----: | :---------------: | :-----------------------------------------------------------------: |
| onCountryChanged |    ✅    |  null   | Function (String) |                      Handle Country Selection                       |
| onStateChanged   |    ✅    |  null   | Function (String) |                       Handle State Selection                        |
| onStateTap       |    ❌    |  null   |       void        |                      Handle Input onTap Event                       |
| onStateTap       |    ❌    |  null   |       void        |                      Handle Input onTap Event                       |
| flagSize         |    ❌    |  22.0   |      double       |                 Size of Country Flag on Input Label                 |
| listFlagSize     |    ❌    |  22.0   |      double       |                 Size of Country Flag on List Label                  |
| inputDecoration  |    ❌    |   --    |  InputDecoration  |                        Style for InputFields                        |
| hintTextStyle    |    ❌    |   --    |     TextStyle     |                    Style for Hint Text of Input                     |
| itemTextStyle    |    ❌    |   --    |     TextStyle     |                   Style for Text of DropdownItem                    |
| dropdownColor    |    ❌    |  Grey   |       Color       |                   Style for Text of DropdownItem                    |
| elevation        |    ❌    |    0    |        int        |                     Elevation of Dropdown List                      |
| isExpanded       |    ❌    |  true   |       bool        |         Determines if Input field should fill parent width          |
| divider          |    ❌    |   --    |      Widget       | Widget to create space or style between the country and state field |
| countryLabel     |    ❌    |   --    |      Widget       |                       Label for country field                       |
| stateLabel       |    ❌    |   --    |      Widget       |                        Label for state field                        |

### How To Use

1. Import the package
   ```
   import 'package:country_state_picker/models/country.dart';
   ```
2. Provide at least the required params

   ```
   CountryStatePicker(
     onCountryChanged: (ct) => setState(() {
         country = ct;
         state = null;
       }),
       onStateChanged: (st) => setState(() {
         state = st;
       }),
    ),

   ```

### Todo

- [x] Create Select Country
- [x] Create Select City
- [ ] Add Select City
- [ ] Add Variants to the widget
