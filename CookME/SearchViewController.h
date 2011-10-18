//
//  SearchViewController.h
//  CookME
//
//  Created by Batt on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
@interface SearchViewController : CoreDataTableViewController
{

}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

-(id)initInManagedObjectContext:(NSManagedObjectContext*)context;

@end
