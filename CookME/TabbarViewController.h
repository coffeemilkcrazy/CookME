//
//  TabbarViewController.h
//  CookME
//
//  Created by Batt on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"
#import "SearchViewController.h"
#import "GameViewController.h"
#import "FavoriteViewController.h"

#import "ASIFormDataRequest.h"
#import "TouchXML.h"

#import "Food.h"

#import "CookMEAppDelegate.h"
@interface TabbarViewController : UITabBarController
{
    NSString *urlHost;
}
@property (retain) NSManagedObjectContext *managedObjectContext;
-(id)initInManagedObjectContext:(NSManagedObjectContext*)context;

@end
