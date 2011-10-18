//
//  PlayLevelViewController.h
//  CookME
//
//  Created by Jarruspong Makkul on 10/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface PlayLevelViewController : CoreDataTableViewController {
    NSManagedObjectContext *managedObjectContext;
}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

-(id)initInManagedObjectContext:(NSManagedObjectContext*)context andLevel:(NSUInteger)level;

@end
