# SSToolkit Changelog

### Version 0.1.2

*Unreleased*

* Add `rowBackgroundColor` to SSCollectionView. This is useful for having a texture background color on the collection view and preventing the internal UITableView from using it as the background color of each row.
* Add `NSAssert` in SSCollectionView for a `nil` `reuseIdentifier`. This used to be an `NSLog`. It was changed to an assert because you really need to provide one or your performance will be just awful. Be user to add `NS_BLOCK_ASSERTIONS` in your release build to avoid crashing just incase you missed one somewhere.
* Add `deepMutableCopy` to `NSDictionary` and `NSArray`

### Version 0.1.2

[Released October 31, 2011](https://github.com/samsoffes/sstoolkit/tree/0.1.2)

* Fix bug in HUD view not dismissing
* Fix leak in collection view
* Move SSCollection view to it's own repo


### Version 0.1.1

[Released October 18, 2011](https://github.com/samsoffes/sstoolkit/tree/0.1.1)

* Added `SSCollectionViewItemAnimation` to SSCollectionView

* Added basic tests

* Documented SSCollectionViewDataSource

* Documented SSCollectionViewDelegate

* Added `- (NSArray *)visibleItems` to SSCollectionView

* Added `- (NSArray *)indexPathsForVisibleRows` to SSCollectionView

* Added begin/end updates to SSCollection with the following methods:    

        - (void)beginUpdates;
        - (void)endUpdates;
        - (void)insertItemsAtIndexPaths:(NSArray *)indexPaths withItemAnimation:(SSCollectionViewItemAnimation)animation;
        - (void)deleteItemsAtIndexPaths:(NSArray *)indexPaths withItemAnimation:(SSCollectionViewItemAnimation)animation;
        - (void)insertSections:(NSIndexSet *)sections withItemAnimation:(SSCollectionViewItemAnimation)animation;
        - (void)deleteSections:(NSIndexSet *)sections withItemAnimation:(SSCollectionViewItemAnimation)animation;

### Version 0.1.0

[Released October 17, 2011](https://github.com/samsoffes/sstoolkit/tree/0.1.0)

* Initial release
