//
//  PharmacyParser.h
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-12.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Pharmacy;


@interface PharmacyParser : NSObject {

	NSManagedObjectContext * context;
}

-(NSArray *) parseJSON:(NSData *) stringJSON;
-(Pharmacy *) parsePharmacyJSON:(NSData *) stringJSON;

@property(nonatomic,retain) NSManagedObjectContext * context;

@end
