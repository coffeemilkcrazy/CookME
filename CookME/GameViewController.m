//
//  GameViewController.m
//  CookME
//
//  Created by Batt on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"
#import "PlayLevelViewController.h"

@implementation GameViewController
@synthesize managedObjectContext;
@synthesize tableView;

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
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.title = @"Challenges";
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    titleName = [[NSMutableArray alloc] initWithObjects:@"", @"Newbie", @"Beginner", @"Assistant Cook", @"Chief", @"Professional",@"", nil];
    detailName = [[NSMutableArray alloc] initWithObjects:@"", @"", @"Cooked 3 Newbie to unlock", @"Cooked 3 Beginner to unlock", @"Cooked 3 Assistant Cook to unlock", @"Cooked 3 Chief to unlock", @"", nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    //}
    // Configure the cell...
    
    UILabel *nameItem = [[UILabel alloc] initWithFrame:CGRectMake(30, 0-8, 280, 30)];
    nameItem.text = [titleName objectAtIndex:indexPath.row];
    nameItem.font = [UIFont boldSystemFontOfSize:16.0];
    nameItem.backgroundColor = [UIColor clearColor];
    [cell addSubview:nameItem];
    
    UILabel *detailItem = [[UILabel alloc] initWithFrame:CGRectMake(30, 20-10, 280, 30)];
    detailItem.text = [detailName objectAtIndex:indexPath.row];
    detailItem.font = [UIFont systemFontOfSize:12.0];
    detailItem.textColor = [UIColor darkGrayColor];
    detailItem.backgroundColor = [UIColor clearColor];
    [cell addSubview:detailItem];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   // cell.textLabel.text = [titleName objectAtIndex:indexPath.row];
   // cell.detailTextLabel.text = [detailName objectAtIndex:indexPath.row];
    if (indexPath.row == 0)
        cell.contentView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"master-paper-header.png"]];
    else if (indexPath.row < 5)
        cell.contentView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"master-paper-middle.png"]];
    else
        cell.contentView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"master-paper-footer.png"]];
   
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    if (indexPath.row > 0 && indexPath.row < 6) {
        PlayLevelViewController *levelView = [[PlayLevelViewController alloc] initInManagedObjectContext:self.managedObjectContext andLevel:indexPath.row];
        levelView.title = [titleName objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:levelView animated:YES];
        [levelView release];
    }
}


@end
