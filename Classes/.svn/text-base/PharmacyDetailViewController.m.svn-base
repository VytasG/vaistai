//
//  PharmacyDetailViewController.m
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-12.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PharmacyDetailViewController.h"
#import "Pharmacy.h"
#import "vaistai_ltAppDelegate.h"
#import "DrugService.h"
#import "StationAnnotation.h"
#import <dispatch/dispatch.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0] 

@implementation PharmacyDetailViewController

@synthesize pharmacy, loading,tableView,toolbar,activity,appDelegate;
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
	self.tableView.backgroundColor  = [UIColor clearColor];
	self.tableView.separatorColor = UIColorFromRGB(0xA5C51E);
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

	self.title = self.pharmacy.firm;
	self.appDelegate = [[UIApplication sharedApplication] delegate];
	self.tableView.allowsSelection = NO;
	
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
	lbl.text=@"Vaistinė";
	self.navigationItem.titleView = lbl;
	
	[activity startAnimating];
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
				   {
					   [self loadPharmacy:self.pharmacy.alias];
				   });
	
	mapView = [[MKMapView alloc] initWithFrame:CGRectMake(30, 200, 250, 160)];
}

-(void)viewWillAppear:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void) loadPharmacy:(NSString *) alias {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	self.pharmacy = [self.appDelegate.service getPharmacyByAlias:alias];
	dispatch_async(dispatch_get_main_queue(), ^
				   {
					   [self releadView];
				   });
	[pool drain];
}

-(void) releadView {
	[tableView reloadData];
	[activity stopAnimating];
	self.loading.text = @"Atlikta";
	[UIView beginAnimations:nil context:nil];
	self.toolbar.alpha = 0.0;
	self.loading.alpha = 0.0;
	[UIView commitAnimations];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	//  NSLog(@"vaizduojam eilute: %d",[indexPath row]);
	
	NSUInteger index = [indexPath row];
	
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero 
									   reuseIdentifier:CellIdentifier] autorelease];
	}
	

	UIImageView * ico = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vaistines.png"]];
	ico.frame = CGRectMake(16, 19, 25, 25);
	[cell addSubview:ico];
	
	UILabel * pavadinimas = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 250, 44)];
	pavadinimas.text = self.pharmacy.firm;
	pavadinimas.lineBreakMode = UILineBreakModeWordWrap;
	pavadinimas.numberOfLines = 2;
	pavadinimas.textColor = UIColorFromRGB(0x3D7DAE);
	pavadinimas.font = [UIFont boldSystemFontOfSize:18];
	
	UILabel * adresas = [[UILabel alloc] initWithFrame:CGRectMake(30, 50, 200, 22)];
	adresas.text = @"Adresas:";
	adresas.textColor = UIColorFromRGB(0xA5C51E);
	
	
	UILabel * adresas2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 70, 200, 22)];
	adresas2.text = self.pharmacy.address;
	adresas2.textColor = UIColorFromRGB(0x3D7DAE);

	
	UILabel * darbolaikas = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 200, 22)];
	darbolaikas.lineBreakMode = UILineBreakModeWordWrap;
	darbolaikas.text = @"Darbo laikas:";
	darbolaikas.textColor = UIColorFromRGB(0xA5C51E);
	[cell addSubview:darbolaikas];
	
	UILabel * darbolaikas2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 120, 200, 22)];
	darbolaikas2.numberOfLines = 1;
	darbolaikas2.text = @"I-VI: 8-20";
	darbolaikas2.textColor = UIColorFromRGB(0x3D7DAE);
	[cell addSubview:darbolaikas2];
	
	if(!self.pharmacy.phones) {

	NSLog(@"Creating map");
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta=.001f;
	span.longitudeDelta=.001f;
	//	
	CLLocationCoordinate2D location;
	
	//lietuva 54.676246,25.286129
	location.latitude = [self.pharmacy.latitude floatValue];
	location.longitude = [self.pharmacy.longitude floatValue]; 

	
	
	
	mapView.region = MKCoordinateRegionMakeWithDistance(location, 1000,1000);
	[mapView regionThatFits:region];
	
		CLLocationCoordinate2D newCoord = {55,23};
		StationAnnotation* annotation = [[StationAnnotation alloc] initWithCoordinate:newCoord andStation:self.pharmacy];
		[mapView addAnnotation:annotation];
		[annotation release];
	
	
	[cell addSubview:mapView];
	
	}
	
	
	if(self.pharmacy.phones) {
		UILabel * telefonai = [[UILabel alloc] initWithFrame:CGRectMake(30, 150, 200, 22)];		
		telefonai.text = @"Telefonai:";
		telefonai.textColor = UIColorFromRGB(0xA5C51E);
		[cell addSubview:telefonai];
		
		UILabel * telefonai2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 170, 200, 22)];
		telefonai2.text = self.pharmacy.phones;
		telefonai2.textColor = UIColorFromRGB(0x3D7DAE);
		[cell addSubview:telefonai2];
		
		
	}
	
	[cell addSubview:pavadinimas];
	[cell addSubview:adresas];
	[cell addSubview:adresas2];
	return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//self.drugs = [appDelegate.service searchForDrugsByName:@"validol"];
	return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return 380.0f;	
	
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


- (void)dealloc {	[toolbar release];
	[loading release];
    [super dealloc];
}


@end
