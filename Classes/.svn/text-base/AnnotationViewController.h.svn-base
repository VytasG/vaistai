//
//  AnnotationViewController.h
//  vaistai.lt
//
//  Created by Vytautas on 1/10/11.
//  Copyright 2011 UAB "Informacinių Technologijų Organizacija". All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drug.h"
#import "vaistai_ltAppDelegate.h"

@interface AnnotationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate> {
	IBOutlet UITableView *myTableView;
	Drug *drug;
	vaistai_ltAppDelegate *appDelegate;
}

@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) Drug *drug;

-(void) nearestPharmacies;

@end
