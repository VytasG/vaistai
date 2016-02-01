//
//  DrugParser.h
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@class Drug;


@interface DrugParser : NSObject {
	NSManagedObjectContext * context;
}

-(NSArray *) parseJSON:(NSData *) stringJSON;
-(Drug *) parseDrugJSON:(NSData *) stringJSON;

@property(nonatomic,retain) NSManagedObjectContext * context;
@end
