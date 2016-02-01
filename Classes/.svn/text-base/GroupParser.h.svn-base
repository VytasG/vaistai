//
//  GroupParser.h
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface GroupParser : NSObject {
	NSManagedObjectContext * context;
	//NSMutableArray *arr;
}

-(NSMutableArray *) parse: (NSString *) dataFile;

@property(nonatomic,retain) NSManagedObjectContext * context;

-(id) GetGroupByName:(NSString *)name inArray:(NSMutableArray *)arr;
@end
