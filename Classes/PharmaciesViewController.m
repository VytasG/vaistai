//
//  PharmaciesViewController.m
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-12.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PharmaciesViewController.h"
#import "vaistai_ltAppDelegate.h"
#import "DrugService.h"
#import "StationAnnotation.h"
#import "PharmacyDetailViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <dispatch/dispatch.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation PharmaciesViewController
@synthesize mapView,tableView,appDelegate,pharmacies,segmentedControl,latitude,longitude,alias, myButtonBlue, 
myButtonBlue2, activityIndicator, loadingScreen, loadingBackground, locationManager;

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
	
	//self.title = @"Vaistinės";
	self.appDelegate = [[UIApplication sharedApplication] delegate];
	[self.navigationController setNavigationBarHidden:NO animated:NO];
	
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
	self.tableView.backgroundColor  = [UIColor clearColor];
	self.tableView.separatorColor = UIColorFromRGB(0xA5C51E);
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	
	UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
	myButton.frame = CGRectMake(20, 20, 55, 30); // position in the parent view and set the size of the button
	[myButton setBackgroundImage:[UIImage imageNamed:@"bt_atgal.png"] forState:UIControlStateNormal];
	[myButton addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:myButton];
	self.navigationItem.leftBarButtonItem = backButton;
	self.navigationItem.hidesBackButton = YES;
	
	UILabel *lbl=[[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 184, 45)] autorelease];
	lbl.backgroundColor=[UIColor clearColor]; 
	lbl.font = [UIFont fontWithName:@"Arial" size:18]; 
	lbl.font = [UIFont boldSystemFontOfSize:18];
	lbl.textColor = UIColorFromRGB(0xA5C51E);
	lbl.textAlignment=UITextAlignmentCenter; 
	lbl.text = @"Vaistinės";
	self.navigationItem.titleView = lbl;
	
	self.myButtonBlue = [[UIButton alloc] initWithFrame:CGRectMake(5, 7, 55, 30)];
	[self.myButtonBlue setBackgroundImage:[UIImage imageNamed:@"bt_atgal_blue.png"] forState:UIControlStateNormal];
	[self.myButtonBlue addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.myButtonBlue];
	
	self.myButtonBlue2 = [[UIButton alloc] initWithFrame:CGRectMake(242, 7, 70, 30)];
	[self.myButtonBlue2 setBackgroundImage:[UIImage imageNamed:@"bt_atnaujinti.png"] forState:UIControlStateNormal];
	[self.myButtonBlue2 addTarget:self action:@selector(updateInfo) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.myButtonBlue2];
	
	//[self initMap];
	locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	mapView.showsUserLocation = YES; 
	[locationManager startUpdatingLocation];
	
	[self loadInfo];
}

- (void)loadInfo
{
	self.latitude = [NSString stringWithFormat:@"%g", locationManager.location.coordinate.latitude];
	self.longitude = [NSString stringWithFormat:@"%g", locationManager.location.coordinate.longitude];
	
	NSLog(@"%@ %@", self.latitude, self.longitude);
	
	[self.activityIndicator startAnimating];
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ 
				   {
					   NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
					   
					   self.pharmacies = [self.appDelegate.service searchForPharmacyByDrug:self.alias latitude:self.latitude longitude:self.longitude];
					   NSSortDescriptor *desc = [NSSortDescriptor sortDescriptorWithKey: @"firm" ascending: YES];
					   self.pharmacies = [pharmacies sortedArrayUsingDescriptors:[NSArray arrayWithObject:desc]];
					   
					   dispatch_async(dispatch_get_main_queue(), ^
									  {
										  [self initMap];
										  [self.tableView reloadData];
										  [UIView beginAnimations:nil context:nil];
										  [UIView setAnimationDuration:1.0];
										  self.loadingScreen.alpha = 0.0;
										  self.loadingBackground.alpha = 0.0;
										  [UIView commitAnimations];
										  [self.activityIndicator stopAnimating];
									  });
					   [pool drain];
				   });
}

- (void)updateInfo
{
	NSMutableArray *newArray = [NSMutableArray arrayWithArray:self.pharmacies];
    [newArray removeAllObjects];
    self.pharmacies = [NSArray arrayWithArray:newArray];
	
	NSMutableArray *toRemove = [NSMutableArray array];
	for (id annotation in mapView.annotations)
		if (annotation != mapView.userLocation)
			[toRemove addObject:annotation];
	[mapView removeAnnotations:toRemove];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	self.loadingScreen.alpha = 1.0;
	self.loadingBackground.alpha = 0.85;
	[UIView commitAnimations];
	
	[self loadInfo];
}

- (void)backButtonPressed
{
	[appDelegate backButtonPressed];
}

-(void)viewWillAppear:(BOOL)animated {
	//self.navigationController.navigationBar.translucent = YES;
	//self.navigationController.navigationBar.tintColor = [UIColor clearColor];
	//[self.navigationController.navigationBar setBackgroundImage:nil];
	NSLog(@"Alias: %@\n", self.alias);
	
	if(self.mapView.alpha == 1) {
		self.myButtonBlue.hidden = NO;
		self.myButtonBlue2.hidden = NO;
		[self.navigationController setNavigationBarHidden:YES];
	}
	else {
		self.myButtonBlue.hidden = YES;
		self.myButtonBlue2.hidden = YES;
		[self.navigationController setNavigationBarHidden:NO];
	}
}

