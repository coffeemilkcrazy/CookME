//
//  Food.m
//  CookME
//
//  Created by Batt on 10/18/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Food.h"


@implementation Food
@dynamic foodname;
@dynamic howto;
@dynamic ingredients;
@dynamic level;
@dynamic picture;
@dynamic type;
@dynamic fav;
@dynamic tag;

+ (void) addNewFood:(id)foodDetai inManagedObjectContext:(NSManagedObjectContext *)context
{
    Food *foodDetail = [NSEntityDescription insertNewObjectForEntityForName:@"Food" 
                                                   inManagedObjectContext:context];	
    foodDetail.foodname = [foodDetai objectForKey:@"foodname"];
    foodDetail.type = [foodDetai objectForKey:@"type"];
    foodDetail.level = [NSNumber numberWithInt:[[foodDetai objectForKey:@"foodname"] intValue]];
    foodDetail.fav = [NSNumber numberWithBool:NO];
    foodDetail.ingredients = [foodDetai objectForKey:@"ingredients"];
    foodDetail.howto = [foodDetai objectForKey:@"howto"];
    foodDetail.tag  = [foodDetai objectForKey:@"tag"];


//    NSLog(@"FOOD DETAIL: %@",foodDetai);
}

@end
