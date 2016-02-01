//
//  Drug.h
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Group;

@interface Drug :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * alias;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Group * group;

@end



