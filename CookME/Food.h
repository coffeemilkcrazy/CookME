//
//  Food.h
//  CookME
//
//  Created by Batt on 10/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Food : NSManagedObject 
{
    
@private
}
+ (void) addNewFood:(id)foodDetai inManagedObjectContext:(NSManagedObjectContext *)context;

@property (nonatomic, retain) NSString * foodname;
@property (nonatomic, retain) NSString * howto;
@property (nonatomic, retain) NSString * ingredients;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) id picture;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * fav;
@property (nonatomic, retain) NSString * tag;

@end
