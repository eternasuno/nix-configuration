import QtQuick
import QtQuick.Controls
import Quickshell
import qs.Common
import qs.Services
import qs.Widgets

Item {
    id: root

    // Public interface
    property string searchQuery: ""
    property string selectedCategory: "All"
    property string viewMode: "list" // "list" or "grid"
    property int selectedIndex: 0
    property int maxResults: 50
    property int gridColumns: 4
    property bool debounceSearch: true
    property int debounceInterval: 50
    property bool keyboardNavigationActive: false
    // Categories (computed from AppSearchService)
    property var categories: {
        var allCategories = AppSearchService.getAllCategories().filter((cat) => {
            return cat !== "Education" && cat !== "Science";
        });
        var result = ["All"];
        return result.concat(allCategories.filter((cat) => {
            return cat !== "All";
        }));
    }
    // Category icons (computed from AppSearchService)
    property var categoryIcons: categories.map((category) => {
        return AppSearchService.getCategoryIcon(category);
    })
    // App usage ranking helper
    property var appUsageRanking: Prefs.appUsageRanking
    // Internal model
    property alias model: filteredModel
    // Watch AppSearchService.applications changes via property binding
    property var _watchApplications: AppSearchService.applications

    // Signals
    signal appLaunched(var app)
    signal categorySelected(string category)
    signal viewModeSelected(string mode)

    function updateFilteredModel() {
        filteredModel.clear();
        selectedIndex = 0;
        keyboardNavigationActive = false;
        var apps = [];
        if (searchQuery.length === 0) {
            // Show apps from category
            if (selectedCategory === "All") {
                apps = AppSearchService.applications || [];
            } else {
                var categoryApps = AppSearchService.getAppsInCategory(selectedCategory);
                apps = categoryApps.slice(0, maxResults);
            }
        } else {
            // Search with category filter
            if (selectedCategory === "All") {
                apps = AppSearchService.searchApplications(searchQuery);
            } else {
                var categoryApps = AppSearchService.getAppsInCategory(selectedCategory);
                if (categoryApps.length > 0) {
                    var allSearchResults = AppSearchService.searchApplications(searchQuery);
                    var categoryNames = new Set(categoryApps.map((app) => {
                        return app.name;
                    }));
                    apps = allSearchResults.filter((searchApp) => {
                        return categoryNames.has(searchApp.name);
                    }).slice(0, maxResults);
                } else {
                    apps = [];
                }
            }
        }
        if (searchQuery.length === 0)
            apps = apps.sort(function(a, b) {
                var aId = a.id || (a.execString || a.exec || "");
                var bId = b.id || (b.execString || b.exec || "");
                var aUsage = appUsageRanking[aId] ? appUsageRanking[aId].usageCount : 0;
                var bUsage = appUsageRanking[bId] ? appUsageRanking[bId].usageCount : 0;
                if (aUsage !== bUsage)
                    return bUsage - aUsage;

                return (a.name || "").localeCompare(b.name || "");
            });

        // Convert to model format and populate
        apps.forEach((app) => {
            if (app)
                filteredModel.append({
                "name": app.name || "",
                "exec": app.execString || "",
                "icon": app.icon || "application-x-executable",
                "comment": app.comment || "",
                "categories": app.categories || [],
                "desktopEntry": app
            });

        });
    }

    // Keyboard navigation functions
    function selectNext() {
        if (filteredModel.count > 0) {
            keyboardNavigationActive = true;
            if (viewMode === "grid") {
                var newIndex = Math.min(selectedIndex + gridColumns, filteredModel.count - 1);
                selectedIndex = newIndex;
            } else {
                selectedIndex = (selectedIndex + 1) % filteredModel.count;
            }
        }
    }

    function selectPrevious() {
        if (filteredModel.count > 0) {
            keyboardNavigationActive = true;
            if (viewMode === "grid") {
                var newIndex = Math.max(selectedIndex - gridColumns, 0);
                selectedIndex = newIndex;
            } else {
                selectedIndex = selectedIndex > 0 ? selectedIndex - 1 : filteredModel.count - 1;
            }
        }
    }

    function selectNextInRow() {
        if (filteredModel.count > 0 && viewMode === "grid") {
            keyboardNavigationActive = true;
            selectedIndex = Math.min(selectedIndex + 1, filteredModel.count - 1);
        }
    }

    function selectPreviousInRow() {
        if (filteredModel.count > 0 && viewMode === "grid") {
            keyboardNavigationActive = true;
            selectedIndex = Math.max(selectedIndex - 1, 0);
        }
    }

    // App launching
    function launchSelected() {
        if (filteredModel.count > 0 && selectedIndex >= 0 && selectedIndex < filteredModel.count) {
            var selectedApp = filteredModel.get(selectedIndex);
            launchApp(selectedApp);
        }
    }

    function launchApp(appData) {
        if (!appData) {
            console.warn("AppLauncher: No app data provided");
            return ;
        }
        appData.desktopEntry.execute();
        appLaunched(appData);
        Prefs.addAppUsage(appData.desktopEntry);
    }

    // Category management
    function setCategory(category) {
        selectedCategory = category;
        categorySelected(category);
    }

    // View mode management
    function setViewMode(mode) {
        viewMode = mode;
        viewModeSelected(mode);
    }

    // Watch for changes
    onSearchQueryChanged: {
        if (debounceSearch)
            searchDebounceTimer.restart();
        else
            updateFilteredModel();
    }
    onSelectedCategoryChanged: updateFilteredModel()
    onAppUsageRankingChanged: updateFilteredModel()
    on_WatchApplicationsChanged: updateFilteredModel()
    // Initialize
    Component.onCompleted: {
        updateFilteredModel();
    }

    ListModel {
        id: filteredModel
    }

    // Search debouncing
    Timer {
        id: searchDebounceTimer

        interval: root.debounceInterval
        repeat: false
        onTriggered: updateFilteredModel()
    }

}
