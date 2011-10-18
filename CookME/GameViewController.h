//
//  GameViewController.h
//  CookME
//
//  Created by Batt on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    IBOutlet UITableView *tableView;
    NSMutableArray *titleName;
    NSMutableArray *detailName;
}
-(id)initInManagedObjectContext:(NSManagedObjectContext*)context;
@property (retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@end
