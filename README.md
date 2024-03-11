# News_app

This is News App - build by Flutter (Bloc).
I have build an app for news-reader with a nice and user friendly UX/UI. Support translate to vietnamese upto now. Support multi-news-sources / languages. AI summaries news content with a text-to-speech button.

---

Features:

- Responsive App.
- Managing States. (Bloc)
- Fetching News. (NewsAPI)
- Translate to a specific language. (Google Translate API)
- Authentication, login, logout. (Firebase)
- Saving local data. (SharedPreference)
- Saving big local data. (Hive - in progress)

Technologies:

- Bloc - state management.
- Http - fetching data / translate content.
- Firebase - authentication, storage.
- Hive - saving local data.

---

Views:
There are 5 main screens:

Main Page:

- AppBar: with a Settings button and a Bookmarks button.
- Content View: showing News in types of list. (Tap to view detail).
- Floating Button:
  - Filter Button: showing current news filter. (Tap to navigate to filter page)
  - Go to top button.

Bookmarks Page:

- AppBar: Back_To_Main_Page Button.
- Content View: showing News in types of list. (Tap to view detail).

Settings Page:

- AppBar: Back_To_Main_Page Button.
- Information View with Login/ Logout button.
- Text Size with a picker-opener button : choosing text size.
- Darkmode with switcher: change the theme of app depends on Device's Theme.
- Expanded summary with switcher: auto expanded summary view in Detail Screen.
- Auto-translate with switcher: auto translate detail content to vietnamese.
- Languages with a picker-opener button : choosing a language for the app.

Detail Page:

- AppBar:
  - Back_To_Main_Page Button.
  - Share button.
  - Open News' link in browser.
  - Add to Bookmark Button.
  - Translate button.
- Content View: showing a thumbnail / AI Summary View / News Content.
- Button at the end of content view:
  - Back_To_Main_Page Button.
  - Share button.
  - Open News' link in browser.
- Floating button:
  - Audio button: content's text to speech.
  - To top button.

Filter Page:

- Search bar: searching for a category or page.
- by Categories / by Pages : showing selections for user to choose one for filtering the news' source.

---

Pics

<img src="demo_pics/simulator_screenshot_4B006BF1-6B12-4A83-8082-0065779C35A8.png" width="100"> <img src="demo_pics/simulator_screenshot_08C3080F-C63A-41D7-8A8F-072D27E4E1CF.png" width="100"> <img src="demo_pics/simulator_screenshot_9F7BCDE6-6552-4505-9A78-7A0C0285A955.png" width="100"> <img src="demo_pics/simulator_screenshot_31BA3281-1DB8-444A-BD0A-7886A4B75FD4.png" width="100"> <img src="demo_pics/simulator_screenshot_3707B493-E1A0-492B-84CE-D85BC2F6BF80.png" width="100"> <img src="demo_pics/simulator_screenshot_3926ED91-03B0-4BA9-B0BE-793F6AD04C32.png" width="100"> <img src="demo_pics/simulator_screenshot_AA0F2E31-1BB5-43FA-B254-E598CF32E07D.png" width="100"><img src="demo_pics/simulator_screenshot_3926ED91-03B0-4BA9-B0BE-793F6AD04C32.png" width="100"> <img src="demo_pics/simulator_screenshot_AC8BC2FC-4361-4D60-85DB-07729AE28E11.png" width="100"><img src="demo_pics/simulator_screenshot_CD030765-D890-46EB-9AA0-B3DE7C21C006.png" width="100"><img src="demo_pics/simulator_screenshot_D1FC5213-2170-4FAF-BC73-A8C9E8DEFFB9.png" width="100"><img src="demo_pics/simulator_screenshot_E27532B2-2492-4DB3-BBFF-E0E0CF42CAA6.png" width="100">
