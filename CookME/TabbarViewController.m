//
//  TabbarViewController.m
//  CookME
//
//  Created by Batt on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TabbarViewController.h"

@implementation TabbarViewController
@synthesize managedObjectContext;

-(id)initInManagedObjectContext:(NSManagedObjectContext*)context
{
    self = [super init];
    if (self) {
        self.managedObjectContext = context;
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"wood.png"]];
    
    NSLog(@"load");    
    
    UITabBarItem *placeTab = [[UITabBarItem alloc] initWithTitle:@"Menus" image:[UIImage imageNamed:@"179-notepad.png"] tag:0];
    UITabBarItem *recentTab = [[UITabBarItem alloc] initWithTitle:@"Search" image:[UIImage imageNamed:@"06-magnify.png"] tag:1];
    UITabBarItem *favTab = [[UITabBarItem alloc] initWithTitle:@"Challenges" image:[UIImage imageNamed:@"140-gradhat.png"] tag:2];
    UITabBarItem *favTab2 = [[UITabBarItem alloc] initWithTitle:@"Favourites" image:[UIImage imageNamed:@"28-star.png"] tag:3];

    
    UINavigationController *menusNVC = [[UINavigationController alloc] init];
    UINavigationController *searchNVC = [[UINavigationController alloc] init];
    UINavigationController *gameNVC = [[UINavigationController alloc] init];
    UINavigationController *favoriteNVC = [[UINavigationController alloc] init];
    
    MenuViewController *menuTab = [[MenuViewController alloc] initInManagedObjectContext:self.managedObjectContext];
    menuTab.tabBarItem = placeTab;
    
    SearchViewController *searchTab = [[SearchViewController alloc] initInManagedObjectContext:self.managedObjectContext];
    searchTab.tabBarItem = recentTab;
    //searchTab.title = @"Search";
    
    GameViewController *gameTab = [[GameViewController alloc] initInManagedObjectContext:self.managedObjectContext];
    gameTab.tabBarItem = favTab;
    //gameTab.title = @"CookME";
    
    FavoriteViewController *favoriteTab = [[FavoriteViewController alloc] initInManagedObjectContext:self.managedObjectContext];
    favoriteTab.tabBarItem = favTab2;
    //favoriteTab.title = @"Favourite";
    
    [menusNVC pushViewController:menuTab animated:YES];
    [searchNVC pushViewController:searchTab animated:YES];
    [gameNVC pushViewController:gameTab animated:YES];
    [favoriteNVC pushViewController:favoriteTab animated:YES];

    self.viewControllers = [NSArray arrayWithObjects:menusNVC, searchNVC , gameNVC, favoriteNVC,nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
