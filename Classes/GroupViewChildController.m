//
//  GroupViewChildController.m
//  vaistai.lt
//
//  Created by Vytautas on 12/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GroupViewChildController.h"
#import "Group.h"

@implementation GroupViewChildController

@synthesize myTableView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
	self.myTableView.backgroundColor  = [UIColor clearColor];	
	//self.title = @"Title";
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.myTableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.opaque = NO;
    }
	
	cell.textLabel.backgroundColor = [UIColor clearColor];
	cell.backgroundColor = [UIColor whiteColor];
	cell.textLabel.textColor = [UIColor blackColor];
	
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


- (void)dealloc {
	[myTableView release];
    [super dealloc];
}


@end
