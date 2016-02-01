//
//  PharmacyDetailViewController.h
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-12.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@class Pharmacy;
@class vaistai_ltAppDelegate;

@interface PharmacyDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	Pharmacy * pharmacy;
	
	IBOutlet UILabel * loading;
	IBOutlet UIActivityIndicatorView *activity;
	IBOutlet UITableView * tableView;
	IBOutlet UIToolbar * toolbar;
	MKMapView * mapView;
	vaistai_ltAppDelegate * appDelegate;
}
@property (nonatomic,retain) vaistai_ltAppDelegate * appDelegate;

@property (nonatomic,retain) 	IBOutlet UILabel * loading;

@property (nonatomic,retain) IBOutlet UIActivityIndicatorView *activity;

@property (nonatomic,retain) IBOutlet UITableView * tableView;

@property (nonatomic,retain) IBOutlet UIToolbar * toolbar;


@property (nonatomic,retain) Pharmacy * pharmacy;

- (void) loadPharmacy:(NSString *) alias;
- (void) releadView;

@end
