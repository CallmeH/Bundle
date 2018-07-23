# Welcome to Bundle!

## Table of Contents

- [App Design](#app-design)
- [Objective](#objective)
- [Audience](#audience)
- [Experience](#experience)
- [Technical](#technical)
- [Screens](#Screens)
- [External services](#external-services)
- [Views, View Controllers, and other Classes](#Views-View-Controllers-and-other-Classes)
- [MVP Milestones](#mvp-milestones)
- [Week 3](#week-3)
- [Week 4](#week-4)
- [Week 5](#week-5)
- [Week 6](#week-6)

------

### App Design

#### Objective

Help organize daily trivial errands that are dependent on situations (e.g. time/the completion of something like coming back from work).

#### Audience

Everyone who generally has a regular daily routine and has non-regualr trivial things every day (e.g. remember to buy beef instead of pork today because a Muslin friend is coming) to take care of/keep track of.

#### Experience

May is a secretary at a big company. She is responsible for all the small errands her boss assigns her to, and these tasks sometimes requires her to go out to certain branches of the company. She is also single and lives in an apartment by herself. She needs to take care of a dog and a plant she has at home, as well as cook to feed herself every day.

When May launches the app, she will see a screen horizontally split into 2 colors. She wanted to add a new task her boss just gave her: bring the payment agreement document to Eastern branch and get it signed by the accountants there. She swipes right to add this task. The swipe will directly launch a new screen, on which the keyboard is automatically launched so May can start typing right away. If she would like to add an optional deadline for the task, she could do so with the "ddl" button on the top right. After she's done adding the task, May taps and holds the √ button bellow the input textfield. By swiping she continues the sentense "Get the payment agreement signed" with an indication of time ()"left = before I, right = after I, down = when I, up = no preference"). This action takes her to the next page, where she can choose exactly what the occasion is. May chooses the bubble of text she had customized before saying "go to Eastern branch".

Or, May can choose to check-in. When May is about to depart the Central office to Eastern branch, she launches the app and swipes left and sees a new screen with "I'm about to…". She can also swipe left again to change the screen to "I just finished…" but she doesn't want to do that now. May then taps the bubble saying "go to Eastern branch" to check-in, and the app takes her to a list of all the things she'd scheduled to do/remind herself before this event with the heading "choose the ones you would like to put in this bundle". There are indeed some tasks she cannot do right now. So May taps/slides/swipes to select the ones she would like to finish in this "run" and taps on the green √ in the bottom right corner to finish bundling. The app will now display a checklist of todos May chose for this "run" with a editable bundle title & a bundle icon. She can now either mark a todo as complete or use the arrow after a todo to "throw it back into the pile". She can also use the + button on the bottom of the page to add another todo from all todos for this trigger event again. She can abandon (bottom left) or complete (bottom right) the bundle after checking all todos and finishing naming the bundle. The bundle will exit (animated) and is now stored both in today's date's tag and the trigger events tag.

On the main page, a user can also see all todos to change trigger event, and review finished bundles in a chronological order.

[Back to top ^](#)

------

### Technical

#### Screens

- [list the different screens used in the app]
- see flowchart

#### External services

- [list which APIs or external services will your app use?]
- Coredata/Realm—basic features only require offline data persistence, could think about having user accounts later [need advice on how to build a transferrable data structure]
- iOS push notifications + alarm? (not sure if these count as external service)
- *additional feature: linking iOS calendar

#### Views, View Controllers, and other Classes (? naming…?)

probably will update later

- Views
- check & quit round icons
- event selection collection view
- TodoChoice: tableview <with delete function>
- Bundle: tableview with checkbox + putback buttons
- View Controllers
- LaunchScreenViewController
- <Add flow>
- InputTodoViewController
- AssignToEventViewController
- <Checkin flow>
- CheckinViewController
- TodoChoiceViewController
- <bundle window>
- BundleViewController
- <review flow>
- <view all flow>
- Other Classes
- [list any other classes you will need]

#### Data models

- event
- before(true)/after(false)—preposition: Bool
- what the event is (text)—eventName: String
- todo
- corresponding event—eventName: String
- corresponding bundle—bundleName: String?
- completed—status: Bool
- bundle
- title—bundleName: String?
- corresponding event (=corresponding event of the bigger todo list this bundle is selected from)—eventName: String
- completed—status: Bool
- completion time—completionTime: String <converted from Date(), see Notes app tutorial>

[Back to top ^](#)

------

### MVP Milestones

[The overall milestones of first usable build, core features, and polish are just suggestions, plan to finish earlier if possible. The last 20% of work tends to take about as much time as the first 80% so do not slack off on your milestones!]

_If there's anything I could not finished within the week, I'll try to catch up during weekends._

#### Week 4

_adjust scope, finalize design, add&check core features complete_

- Monday: determine scope√, finalize view controller flowchart(s)√ + pseudocode, <paper prototyping + test it out on some classmates>, initial color scheme choice, main page(1) + hard-code triggers. *review Coredata/Realm, code buttons for now
- Tuesday: "add" flow
- Wednesday: "check" flow
- Thursday: debugging! + finer animation
- Friday: user testing—fixing potential loopholes in the logic flow + make the interactions more intuitive
- *weekends: animations + review&all view controller flowchart(s)

#### Week 5

_features: 1) all todos+change trigger, 2) review bundles, *3) some setting_

- Monday: "review bundles" flow
- Tuesday: "all scheduled" page + drag&change/tap&change trigger event
- Wednesday: continue… + debugging
- Thursday: partial setting—manage trigger events + user testing
- Friday: revision based on user testing data
- *weekends: finalize UI design (color scheme/gesture meanings/etc.) at least on paper, catch & fix bugsssssss, change buttons to gesture control

#### Week 6

_bug fix, polish UI/UX, settings page, submitting to the App Store_

- Monday: settings page + polish UI
- Tuesday: debugging + app description/user guide/screenshots
- Wednesday: Submit to App Store + recruit user testers from school and get them to download the app & give feedback!
- Thursday: minor revision, gather feedback, start polish accordingly
- Friday: polish & release another polished version to App Store (include "what next")
- SATURDAY: Demo time :)

#### additional features

- choose trigger event from iOS calendar
- iCloud sync data & preference
- reusable routines…?
- having accounts…?
- adding more than just words…?

[Back to top ^](#)
