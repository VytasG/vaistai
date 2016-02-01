//
//  RootViewController.h
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "vaistai_ltAppDelegate.h"
#import "ZBarSDK.h"
#import "ScannerOverlayView.h"
#import "Drug.h"
#import <AVFoundation/AVFoundation.h>

@class DrugListViewController;
@class GroupViewController;
@class PharmaciesViewController;

@interface RootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ZBarReaderDelegate, AVAudioPlayerDelegate> {
	IBOutlet vaistai_ltAppDelegate * appDelegate;
	IBOutlet UITableView * tableView;
	DrugListViewController *childController;
	GroupViewController *groupController;
	PharmaciesViewController *pharmaciesController;
	ZBarReaderViewController *readerViewController;
	IBOutlet ScannerOverlayView *overlay;
	IBOutlet UITextView *overlayTextView;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UIView *loadingView;
	Drug *drug;
	UIImagePickerController *readerController;
}

@property (nonatomic, retain) IBOutlet vaistai_ltAppDelegate * appDelegate;
@property (nonatomic, retain) IBOutlet UITableView * tableView;
@property (nonatomic, retain) ZBarReaderViewController *readerViewController;
@property (nonatomic, retain) IBOutlet ScannerOverlayView *overlay;
@property (nonatomic, retain) IBOutlet UITextView *overlayTextView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) IBOutlet UIView *loadingView;
@property (nonatomic, retain) Drug *drug;
@property (nonatomic, retain) UIImagePickerController *readerController;
@property (nonatomic, retain) PharmaciesViewController *pharmaciesController;

- (void)dismissScanner;

@end
