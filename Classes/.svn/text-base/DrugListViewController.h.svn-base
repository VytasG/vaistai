//
//  DrugListViewController.h
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@class vaistai_ltAppDelegate;

@interface DrugListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate> {
	vaistai_ltAppDelegate *appDelegate;
	NSArray * drugs;
	NSString *mySearchText;
	
	IBOutlet UITableView *tableView;
	IBOutlet UISearchBar *searchBar;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	NSTimer * timer;
	
}

-(void) doneSearching_Clicked:(id)sender;
-(void) search;

@property (nonatomic,retain) NSTimer * timer;
@property (nonatomic,retain) IBOutlet UISearchBar * searchBar;
@property (nonatomic,retain) IBOutlet UITableView * tableView;
@property (nonatomic,retain) NSArray * drugs;
@property (nonatomic, retain) NSString *mySearchText;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;


-(IBAction) grab;
@end
