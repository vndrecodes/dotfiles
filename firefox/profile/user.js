//   prefs.js
// This file stores customized user preference settings,
// such as changes you make in Firefox Settings dialogs.
// The optional user.js file, if one exists, will override
// any modified preferences.

// Picked from: https://github.com/arkenfox/user.js/blob/master/user.js
// On firefox startup:
//   It reads the ACTIVE prefs in user.js, in order, and writes them to prefs.js
//   If a pref already exists in prefs.js, it overwrites it


/* 0102: set startup page [SETUP-CHROME]
 * 0=blank, 1=home, 2=last visited page, 3=resume previous session
 * [NOTE] Session Restore is cleared with history (2811, 2812), and not used in Private Browsing mode
 * [SETTING] General>Startup>Restore previous session ***/
user_pref("browser.startup.page", 1);
/* 0103: set HOME+NEWWINDOW page
 * about:home=Activity Stream (default, see 0105), custom URL, about:blank
 * [SETTING] Home>New Windows and Tabs>Homepage and new windows ***/
user_pref("browser.startup.homepage", "https://duckduckgo.com/?kae=d&k1=-1&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kau=-1&k18=1&kl=at-de");



/** SANITIZE ON SHUTDOWN : ALL OR NOTHING ***/
/* 2810: enable Firefox to clear items on shutdown (2811)
 * [SETTING] Privacy & Security>History>Custom Settings>Clear history when Firefox closes ***/
user_pref("privacy.sanitize.sanitizeOnShutdown", true);
/* 2811: set/enforce what items to clear on shutdown (if 2810 is true) [SETUP-CHROME]
 * These items do not use exceptions, it is all or nothing (1681701)
 * [NOTE] If "history" is true, downloads will also be cleared
 * [NOTE] "sessions": Active Logins: refers to HTTP Basic Authentication [1], not logins via cookies
 * [NOTE] "offlineApps": Offline Website Data: localStorage, service worker cache, QuotaManager (IndexedDB, asm-cache)
 * [SETTING] Privacy & Security>History>Custom Settings>Clear history when Firefox closes>Settings
 * [1] https://en.wikipedia.org/wiki/Basic_access_authentication ***/
user_pref("privacy.clearOnShutdown.cache", true);     // [DEFAULT: true]
user_pref("privacy.clearOnShutdown.downloads", true); // [DEFAULT: true]
user_pref("privacy.clearOnShutdown.formdata", true);  // [DEFAULT: true]
user_pref("privacy.clearOnShutdown.history", false);   // [DEFAULT: true]
user_pref("privacy.clearOnShutdown.sessions", false);  // [DEFAULT: true]
user_pref("privacy.clearOnShutdown.offlineApps", true); // [DEFAULT: false]
user_pref("privacy.clearOnShutdown.cookies", false);
user_pref("privacy.clearOnShutdown.siteSettings", true); // [DEFAULT: false]

user_pref("browser.download.autohideButton", true);
user_pref("accessibility.typeaheadfind", true); // enable "Find As You Type"
user_pref("browser.backspace_action", 0); // 0=previous page, 1=scroll up, 2=do nothing
user_pref("browser.quitShortcut.disabled", false); // disable Ctrl-Q quit shortcut [LINUX] [MAC] [FF87+]
// user_pref("browser.tabs.closeWindowWithLastTab", false); -> prefs.js
user_pref("browser.tabs.loadBookmarksInTabs", true); // open bookmarks in a new tab [FF57+]
user_pref("browser.tabs.loadBookmarksInBackground", true);
user_pref("browser.tabs.inTitlebar", 1);
user_pref("browser.urlbar.decodeURLsOnCopy", true); // see bugzilla 1320061 [FF53+]
user_pref("browser.bookmarks.openInTabClosesMenu", false); // keep bookmarks dialog open when opening a bookmark
// user_pref("browser.tabs.closeWindowWithLastTab", false); // -> prefs.js
user_pref("layout.word_select.eat_space_to_next_word", false); // select word without trailing spaces

user_pref("browser.toolbars.bookmarks.visibility", "always"); // see bugzilla 1320061 [FF53+]
user_pref("browser.urlbar.groupLabels.enabled", false);
user_pref("browser.urlbar.quicksuggest.scenario", "history");
user_pref("browser.urlbar.maxRichResults", 24);
// user_pref("browser.uiCustomization.state", "{"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","save-to-pocket-button","downloads-button","private-relay_firefox_com-browser-action","notes_mozilla_com-browser-action","_testpilot-containers-browser-action","developer-button","preferences-button","fxa-toolbar-menu-button"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["developer-button","private-relay_firefox_com-browser-action","notes_mozilla_com-browser-action","_testpilot-containers-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","TabsToolbar"],"currentVersion":17,"newElementCount":5}");


user_pref("browser.search.region", "AT"); // see bugzilla 1320061 [FF53+]


// Disable telemetry
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.ping-centre.telemetry", false);

// Disable pocket
user_pref("browser.newtabpage.activity-stream.feeds.discoverystreamfeed", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);

// Disable js in pdf
user_pref("pdfjs.enableScripting", false);

// Disable geo
user_pref("geo.enabled", false);
