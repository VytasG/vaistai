//
//  GroupViewChildController.h
//  vaistai.lt
//
//  Created by Vytautas on 12/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GroupViewChildController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	UITableView *myTableView;
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;

@end
