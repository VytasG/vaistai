//
//  Group.h
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-12.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Drug;

@interface Group :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * parentTitle;
@property (nonatomic, retain) NSString * alias;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet* drugs;
@property (nonatomic, retain) Group * parent;

@end


@interface Group (CoreDataGeneratedAccessors)
- (void)addDrugsObject:(Drug *)value;
- (void)removeDrugsObject:(Drug *)value;
- (void)addDrugs:(NSSet *)value;
- (void)removeDrugs:(NSSet *)value;

@end

