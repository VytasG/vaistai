//
//  DrugViewController.m
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DrugViewController.h"
#import "Drug.h"
#import "vaistai_ltAppDelegate.h"
#import "DrugService.h"
#import "DrugViewCell.h"
#import "PharmaciesViewController.h"
#import "AnnotationViewController.h"
#import "asyncimageview.h"
#import "DrugIconsView.h"
#import <dispatch/dispatch.h>

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]  

@implementation DrugViewController
@synthesize tableView,drug,appDelegate, activityView,toolbar,loading,drugAlias, firstLoad;

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
	self.firstLoad = YES;
	self.appDelegate = [[UIApplication sharedApplication] delegate];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
	self.tableView.backgroundColor  = [UIColor clearColor];
	self.tableView.separatorColor = UIColorFromRGB(0xA5C51E);
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	//self.title = self.drug.name;
	
	UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
	myButton.frame = CGRectMake(20, 20, 55, 30); // position in the parent view and set the size of the button
	[myButton setBackgroundImage:[UIImage imageNamed:@"bt_atgal.png"] forState:UIControlStateNormal];
	[myButton addTarget:appDelegate action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:myButton];
	self.navigationItem.leftBarButtonItem = backButton;
	self.navigationItem.hidesBackButton = YES;
	
	UILabel *lbl=[[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 184, 45)] autorelease];
	lbl.backgroundColor=[UIColor clearColor]; 
	lbl.font = [UIFont fontWithName:@"Arial" size:18]; 
	lbl.font = [UIFont boldSystemFontOfSize:18];
	lbl.textColor = UIColorFromRGB(0xA5C51E);
	lbl.textAlignment=UITextAlignmentCenter; 
	lbl.text = self.drug.name;
	self.navigationItem.titleView = lbl;
	
	self.navigationItem.backBarButtonItem =
	[[UIBarButtonItem alloc] initWithTitle:@"Atgal"
									 style: UIBarButtonItemStyleBordered
									target:nil
									action:nil];
	self.tableView.allowsSelection = NO;
	
	/*NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] 
                                        initWithTarget:self
                                        selector:@selector(loadDrug:) 
										object:self.drug.alias];
    [queue addOperation:operation]; 
	[operation release];*/
	[activityView startAnimating];
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ 
				   {
					   [self loadDrug:self.drug.alias];
				   });
	//[self performSelectorInBackground:@selector(loadDrug:) withObject:self.drug.alias];
}

-(void)viewWillAppear:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void) loadDrug:(NSString *) alias {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[NSThread sleepForTimeInterval:1.0];
	self.drugAlias = alias;
	self.drug = [self.appDelegate.service getDrugByAlias:alias];
	dispatch_async(dispatch_get_main_queue(), ^
				   {
					   [self releadView];
				   });
	[pool drain];
	//[self performSelectorOnMainThread:@selector(releadView) withObject:nil waitUntilDone:NO];
}

