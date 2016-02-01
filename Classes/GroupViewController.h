//
//  GroupeViewController.h
//  vaistai.lt
//
//  Created by hitt on 12/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Group;
@class vaistai_ltAppDelegate;
@class DrugListViewController;

@interface GroupViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	vaistai_ltAppDelegate *appDelegate;
	NSMutableArray *lgroups;
	GroupViewController *childController;
	DrugListViewController *drugController;
	UITableView *myTableView;
	IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UILabel *loadingText;
    IBOutlet UIToolbar *toolbar;
}

@property (nonatomic, retain) NSMutableArray *lgroups;
@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) IBOutlet UILabel *loadingText;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@end
