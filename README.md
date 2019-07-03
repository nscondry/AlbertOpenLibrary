README

    Thank you for reviewing my solution to Albert's iOS Engineer Case Study.
    
    The solution contained in this swift project is intended to be run on either an iPhone or a simulator. I built and tested this tool on MacOS 10.14.3 and Swift 4.
    
REQUIREMENTS

    - iOS 11+
    - Swift 4+

INSTALLATION

    On MacOS:
    
        First, copy or download the repo from github at https://github.com/nscondry/AlbertOpenLibrary.
        
        Then, launch AlbertOpenLibraryAssignment.xcworkspace using Xcode, and run the project on either a simulator or an iPhone.


USAGE

    The app allows users to browse and search books on the Open Library catalog, and add selected books to their wishlist.
    
    The app launches on the browse tab, where users can explore a few of the most popular works from a number of different subjects. Selecting a work will present a more detailed view of the work, and offer users the option to save or remove the work from their wishlist.
    
    The browse tab contains a search icon, which can be selected to present a search view, where users can search the entire Open Library catalog by keyword, author, or title. The search box runs without the user having to click any buttons (once a query is entered), and search results can similarly be expanded into a detailed view.
    
    If a user chooses to add a book to their wishlist, they can view it by selecting the wishlist icon from the tab bar, navigating to the wishlist tab. The wishlist tab presents a simple list of selected books, and users can remove books from the wishlist as they choose. Wishlist books are persistent, and are stored in Core Data.
