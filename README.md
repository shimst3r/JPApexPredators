# JPApexPredators

JPApexPredators is the second project in the [iOS 18, SwiftUI 6, & Swift 6: Build iOS Apps From Scratch](https://www.udemy.com/course/ios-15-app-development-with-swiftui-3-and-swift-5/) course by Kenneth Jones.

It is a compendium of all apex predators in the Jurassic series movies.

The app builds upon the learnings from [LOTRConverter](https://github.com/shimst3r/LOTRConverter) and introduces better practices when it comes to separation of concerns.  For example, it introduces the view model from [the MVVM architecture pattern](https://en.wikipedia.org/wiki/Model–view–viewmodel), without calling it like that (the naming of `ApexPredatorViewModel` is mine).

In addition it adds

- how to handle JSON resources using `Bundle.main.url` and `JSONDecoder`,
- how to manipulate `Array` using `filter`, `search`, and `sort`,
- error handling using `do / catch` blocks,
- `Menu` and `Picker` controls

to my iOS arsenal. 🤓

## Exercises

- [x] Make dino image on detail view clickable to open a full screen version of the image.
- [ ] Add a location information view to the map when clicking the map.
- [x] Make dino list filtereable by movie of appearance.
- [ ] Make a dino deletable from the list.
