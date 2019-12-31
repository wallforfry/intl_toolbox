# intl_toolbox

A useful toolbox for intl_translation package

## Dependencies

- Add `intl_translation` dependency to your application

## Example

An example is available [here](https://github.com/wallforfry/intl_toolbox/tree/master/example)
 
## Getting Started

This project is a toolbox for intl_translation package

To generate translation files :

`flutter pub pub run intl_toolbox:generate`


To add new strings edit `lib/res/string_resources.dart` file and call generate again


To add a new locale and create associated arb file :

`flutter pub pub run intl_toolbox:add_locale en_US`

You can find arb files in `lib/generated/l10n/arb/`
`intl_messages.arb` is the default arb file
`intl_LOCALE_CODE.arb` represent your translations.

Don't forget to call the generate command after arb files edition 