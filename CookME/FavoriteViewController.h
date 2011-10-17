//
//  FavoriteViewController.h
//  CookME
//
//  Created by Batt on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteViewController : UIViewController
{
    NSManagedObjectContext *managedObjectContext;
}
-(id)initInManagedObjectContext:(NSManagedObjectContext*)context;
@property (retain) NSManagedObjectContext *managedObjectContext;
@end
