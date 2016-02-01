//
//  GroupParser.m
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "vaistai_ltAppDelegate.h"
#import "GroupParser.h"
#import "Group.h"


@implementation GroupParser
@synthesize context;

-(NSMutableArray *) parse: (NSString *) dataFile {

	int nn = 0, nn1 = 0;
	NSArray *csvfiles = [NSArray arrayWithObjects:@"grupe1.csv", @"grupe2.csv", @"grupe3.csv", @"grupe4.csv", nil];
	
    NSMutableArray *arr = [[NSMutableArray alloc] init];
	if (self.context == nil) { self.context = [(vaistai_ltAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; }
	
	for(int ct = 0; ct < csvfiles.count; ct++) {
	
		NSString *csv = [csvfiles objectAtIndex:ct];
		NSString *df = [dataFile stringByAppendingPathComponent:csv];
		NSString *str = [NSString stringWithContentsOfFile:df encoding:NSUTF8StringEncoding error:nil];
		NSArray *dataRows = [str componentsSeparatedByString:@"\n"];
		
		Group *card;
		
		for (int i = 0 ; i < [dataRows count] ; i++) {
			NSArray *dataElements = [[dataRows objectAtIndex:i] 
									 componentsSeparatedByString:@"\",\""];
			
			card = (Group*)[NSEntityDescription insertNewObjectForEntityForName:@"Group" 
														 inManagedObjectContext:[self context]];
			
				if ([dataElements count] >= 2) {
						
					NSString *al = (NSString *)[dataElements objectAtIndex:0];
					NSString *nm = (NSString *)[dataElements objectAtIndex:1];
					
					[card setAlias:[al stringByReplacingOccurrencesOfString:@"\"" withString:@""]];
					[card setName:[nm stringByReplacingOccurrencesOfString:@"\"" withString:@""]];
					
					if ([dataElements count] >= 3) {
						NSString *tmp = [dataElements objectAtIndex:2];
						[card setParentTitle:[tmp stringByReplacingOccurrencesOfString:@"\"" withString:@""]];
					}
					if([dataElements count] == 2)
						nn1++;
			
				[arr  addObject:card];
				//NSLog([card description]);
			}
		}
	}
	
	//NSLog(@"Number of items: %d", [arr count]);
	//NSLog(@"Number of items without parents: %d, csv lines of two cols: %d, act: %d", nn, nn1);
	return arr;
	
}

-(id) GetGroupByName:(NSString *)name inArray:(NSMutableArray *)arr {
	int count = arr.count;
	
	Group *card;
	for(int ct = 0; ct < count; ct++) {
		card = [arr objectAtIndex:ct];
		NSString *ttl = card.name;
		if([ttl isEqualToString:name])
		   return card;
	}
	return NULL;
}

@end
