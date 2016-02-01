//
//  OmnitelViewController.m
//  vaistai.lt
//
//  Created by Vytautas on 1/18/11.
//  Copyright 2011 UAB "Informacinių Technologijų Organizacija". All rights reserved.
//

#import "OmnitelViewController.h"


@implementation OmnitelViewController

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"omni.jpg"]];
	
	UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
	myButton.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
	[myButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];	
	[self.view addSubview:myButton];
}

-(void)buttonPressed {
    [self dismissModalViewControllerAnimated:YES];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
    [super dealloc];
}


@end