-(void) releadView {
	NSLog(@"Reloading view, firstLoad: %d", self.firstLoad);
	[tableView reloadData];
	[activityView stopAnimating];
	self.loading.text = @"Atlikta";
	[UIView beginAnimations:@"tol" context:nil];
	self.toolbar.alpha = 0.0;
	self.loading.alpha = 0.0;
	[UIView commitAnimations];
	self.firstLoad = NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
	NSLog(@"vaizduojam eilute: %d, firstLoad: %d",[indexPath row], self.firstLoad);
	
	NSUInteger index = [indexPath row];
	
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if(cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero 
									   reuseIdentifier:CellIdentifier] autorelease];
	} 
	else {
		if(self.firstLoad) {
			AsyncImageView* oldImage = (AsyncImageView*) [cell viewWithTag:999];
			[oldImage removeFromSuperview];
		}
	}
	
	
	UILabel *title;
	UILabel *kaina;
	UIButton * button;
	UIButton * more;
	UILabel * gamintojas;
	UILabel *nevartoti;
	UILabel * compen;
	UILabel * recept;
	AsyncImageView *image;
	
	DrugIconsView * drugIconView;
	switch (index) {
		case 0:
			if(self.firstLoad){
				title = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 280, 50)];
				title.textColor =UIColorFromRGB(0x3D7DAE);
				title.numberOfLines = 2;
				title.lineBreakMode = UILineBreakModeWordWrap;
				title.font = [UIFont boldSystemFontOfSize:18];
				[title setText:self.drug.name];
				[cell addSubview:title];
				
				gamintojas = [[UILabel alloc] initWithFrame:CGRectMake(110,95 , 200, 80)];
				gamintojas.numberOfLines = 2;
				gamintojas.lineBreakMode = UILineBreakModeWordWrap;
				gamintojas.textColor =UIColorFromRGB(0x3D7DAE);
				[gamintojas setText:[NSString stringWithFormat:@"Gamintojas:\n%@", self.drug.manufacturer]];
				[cell addSubview:gamintojas];
			}
			
			kaina = [[UILabel alloc] initWithFrame:CGRectMake(110, 50, 200, 44)];
			kaina.textColor = UIColorFromRGB(0x3D7DAE);
			//kaina.backgroundColor = [UIColor clearColor];
			[kaina setText:[NSString stringWithFormat:@"Kaina apie %@ Lt",self.drug.price]];
			if(self.firstLoad) {
				[kaina setText:[NSString stringWithFormat:@"Kaina apie ... Lt",self.drug.price]];

			}
			[cell addSubview:kaina];
			
			if(self.firstLoad){
				
				
				UIImage * image2  = [UIImage imageNamed:[NSString stringWithFormat:@"rating%d.png",[[self.drug rating] intValue]]];
				
				UIImageView	 *iv = [[UIImageView alloc] initWithImage:image2];
				iv.frame = CGRectMake(110,95, image2.size.width, image2.size.height);
				[cell addSubview:iv];
				
				CGRect frame;
				frame.size.width=75; frame.size.height=75;
				frame.origin.x=20; frame.origin.y=60;
				
				//UIImageView * noImage = [[UIImageView alloc ]initWithImage:[UIImage imageNamed:@"no_photo"]];
//				image.frame = frame;
//				[cell addSubview:noImage];
				
				image = [[[AsyncImageView alloc]
						  initWithFrame:frame] autorelease];
				image.tag = 999;
				
				NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self.appDelegate.settings objectForKey:@"banner_location"],self.drug.banner]];
				[image loadImageFromURL:url];
				[cell addSubview:image];
				NSLog(@"DEDAM PAVAEIKSLIUKA");
				
			}
			
			break;
		case 1:
			compen = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 220, 20)];
			compen.textColor =UIColorFromRGB(0x3D7DAE);
			if([self.drug.comp isEqualToNumber:[NSNumber numberWithInt:1]]) {
				
				compen.text = @"Vaistas kompensuojamas";
			} else {
				compen.text = @"Vaistas nekompensuojamas";
			}
			[cell addSubview:compen];
			
			recept = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 220, 20)];
			recept.textColor =UIColorFromRGB(0x3D7DAE);
			if([self.drug.recept isEqualToNumber:[NSNumber numberWithInt:1]]) {
				
				recept.text = @"Receptinis vaistas";
			} else {
				recept.text = @"Nereceptinis vaistas";
			}
			[cell addSubview:recept];
			

			if([self.drug.noDrive boolValue] || [self.drug.noHeart boolValue] || [self.drug.noPregnant boolValue] || [self.drug.noChildren boolValue]) {
					nevartoti = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 160, 44)];
					nevartoti.textColor = UIColorFromRGB(0x3D7DAE);
					[nevartoti setText:@"Netinkamas: "];
					[cell addSubview:nevartoti];
			}
			drugIconView = [[DrugIconsView alloc] initWithFrame:CGRectMake(120, 5, 160, 44)];
			[drugIconView displayDrug:self.drug];
			//NSLog(@"frame: %@", NSStringFromCGRect(drugIconView.drive.frame));
			//NSLog(@"turetume deti iconkes");
			[cell addSubview:drugIconView];
			//[cell setText:@"det info"];	
			if([self.drug.anotacija_yra isEqualToNumber:[NSNumber numberWithInt:1]]) {
				more = [UIButton buttonWithType:UIButtonTypeCustom];
				more.frame = CGRectMake(200, 90, 100, 25);
				[more setBackgroundImage:[UIImage imageNamed:@"btMedium.png"] forState:UIControlStateNormal];
				[more setTitle:@"Plačiau" forState:UIControlStateNormal];
				[more addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchDown];
				
				[cell addSubview:more];
			}
				
			break;
		case 2:
			button = [UIButton buttonWithType:UIButtonTypeCustom];
			button.frame = CGRectMake(75, 10, 180, 25);
			[button setBackgroundImage:[UIImage imageNamed:@"btBig.png"] forState:UIControlStateNormal];
			[button setTitle:@"Artimiausios vaistinės" forState:UIControlStateNormal];
			[button addTarget:self action:@selector(nearestPharmacies:) forControlEvents:UIControlEventTouchDown];
			[cell addSubview:button];	
			break;
		default:
			break;
	}
	
	return cell;
}

-(void) more {
	AnnotationViewController *avc = [[AnnotationViewController alloc] init];
	avc.drug = self.drug;
	[self.navigationController pushViewController:avc animated:YES];
}

-(void) nearestPharmacies:(id)sender {
	PharmaciesViewController * pvc = [[PharmaciesViewController alloc] init];
	pvc.alias = self.drugAlias;
	[self.navigationController pushViewController:pvc animated:YES];
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
	
	NSUInteger row = [indexPath row];
	
	switch (row) {
		case 0:
			//[self.appDelegate.navigationController pushViewController:[[DrugListViewController alloc] init] animated:YES];
			break;
		case 1:
			
			break;
		case 2:
			
			
			break;
		default:
			break;
	}
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//self.drugs = [appDelegate.service searchForDrugsByName:@"validol"];
	return 3;	
	
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

	NSUInteger row = [indexPath row];
	
	switch (row) {
		case 0:				
			return 180.0f;
		case 1:
			if ([self.drug.anotacija_yra isEqualToNumber:[NSNumber numberWithInt:1]])
				 return 125.0f;
			return 100.0f;
		case 2:
			return 44.0f;
		default:
			break;
	}
	
	return 0;
	
	
}




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

- (void)dealloc {
	[tableView release];
	[drug release];
	[activityView release];
	[toolbar release];
	[loading release];
	[drugAlias release];
    [super dealloc];
}


@end
