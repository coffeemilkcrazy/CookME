//
//  TabbarViewController.m
//  CookME
//
//  Created by Batt on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TabbarViewController.h"


@interface TabbarViewController()
- (void)requestData:(NSString *)url;
- (void)grabData:(NSData *)data;

- (void)requestDetail:(NSString *)url;
- (void)grabDetail:(NSData *)data;


@end

@implementation TabbarViewController
@synthesize managedObjectContext;

-(id)initInManagedObjectContext:(NSManagedObjectContext*)context
{
    self = [super init];
    if (self) {
        self.managedObjectContext = context;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"]; 
        NSMutableDictionary *config = [NSMutableDictionary dictionaryWithContentsOfFile:path];
        urlHost = [[NSString alloc] initWithFormat:@"%@",[config objectForKey:@"Host"]];
//        NSLog(@"URL: %@",urlHost);
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
    NSManagedObjectContext *context = [[CookMEAppDelegate sharedAppDelegate] managedObjectContext];
    NSLog(@"load");    
    
    UITabBarItem *placeTab = [[UITabBarItem alloc] initWithTitle:@"Menus" image:[UIImage imageNamed:@"162-receipt.png"] tag:0];
    UITabBarItem *recentTab = [[UITabBarItem alloc] initWithTitle:@"Search" image:[UIImage imageNamed:@"06-magnify.png"] tag:1];
    UITabBarItem *favTab = [[UITabBarItem alloc] initWithTitle:@"Challenges" image:[UIImage imageNamed:@"140-gradhat.png"] tag:2];
    UITabBarItem *favTab2 = [[UITabBarItem alloc] initWithTitle:@"Favourites" image:[UIImage imageNamed:@"28-star.png"] tag:3];

    
    UINavigationController *menusNVC = [[UINavigationController alloc] init];
    UINavigationController *searchNVC = [[UINavigationController alloc] init];
    UINavigationController *gameNVC = [[UINavigationController alloc] init];
    UINavigationController *favoriteNVC = [[UINavigationController alloc] init];
    
    MenuViewController *menuTab = [[MenuViewController alloc] initInManagedObjectContext:context];
    menuTab.tabBarItem = placeTab;
    
    SearchViewController *searchTab = [[SearchViewController alloc] initInManagedObjectContext:context];
    searchTab.tabBarItem = recentTab;
    //searchTab.title = @"Search";
    
    GameViewController *gameTab = [[GameViewController alloc] initInManagedObjectContext:context];
    gameTab.tabBarItem = favTab;
    //gameTab.title = @"CookME";
    
    FavoriteViewController *favoriteTab = [[FavoriteViewController alloc] initInManagedObjectContext:context];
    favoriteTab.tabBarItem = favTab2;
    //favoriteTab.title = @"Favourite";
    
    [menusNVC pushViewController:menuTab animated:YES];
    [searchNVC pushViewController:searchTab animated:YES];
    [gameNVC pushViewController:gameTab animated:YES];
    [favoriteNVC pushViewController:favoriteTab animated:YES];

    self.viewControllers = [NSArray arrayWithObjects:menusNVC, searchNVC , gameNVC, favoriteNVC,nil];
}

- (void) viewWillAppear:(BOOL)animated
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"]; 
    NSMutableDictionary *config = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSString *Host = [NSString stringWithFormat:@"%@",[config objectForKey:@"Host"]];
    
    NSString *URL = [[NSString alloc] initWithFormat:@"%@/List.xml",Host];
    NSLog(@"URL List: %@",URL);
    
    [self requestData:URL];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark - ASI

- (void)requestData:(NSString *)url 
{
    NSLog(@"Request Data");
    ASIFormDataRequest *request = [[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]] autorelease];
    [request setValidatesSecureCertificate:NO];
    [request setDelegate:self];
    [request setTimeOutSeconds:60];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestFailed:)];
    
    [request start];
}
- (void)requestFailed:(ASIHTTPRequest *)request 
{
    NSLog(@"Request failed:\r%@",[[request error] localizedDescription]);
}

- (void)requestDone:(ASIHTTPRequest *)request 
{
    NSLog(@"Request Done");
	NSData *data = [request responseData];
    [self grabData:data];
}

- (void)grabData:(NSData *)data
{
    NSMutableArray *xml = [[NSMutableArray alloc] init];
	CXMLDocument *rssParser = [[[CXMLDocument alloc] initWithData:data options:0 error:nil] autorelease];
    NSArray *resultNodes = NULL;
	
    // Set the resultNodes Array to contain an object for every instance of an  node in our RSS feed
    resultNodes = [rssParser nodesForXPath:@"//item" error:nil];
	
    // Loop through the resultNodes to access each items actual data
    for (CXMLElement *resultElement in resultNodes) {
		NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        for(int counter = 0; counter < [resultElement childCount]; counter++) 
        {
            [item setObject:[[resultElement childAtIndex:counter] stringValue] forKey:[[resultElement childAtIndex:counter] name]];
        }
        [xml addObject:[item copy]];
        NSLog(@"item: %@",[item objectForKey:@"foodname"]);
        
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"Food" inManagedObjectContext:self.managedObjectContext ]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"foodname == %@",[item objectForKey:@"foodname"]]];
        [request setSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"foodname" ascending:NO]]];
        
        NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request 
                                                                              managedObjectContext:self.managedObjectContext 
                                                                                sectionNameKeyPath:nil 
                                                                                         cacheName:nil];
        
        NSError *error;
        [frc performFetch:&error];
        if ([[frc fetchedObjects] count] == 0) 
        {
            NSLog(@"NONE");
            NSString *url = [NSString stringWithFormat:@"%@%@",urlHost,[item objectForKey:@"detail"]];
//            NSLog(@"URL: %@",url);
            [self requestDetail:url];
//            [url release];

        }
        else
        {
            NSLog(@"HAVE DATA");
        }
    
        
    }
    
} 

- (void)requestDetail:(NSString *)url 
{
    NSLog(@"Request Data");
    ASIFormDataRequest *request = [[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]] autorelease];
    [request setValidatesSecureCertificate:NO];
    [request setDelegate:self];
    [request setTimeOutSeconds:60];
    [request setDidFinishSelector:@selector(requestDetailDone:)];
    [request setDidFailSelector:@selector(requestFailed:)];
    
    [request start];
}

- (void)requestDetailDone:(ASIHTTPRequest *)request 
{
    NSLog(@"Request Done");
	NSData *data = [request responseData];
    [self grabDetail:data];
}

- (void)grabDetail:(NSData *)data
{
    NSMutableArray *xml = [[NSMutableArray alloc] init];
	CXMLDocument *rssParser = [[[CXMLDocument alloc] initWithData:data options:0 error:nil] autorelease];
    NSArray *resultNodes = NULL;
	
    // Set the resultNodes Array to contain an object for every instance of an  node in our RSS feed
    resultNodes = [rssParser nodesForXPath:@"//item" error:nil];
	
    // Loop through the resultNodes to access each items actual data
    for (CXMLElement *resultElement in resultNodes) {
		NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        for(int counter = 0; counter < [resultElement childCount]; counter++) 
        {
            [item setObject:[[resultElement childAtIndex:counter] stringValue] forKey:[[resultElement childAtIndex:counter] name]];
        }
        [xml addObject:[item copy]];
//        NSLog(@"item: %@",[item objectForKey:@"foodname"]);
//        NSLog(@"item: %@",item);
        
        [Food addNewFood:item inManagedObjectContext:self.managedObjectContext];
        NSError *error;
        [self.managedObjectContext save:&error];
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
