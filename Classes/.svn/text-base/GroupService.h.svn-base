//
//  GroupService.h
//  vaistai.lt
//
//  Created by hitt on 12/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupParser.h"
#import "Group.h"

@interface GroupService : NSObject {
	NSMutableArray *arr;
}

- (id) initWithPath:(NSString *)path;

-(int) getParentGroupsCount;
-(int) getGroupsCount:(NSString *)parentGroup;
-(NSMutableArray *) getParentGroups;
-(NSMutableArray *) getGroups:(NSString *)parentGroup;

@end
