//
//  DrugListViewController.m
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DrugListViewController.h"
#import "vaistai_ltAppDelegate.h"
#import "DrugService.h"
#import "DrugViewController.h"
#import <dispatch/dispatch.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation DrugListViewController

@synthesize drugs,tableView,searchBar,timer, mySearchText, activityIndicator;

-(IBAction) grab {
	NSLog(@"grabed: %@",[appDelegate.service searchForDrugsByName:@"validol"]);
	NSLog(@"a");
}
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[searchBar resignFirstResponder];
	
	//[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_top.png"]];
	
	//[backButton release];
	//[myButton release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self.navigationController setNavigationBarHidden:NO animated:NO];
	
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
	self.tableView.backgroundColor  = [UIColor clearColor];
	self.tableView.separatorColor = UIColorFromRGB(0xA5C51E);
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

	[[self.searchBar.subviews objectAtIndex:0] removeFromSuperview];
	[self.searchBar becomeFirstResponder];
	
	appDelegate = (vaistai_ltAppDelegate *)[[UIApplication sharedApplication] delegate];
	
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
	lbl.text= @"Vaistai";
	self.navigationItem.titleView = lbl;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
	
	NSUInteger index = [indexPath row];
	UIBarButtonItem *bb = [[UIBarButtonItem alloc] 
						   initWithTitle:@"Atgal" style:UIBarButtonItemStyleDone target:nil 
						   action:nil];
	[self.navigationItem setBackBarButtonItem:bb];
	
	DrugViewController * drugView = [[DrugViewController alloc] init];
	drugView.drug = [self.drugs objectAtIndex:index];
	[self.searchBar resignFirstResponder];

	[self.navigationController pushViewController:drugView animated:YES];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	
	NSUInteger index = [indexPath row];
	
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero 
									   reuseIdentifier:CellIdentifier] autorelease];
		cell.opaque = NO;
	}
	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.backgroundColor = [UIColor whiteColor];
	cell.textLabel.textColor = UIColorFromRGB(0x3D7DAE);
	cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
	cell.text = [[self.drugs objectAtIndex:index] name];	
	
	cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"rating%d.png",[[[self.drugs objectAtIndex:index] rating] intValue]]];
	
	
	UIImage *image = [UIImage   imageNamed:@"rodykle.png"];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
	button.frame = frame;
	[button setBackgroundImage:image forState:UIControlStateNormal];
	
	[button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
	button.backgroundColor = [UIColor clearColor];
	cell.accessoryView = button;

    return cell;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//self.drugs = [appDelegate.service searchForDrugsByName:@"validol"];
	return [self.drugs count];	
	
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}


// SEARCH BAR VALDYMAS

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
	[self doneSearching_Clicked:nil];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
	[self doneSearching_Clicked:nil];	
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[self doneSearching_Clicked:nil];
}

-(void) doneSearching_Clicked:(id)sender {
	[self.searchBar resignFirstResponder];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText 
{
	self.mySearchText = searchText;
	
	if([searchText isEqualToString:@""]){
		return;
		//[searchBar resignFirstResponder];
	}
	
	if([self.timer isValid]) 
		[self.timer invalidate];
	
	self.timer = [NSTimer scheduledTimerWithTimeInterval:1 
												  target:self 
												selector:@selector(search) 
												userInfo:nil
												 repeats:NO];	
}

-(void) setupTimer:(NSString *) searchText {
	//
	
	//NSAutoReleasePool *pool = [[NSAutoReleasePool alloc] init];
    // your code here
    
	}


-(void) search
{

//	[NSThread detachNewThreadSelector:@selector(search:) toTarget:self withObject:nil];
//	[NSThread detachNewThreadSelector:@selector(search:) 
//							 toTarget:self withObject:tim];
//	[UIView beginAnimations:nil context:nil];
//	[UIView setAnimationDuration:1.0];
//	self.searchBar.frame = CGRectMake(self.searchBar.frame.origin.x, self.searchBar.frame.origin.y, 278, self.searchBar.frame.size.height);
	[self.activityIndicator startAnimating];
//	[UIView commitAnimations];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
				   {
					   NSLog(@"Search text: %@", self.mySearchText);
					   NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
					   NSArray * unsorted = [appDelegate.service searchForDrugsByName:self.mySearchText];
					   NSSortDescriptor *ratingSD = [NSSortDescriptor sortDescriptorWithKey: @"rating" ascending: NO];
					   self.drugs = [unsorted sortedArrayUsingDescriptors:[NSArray arrayWithObject:ratingSD]];
					   
					   dispatch_async(dispatch_get_main_queue(), ^
									  {
										  [self.tableView reloadData];
//										  [UIView beginAnimations:nil context:nil];
//										  [UIView setAnimationDuration:1.0];
//										  self.searchBar.frame = CGRectMake(self.searchBar.frame.origin.x, self.searchBar.frame.origin.y, 320, self.searchBar.frame.size.height);
										  [self.activityIndicator stopAnimating];
//										  [UIView commitAnimations];
									  });
					   [pool drain];
				   });

	//[timer invalidate];
		
}



- (void)dealloc {
	[tableView release];
	[mySearchText release];
	[activityIndicator release];
    [super dealloc];
}


@end
