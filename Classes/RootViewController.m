//
//  RootViewController.m
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

#import "vaistai_ltAppDelegate.h"
#import "GroupViewController.h"
#import "DrugListViewController.h"
#import "PharmaciesViewController.h"
#import "DrugViewController.h"
#import "OmnitelViewController.h"

#import "DrugService.h"
#import "Drug.h"

#import <QuartzCore/QuartzCore.h>
#import <dispatch/dispatch.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation RootViewController
@synthesize tableView, appDelegate, readerViewController, overlay, overlayTextView, activityIndicator, drug, readerController, pharmaciesController,
	loadingView;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.appDelegate = [[UIApplication sharedApplication] delegate];
	
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"indexbg.png"]];
	//self.title = @"Pagrindinis";
	self.tableView.backgroundColor  = [UIColor clearColor];
	self.tableView.separatorColor = UIColorFromRGB(0xA5C51E);
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    OmnitelViewController *omnitelViewController = [[OmnitelViewController alloc] init];
    [self presentModalViewController:omnitelViewController animated:NO];
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
	//[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"btBig.png"]];
	//self.navigationController.navigationBar.tintColor = [UIColor clearColor];
}

#pragma mark -
#pragma mark TableView data source and delegate methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	//  NSLog(@"vaizduojam eilute: %d",[indexPath row]);
	
	NSUInteger index = [indexPath row];
	
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero 
									   reuseIdentifier:CellIdentifier] autorelease];
	}
	
	UIImage *image = [UIImage   imageNamed:@"rodykle.png"];
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
	button.frame = frame;
	[button setBackgroundImage:image forState:UIControlStateNormal];
	
	[button addTarget:self action:@selector(checkButtonTapped:event:)  forControlEvents:UIControlEventTouchUpInside];
	button.backgroundColor = [UIColor clearColor];
	cell.accessoryView = button;
	
	switch (index) {
		case 0:
			//[cell setText:@"Vaistų paieška"];
			cell.textLabel.text = @"Vaistų paieška";
			cell.textLabel.textColor = UIColorFromRGB(0x3D7DAE);
			cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
			cell.imageView.image = [UIImage imageNamed:@"vaistai.png"];
			if (appDelegate.connection == NO || appDelegate.allow == NO) {
				cell.accessoryView = UITableViewCellAccessoryNone;
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
			}
			break;
		case 1:
			//[cell setText:@"Vaistai pagal grupę"];
			cell.textLabel.text = @"Vaistai pagal grupę";
			cell.textLabel.textColor = UIColorFromRGB(0x3D7DAE);
			cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
			cell.imageView.image = [UIImage imageNamed:@"sirdis.png"];
			if (appDelegate.connection == NO || appDelegate.allow == NO) {
				cell.accessoryView = UITableViewCellAccessoryNone;
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
			}
			break;
		case 2:
			//[cell setText:@"Vaistinės"];
			cell.textLabel.text = @"Artimiausios vaistinės";
			cell.textLabel.textColor = UIColorFromRGB(0x3D7DAE);
			cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
			cell.imageView.image = [UIImage imageNamed:@"vaistines.png"];
			if (appDelegate.connection == NO || appDelegate.allow == NO) {
				cell.accessoryView = UITableViewCellAccessoryNone;
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
			}
			break;
		case 3:
			cell.textLabel.text = @"Skenuoti kodą";
			cell.textLabel.textColor = UIColorFromRGB(0x3D7DAE);
			cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
			cell.imageView.image = [UIImage imageNamed:@"barscan.png"];
			if (appDelegate.connection == NO || appDelegate.allow == NO) {
				cell.accessoryView = UITableViewCellAccessoryNone;
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
			}
			break;
		default:
			break;
	}
	return cell;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {

	NSUInteger row = [indexPath row];
	self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
	//[[self.navigationController navigationBar] setBackgroundImage:[UIImage imageNamed:@"bg_top.png"]];
	UIBarButtonItem *bb = [[UIBarButtonItem alloc] 
						   initWithTitle:@"Atgal" style:UIBarButtonItemStyleDone target:nil 
						   action:nil];
	[self.navigationItem setBackBarButtonItem:bb];
	//self.navigationController.navigationBar.hidden = FALSE;

	switch (row) {
		case 0:
			if (appDelegate.connection == NO || appDelegate.allow == NO)
				break;
			if(childController == NULL)
				childController = [[DrugListViewController alloc] init];
			[self.appDelegate.navigationController pushViewController:childController animated:YES];
			[self.navigationController setNavigationBarHidden:NO animated:YES];
			break;
		case 1:
			if (appDelegate.connection == NO || appDelegate.allow == NO)
				break;
			if(groupController == NULL)
				groupController = [[GroupViewController alloc] init];
			NSMutableArray *itm = [appDelegate.groups getParentGroups];
			groupController.lgroups = itm;
			[self.appDelegate.navigationController pushViewController:groupController animated:YES];
			break;
		case 2:
			if (appDelegate.connection == NO || appDelegate.allow == NO)
				break;
			if(pharmaciesController == nil)
				pharmaciesController = [[PharmaciesViewController alloc] init];
			pharmaciesController.alias = @"show_vaistines";
			[self.navigationController pushViewController:pharmaciesController animated:YES];
			break;
		case 3:
			if (appDelegate.connection == NO || appDelegate.allow == NO)
				break;
			if(self.readerViewController == nil) {
				self.readerViewController = [ZBarReaderViewController new];
				self.readerViewController.readerDelegate = self;
				self.readerViewController.showsZBarControls = NO;
				self.readerViewController.wantsFullScreenLayout = NO;
				self.readerViewController.cameraOverlayView = overlay;
				
				ZBarImageScanner *scanner = self.readerViewController.scanner;
				[scanner setSymbology:0 config:ZBAR_CFG_ENABLE to:1];
			}
			
			[self.overlayTextView.layer setMasksToBounds:YES];
			self.loadingView.alpha = 0.0;
			
			UIButton *myButtonBlue = [[UIButton alloc] initWithFrame:CGRectMake(5, 7, 55, 30)];
			[myButtonBlue setBackgroundImage:[UIImage imageNamed:@"bt_atgal_blue.png"] forState:UIControlStateNormal];
			[myButtonBlue addTarget:self action:@selector(dismissScanner) forControlEvents:UIControlEventTouchUpInside];
			[self.overlay addSubview:myButtonBlue];
			
			[self.navigationController setNavigationBarHidden:YES animated:NO];
			[self presentModalViewController:self.readerViewController animated:YES];
			//[self.appDelegate.navigationController pushViewController:self.readerViewController animated:YES];
			
			self.overlayTextView.alpha = 0.0;
			[UIView beginAnimations:nil context:nil];
			[UIView setAnimationDuration:1];
			self.overlayTextView.alpha = 0.7;
			[UIView commitAnimations];
			
			break;
		default:
			break;
	}
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}

