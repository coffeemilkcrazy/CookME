//
//  SearchViewController.h
//  CookME
//
//  Created by Batt on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tableView;
    NSManagedObjectContext *managedObjectContext;
 
    NSPredicate *normalPredicate;
	NSString *currentSearchText;
	NSString *titleKey;
	NSString *subtitleKey;
	NSString *searchKey;
	NSFetchedResultsController *fetchedResultsController;
}
-(id)initInManagedObjectContext:(NSManagedObjectContext*)context;
@property (retain) NSManagedObjectContext *managedObjectContext;
@property (retain) UITableView *tableView;


@property (retain) NSFetchedResultsController *fetchedResultsController;

// key to use when displaying items in the table; defaults to the first sortDescriptor's key
@property (copy) NSString *titleKey;
// key to use when displaying items in the table for the subtitle; defaults to nil
@property (copy) NSString *subtitleKey;
// key to use when searching the table (should usually be the same as displayKey); if nil, no searching allowed
@property (copy) NSString *searchKey;

@end