- (void)viewWillDisappear:(BOOL)animated
{
}

#pragma mark -
#pragma mark CLLocationManager delegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation 
{
	
}

- (void)initMap 
{	
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta = 0.001f;
	span.longitudeDelta = 0.001f;
	
	CLLocationCoordinate2D location;
	location.latitude = [self.latitude floatValue];
	location.longitude = [self.longitude floatValue];
	
	mapView.region = MKCoordinateRegionMakeWithDistance(location, 3000,3000);
	[mapView regionThatFits:region];
	
	for(Pharmacy *pharmacy in self.pharmacies) 
	{
		CLLocationCoordinate2D newCoord = {55,23};
		StationAnnotation* annotation = [[StationAnnotation alloc] initWithCoordinate:newCoord andStation:pharmacy];
		[mapView addAnnotation:annotation];
		[annotation release];
	} 
}

#pragma mark -

-(void) switchViews:(id)sender {
	NSLog(@"switching");
	if(self.mapView.alpha == 0) {
		[self.navigationController setNavigationBarHidden:YES];
		self.mapView.alpha = 1;
		self.tableView.alpha = 0;
		self.myButtonBlue.hidden = NO;
		self.myButtonBlue2.hidden = NO;
	} 
	else {
		[self.navigationController setNavigationBarHidden:NO];
		self.mapView.alpha = 0;
		self.tableView.alpha = 1;
		self.myButtonBlue.hidden = YES;
		self.myButtonBlue2.hidden = YES;
	}
}

- (MKAnnotationView *)mapView:(MKMapView *)_mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	
	if( [[annotation title] isEqualToString:@"Current Location"] ) {
		return nil;
	}
	
	MKPinAnnotationView *pinView = (MKPinAnnotationView*)[_mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
	
	if(pinView == nil) {
		pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
		//pinView.pinColor = MKPinAnnotationColorGreen;
		pinView.animatesDrop = YES;
		pinView.canShowCallout = YES;
		UIImageView *leftIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vaistines.png"]];
		
		pinView.leftCalloutAccessoryView = leftIconView;
		UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		[rightButton addTarget:self action:@selector(annotationClick:) forControlEvents:UIControlEventTouchUpInside];
		pinView.rightCalloutAccessoryView = rightButton;
	} 
	else {
		pinView.annotation = annotation;
	}
	return pinView;
}

-(void)	annotationClick:(id)sender {
	//NSUInteger index = [indexPath row];
	UIView * v = (UIView *) sender;
	Drug *d = [[[[v superview] superview] annotation] station];
	
	UIBarButtonItem *bb = [[[UIBarButtonItem alloc] 
						   initWithTitle:@"Atgal" style:UIBarButtonItemStyleDone target:nil 
						   action:nil] autorelease];
	[self.navigationItem setBackBarButtonItem:bb];
	
	
	//NSLog("ASDFADF: %d",[v tag]);
	PharmacyDetailViewController * pV = [[PharmacyDetailViewController alloc] init];
	pV.pharmacy = d;
	
	[self.navigationController pushViewController:pV animated:YES];
	
}


- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
	
	NSUInteger index = [indexPath row];
	UIBarButtonItem *bb = [[[UIBarButtonItem alloc] 
						   initWithTitle:@"Atgal" style:UIBarButtonItemStyleDone target:nil 
						   action:nil] autorelease];
	[self.navigationItem setBackBarButtonItem:bb];
	
	PharmacyDetailViewController * pV = [[PharmacyDetailViewController alloc] init];
	pV.pharmacy = [self.pharmacies objectAtIndex:index];
	
	[self.navigationController pushViewController:pV animated:YES];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	//  NSLog(@"vaizduojam eilute: %d",[indexPath row]);
	
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
	[cell setText:[[self.pharmacies objectAtIndex:index] firm]];	
	
	//cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"rating%d.gif",[[[self.drugs objectAtIndex:index] rating] intValue]]];
	
	
	UIImage *image = [UIImage   imageNamed:@"rodykle.png"];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
	button.frame = frame;
	[button setBackgroundImage:image forState:UIControlStateNormal];
//	[button addTarget:self action:@selector(checkButtonTapped:event:)  forControlEvents:UIControlEventTouchUpInside];
	button.backgroundColor = [UIColor clearColor];
	cell.accessoryView = button;
	
    return cell;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//self.drugs = [appDelegate.service searchForDrugsByName:@"validol"];
	return [self.pharmacies count];	
	
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
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


- (void)dealloc 
{
	[loadingScreen release];
	[loadingBackground release];
	[activityIndicator release];
	[tableView release];
	[longitute release];
	[latitude release];
	[alias release];
	[myButtonBlue release];
	[myButtonBlue2 release];
	[locationManager release];
    [super dealloc];
}


@end
