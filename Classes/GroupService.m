//
//  GroupService.m
//  vaistai.lt
//
//  Created by hitt on 12/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GroupService.h"

@implementation GroupService

- (id) initWithPath:(NSString *)path
{
	[super init];
	GroupParser *gp = [[GroupParser alloc] init];
	arr  = [gp parse:path];
	//NSLog([arr description]);
	return self;
}

-(int) getParentGroupsCount {
	int count = arr.count, ret = 0;
	Group *grp;
	for(int i = 0; i < count; i++) {
		grp = [arr objectAtIndex:i];
		NSString *pr = (NSString *)grp.parentTitle;
		if(pr == NULL)
			ret++;
	}
	return ret;
}

-(int) getGroupsCount:(NSString *)parentGroup {
	return 0;
}

-(NSMutableArray *) getParentGroups {
	int count = arr.count;
	NSMutableArray *ret = [NSMutableArray array];
	Group *grp;
	for(int i = 0; i < count; i++) {
		grp = [arr objectAtIndex:i];
		NSString *pr = (NSString *)grp.parentTitle;
		if(pr == NULL) {
			[ret addObject:grp];
		}
	}
	return ret;
}

-(NSMutableArray *) getGroups:(NSString *)parentGroup {
	int count = arr.count;
	NSMutableArray *ret = [NSMutableArray array];
	Group *grp;
	NSString *parent;
	for(int i = 0; i < count; i++) {
		grp = [arr objectAtIndex:i];
		parent = (NSString *)grp.parentTitle;
		if([parent isEqualToString:parentGroup])
			[ret addObject:grp];
	}
	return ret;
}

- (void) dealloc {
	[arr dealloc];
	[super dealloc];
}

@end
