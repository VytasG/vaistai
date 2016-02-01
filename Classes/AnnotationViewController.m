//
//  AnnotationViewController.m
//  vaistai.lt
//
//  Created by Vytautas on 1/10/11.
//  Copyright 2011 UAB "Informacinių Technologijų Organizacija". All rights reserved.
//

#import "AnnotationViewController.h"
#import "PharmaciesViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation AnnotationViewController

@synthesize myTableView, drug;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	appDelegate = (vaistai_ltAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
	self.myTableView.backgroundColor  = [UIColor clearColor];
	self.myTableView.separatorColor = UIColorFromRGB(0xA5C51E);
	self.myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	self.myTableView.allowsSelection = NO;
	//self.title = self.drug.name;
	
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
	lbl.text=self.drug.name;
	self.navigationItem.titleView = lbl;
}

- (void)viewWillAppear:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void) nearestPharmacies {
	PharmaciesViewController * pvc = [[PharmaciesViewController alloc] init];
	pvc.alias = self.drug.alias;
	self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Atgal"
																			  style:UIBarButtonItemStyleBordered
																			 target:nil action:nil] autorelease];
	[self.navigationController pushViewController:pvc animated:YES];
}

#pragma mark -
#pragma mark UITableView delegate and data source metods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero 
									   reuseIdentifier:CellIdentifier] autorelease];
	} 
	
	UIButton *button;
	UIWebView *webView;
	NSString *fullString;
	
	switch ([indexPath row]) {
		case 0:
			fullString = [NSString stringWithFormat:@"%@%@%@",
									@"<html><head><title></title></head><body style=\"background:transparent; color:#3D7DAE; font-family:Arial; text-align:justify\">",
									self.drug.anotacija,
									@"</body></html>"];
			webView = [[UIWebView alloc] initWithFrame:CGRectMake(15, 5, 290, 320)];
			webView.dataDetectorTypes = UIDataDetectorTypeNone;
			[webView loadHTMLString:fullString baseURL:nil];
			[webView setBackgroundColor:[UIColor clearColor]];
			[[webView.subviews objectAtIndex:0] setBounces: NO];
			[cell addSubview:webView];
			break;
		case 1:
			button = [UIButton buttonWithType:UIButtonTypeCustom];
			button.frame = CGRectMake(75, 10, 180, 25);
			[button setBackgroundImage:[UIImage imageNamed:@"btBig.png"] forState:UIControlStateNormal];
			[button setTitle:@"Artimiausios vaistinės" forState:UIControlStateNormal];
			[button addTarget:self action:@selector(nearestPharmacies) forControlEvents:UIControlEventTouchDown];
			[cell addSubview:button];	
			break;
		default: 
			break;
	}
	return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	switch ([indexPath row]) {
		case 0:
			return 330.0f;
		case 1:
			return 44.0f;
		default:
			break;
	}
	return 0;
}

#pragma mark -
#pragma mark UIWebView Delegate Methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	return NO;
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	self.myTableView = nil;
	self.drug = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[myTableView release];
	[drug release];
    [super dealloc];
}


@end
