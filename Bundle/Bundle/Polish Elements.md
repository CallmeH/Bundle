#  Polish Elements

## Color scheme/font/kerning/spacing
### logo/icon
- Design icons as glyphs. A glyph, also known as a template image, is a monochromatic image with transparency, anti-aliasing, and no drop shadow that uses a mask to define its shape. [https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/custom-icons/]

## Lexicon
- keep it familiar, use system icons as intended [https://developer.apple.com/design/human-interface-guidelines/ios/icons-and-images/system-icons/], or design a new one


## Animation/gesture
- use existing nav bar elements or use gestures: to keep it familiar
- loading, success, failure, moving between pages/input, auto transition back with animation suggesting the action is being done, change shades on buttons/etc.

## Confirmation/notification
- after delete: undo floating window/bubble at the bottom

## Accessibility
- color blind color scheme
- alternative text labels for icons (not visible, but can be read by voice over)
- enable keyboard click sound (UIDevice.playInputClick)
- more info: [https://developer.apple.com/design/human-interface-guidelines/ios/app-architecture/accessibility/]

## Convenience:
- continue where you left off: Restore the previous state when your app restarts. Don't make people retrace steps to reach their previous location in your app. Preserve and restore your app’s state so they can continue where they left off. [https://developer.apple.com/design/human-interface-guidelines/ios/app-architecture/onboarding/]
