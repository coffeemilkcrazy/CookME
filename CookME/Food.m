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
    foodDetail.level = [NSNumber numberWithInt:[[foodDetai objectForKey:@"level"] intValue]];
    foodDetail.fav = [NSNumber numberWithBool:NO];
    foodDetail.ingredients = [foodDetai objectForKey:@"ingredients"];
    foodDetail.howto = [foodDetai objectForKey:@"howto"];
    foodDetail.tag  = [foodDetai objectForKey:@"tag"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"]; 
    NSMutableDictionary *config = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSString *Host = [NSString stringWithFormat:@"%@",[config objectForKey:@"Host"]];
    
    NSString *imageUrl = [[NSString alloc] initWithFormat:@"%@%@",Host,[foodDetai objectForKey:@"url"]];
    NSLog(@"URL: %@",imageUrl);
    dispatch_queue_t downloadQueue = dispatch_queue_create("Cover Image Downloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSData *imgeData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            foodDetail.picture = imgeData;
            NSLog(@"DONE");
        });
        //            [imgCover release];
    });
    dispatch_release(downloadQueue); 
}

@end
