//
//  DrugViewController.h
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Drug;
@class vaistai_ltAppDelegate;


@interface DrugViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
	IBOutlet UITableView * tableView;
	
	Drug * drug;
	IBOutlet UIActivityIndicatorView * activityView;
	IBOutlet UIToolbar * toolbar;
	IBOutlet UILabel * loading;
	vaistai_ltAppDelegate * appDelegate;
	NSString *drugAlias;
	BOOL firstLoad;
	
}

-(void) loadDrug:(NSString *) alias;
-(void) more;
- (void) releadView;

@property (nonatomic, retain) IBOutlet UILabel * loading;
@property (nonatomic, retain) IBOutlet UIToolbar * toolbar;
@property (nonatomic, retain) 	IBOutlet UIActivityIndicatorView * activityView;
@property (nonatomic, retain) vaistai_ltAppDelegate * appDelegate;
@property (nonatomic, retain) Drug	*drug;
@property (nonatomic, retain) IBOutlet UITableView * tableView;
@property (nonatomic, retain) NSString *drugAlias;
@property BOOL firstLoad;

@end
