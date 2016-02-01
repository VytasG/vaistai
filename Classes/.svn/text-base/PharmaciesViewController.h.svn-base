//
//  PharmaciesViewController.h
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-12.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Pharmacy.h"
@class vaistai_ltAppDelegate;


@interface PharmaciesViewController : UIViewController <MKMapViewDelegate, 
														UITableViewDelegate, 
														UITableViewDataSource, 
														CLLocationManagerDelegate> 
{
	IBOutlet MKMapView * mapView;
	IBOutlet UITableView * tableView;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UIView *loadingBackground;
	IBOutlet UIView *loadingScreen;
	NSArray *pharmacies;
	vaistai_ltAppDelegate *appDelegate;
	UISegmentedControl * segmentedControl;
	NSString *latitude;
	NSString *longitute;	
	NSString *alias;
	UIButton *myButtonBlue;
	UIButton *myButtonBlue2;
	CLLocationManager *locationManager;
}

- (void)switchViews:(id)sender;
- (void)initMap;
- (void)loadInfo;
- (void)updateInfo;

@property (nonatomic, retain) IBOutlet UISegmentedControl * segmentedControl;
@property (nonatomic,retain) NSArray *pharmacies;
@property (nonatomic, retain) vaistai_ltAppDelegate * appDelegate;
@property (nonatomic, retain)	IBOutlet UITableView *tableView;
@property (nonatomic,retain) 	IBOutlet MKMapView * mapView;
@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, retain) NSString *longitude;
@property (nonatomic, retain) NSString *alias;
@property (nonatomic, retain) UIButton *myButtonBlue;
@property (nonatomic, retain) UIButton *myButtonBlue2;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) IBOutlet UIView *loadingBackground;
@property (nonatomic, retain) IBOutlet UIView *loadingScreen;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end