#pragma mark -
#pragma mark ZBar delegate methods

// Barkodo nuskaitymo iš paveikslėlio funkcija
- (void) imagePickerController: (UIImagePickerController*) aReader didFinishPickingMediaWithInfo: (NSDictionary*) info {
	self.readerController = aReader;
	
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
	//self.myBarcode = symbol.data;
	
	NSLog(@"Nuskenuotas barkodas: %@", symbol.data);
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"spust_fade" ofType:@"wav"];  
	AVAudioPlayer* theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];  
	theAudio.delegate = self;
	[theAudio play];
	
	[self.activityIndicator startAnimating];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	self.loadingView.alpha = 0.85;
	[UIView commitAnimations];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
				   {
					   ZBarImageScanner *scanner = self.readerViewController.scanner;
					   [scanner setSymbology:0 config:ZBAR_CFG_ENABLE to:0];
					   
					   Drug *myDrug = [self.appDelegate.service getDrugByBarcode:symbol.data];
					   //Drug *myDrug = [self.appDelegate.service getDrugByAlias:@"gelomyrtol-forte-300mg-skrandyje-neirios-kaps-n20"];
					   self.drug = myDrug;
					   
					   if([myDrug.alias length] == 0) 
					   {
						   dispatch_async(dispatch_get_main_queue(), ^
										  {
											  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Klaida" 
																							  message:@"Informacijos apie šį produktą nerasta." 
																							 delegate:nil 
																					cancelButtonTitle:@"Ok" 
																					otherButtonTitles:nil];
											  [alert show];
											  [alert release];
										  });
					   }
					   else 
					   {
						   dispatch_async(dispatch_get_main_queue(), ^
										  {
											  DrugViewController *drugViewController = [[DrugViewController alloc] init];
											  drugViewController.drug = self.drug;
											  [self.readerController dismissModalViewControllerAnimated:YES];
											  [self.navigationController pushViewController:drugViewController animated:YES];	
										  });
					   }
					   [scanner setSymbology:0 config:ZBAR_CFG_ENABLE to:1];
					   
					   dispatch_async(dispatch_get_main_queue(), ^
									  {
										  [self.activityIndicator stopAnimating];
										  [UIView beginAnimations:nil context:nil];
										  [UIView setAnimationDuration:1.0];
										  self.loadingView.alpha = 0;
										  [UIView commitAnimations];
									  });
					   
				   });
}

#pragma mark -

- (void)dismissScanner {
	[self.readerViewController dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[tableView release];
	[readerViewController release];
	[overlay release];
	[overlayTextView release];
	[activityIndicator release];
	[loadingView release];
	[drug release];
	[readerController release];
	[pharmaciesController release];
    [super dealloc];
}


@end

