//
//  DrugIconsView.m
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-12.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DrugIconsView.h"
#import "Drug.h"

@implementation DrugIconsView
@synthesize drug;
@synthesize heart,children,drive,pregnant;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		self.heart = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"not_heart.png"]];
		self.children = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"not_children.png"]];
		self.drive = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"not_drive.png"]];
		self.pregnant = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"not_pregnant.png"]];
		
		[self addSubview:heart];
		[self addSubview:children];
		[self addSubview:drive];
		[self addSubview:pregnant];
	}
    return self;
}

-(void) displayDrug:(Drug *) _drug {
	
	int i = 0;
	
	if([_drug.noDrive boolValue]) {
		NSLog(@"nodrive");
		self.drive.frame = CGRectMake(i*44, 0, 44,44);
		i++;

	} else {
		[self.drive removeFromSuperview];
	}
	if([_drug.noChildren boolValue]) {
		NSLog(@"noChildren");

		self.children.frame = CGRectMake(i*44, 0, 44,44);
		i++;

	}	 else {
		[self.children removeFromSuperview];
	}
	
	if([_drug.noHeart boolValue]) {
		NSLog(@"noHeart");

		self.heart.frame = CGRectMake(i*44, 0, 44,44);
		i++;

	} else {
		[self.heart removeFromSuperview];
	}
	
	if([_drug.noPregnant boolValue]) {
		NSLog(@"noPregnant");

		self.pregnant.frame = CGRectMake(i*44, 0, 44,44);
		i++;

	} else {
		[self.pregnant removeFromSuperview];
	}
	
	
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
