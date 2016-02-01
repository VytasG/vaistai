//
//  GroupeViewController.m
//  vaistai.lt
//
//  Created by hitt on 12/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GroupViewController.h"
#import "DrugListViewController.h"
#import "vaistai_ltAppDelegate.h"
#import "Group.h"
#import <dispatch/dispatch.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation GroupViewController

@synthesize lgroups, myTableView, toolbar, activityIndicator, loadingText;

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.toolbar.alpha = 0.0;
	self.loadingText.alpha = 0.0;

	appDelegate = (vaistai_ltAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
	self.myTableView.backgroundColor  = [UIColor clearColor];
	self.myTableView.separatorColor = UIColorFromRGB(0xA5C51E);
	self.myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	//self.title = @"Vaistų grupės";
	
	//[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_top.png"]];
	
	UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
	myButton.frame = CGRectMake(20, 20, 55, 30); // position in the parent view and set the size of the button
	[myButton setBackgroundImage:[UIImage imageNamed:@"bt_atgal.png"] forState:UIControlStateNormal];
	[myButton addTarget:appDelegate action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:myButton];
	self.navigationItem.leftBarButtonItem = backButton;
	self.navigationItem.hidesBackButton = YES;
	
	UILabel *lbl=[[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 184, 45)] autorelease];
	lbl.backgroundColor=[UIColor clearColor]; 
	lbl.font = [UIFont fontWithName:@"Arial" size:18]; 
	lbl.font = [UIFont boldSystemFontOfSize:18];
	lbl.textColor = UIColorFromRGB(0xA5C51E);
	lbl.textAlignment=UITextAlignmentCenter; 
	lbl.text=@"Vaistai";
	self.navigationItem.titleView = lbl;
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.myTableView reloadData];
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	self.navigationController.navigationBar.translucent = NO;
	
	NSLog(@"Dedam back paveikslėlį");
	//[backButton release];
	//[myButton release];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	return self.lgroups.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.opaque = NO;

    }
	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.backgroundColor = [UIColor whiteColor];
	cell.textLabel.textColor = UIColorFromRGB(0x3D7DAE);
	cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
	//[cell setText:[[self.drugs objectAtIndex:index] name]];	
	
	
	UIImage *image = [UIImage   imageNamed:@"rodykle.png"];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
	button.frame = frame;
	[button setBackgroundImage:image forState:UIControlStateNormal];
	
	[button addTarget:self action:@selector(checkButtonTapped:event:)  forControlEvents:UIControlEventTouchUpInside];
	button.backgroundColor = [UIColor clearColor];
	cell.accessoryView = button;
	
	
	int row = indexPath.row;
    Group *grp = (Group *)[self.lgroups objectAtIndex:row];
	cell.textLabel.text = grp.alias;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int row = indexPath.row;
	if(childController == nil)
		childController = [[GroupViewController alloc] initWithNibName:@"GroupViewController" bundle:nil];
	Group *selectedGroup = [self.lgroups objectAtIndex:row];
	NSString *ttl = selectedGroup.name;
	NSMutableArray *arr = [appDelegate.groups getGroups:ttl];
	
	/*UIBarButtonItem *bb = [[UIBarButtonItem alloc] 
						   initWithTitle:@"Atgal" style:UIBarButtonItemStylePlain target:nil 
						   action:nil];
	[self.navigationItem setBackBarButtonItem:bb];*/
	
	if(arr.count > 0) 
	{
		childController.lgroups = arr;
		[appDelegate.navigationController pushViewController:childController animated:TRUE];
	}
	else 
	{
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.5];
		[self.activityIndicator startAnimating];
		self.toolbar.alpha = 1.0;
		self.loadingText.alpha = 1.0;
		[UIView commitAnimations];
		
		if(drugController == nil)
			drugController = [[DrugListViewController alloc] init];
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ 
					   {
						   drugController.drugs = [appDelegate.service searchForDrugsByGroup:ttl];
						   dispatch_async(dispatch_get_main_queue(), ^
										  {
											  [UIView beginAnimations:nil context:nil];
											  [UIView setAnimationDuration:0.5];
											  [self.activityIndicator stopAnimating];
											  self.toolbar.alpha = 0.0;
											  self.loadingText.alpha = 0.0;
											  [UIView commitAnimations];
											  [drugController.tableView reloadData];
											  [appDelegate.navigationController pushViewController:drugController animated:TRUE];
										  });
					   });
	}
	[tableView deselectRowAtIndexPath:indexPath animated:TRUE];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[myTableView release];
	[toolbar release];
	[activityIndicator release];
	[loadingText release];
    [super dealloc];
}


@end

