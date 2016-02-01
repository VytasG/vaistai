//
//  DrugParser.m
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DrugParser.h"
#import "CJSONDeserializer.h"

#import "Drug.h"


@implementation DrugParser
@synthesize context;

-(NSArray *) parseJSON:(NSData *) stringJSON {

	CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
	NSError *error;

	NSDictionary *resultsDictionary = [jsonDeserializer deserializeAsDictionary:stringJSON error:&error];	
	//NSLog([resultsDictionary description]);
	
	Drug * drug;
	NSMutableArray * ret = [[NSMutableArray alloc] init];
//	NSLog([resultsDictionary description]);
	
	if([[resultsDictionary objectForKey:@"rows"] isKindOfClass:[NSArray class]]){
	
		for (NSDictionary * row in [resultsDictionary objectForKey:@"rows"]) {
			drug = (Drug *)[NSEntityDescription insertNewObjectForEntityForName:@"Drug" 
													inManagedObjectContext:[self context]];
			drug.alias = [row objectForKey:@"alias"];
			drug.name = [row objectForKey:@"pavadinimas"];
			drug.banner = [row objectForKey:@"baneris"];
			drug.price = [row objectForKey:@"kaina"];
			drug.manufacturer = [row objectForKey:@"gamintojas"];		
			drug.rating = [NSNumber numberWithInt:[[row objectForKey:@"reitingas"] intValue]];
			if([[row objectForKey:@"kompensuojamas"] isEqualToNumber:[NSNumber numberWithInt:1]])
				drug.comp = [NSNumber numberWithInt:1];
			else
				drug.comp = [NSNumber numberWithInt:0];
			if([[row objectForKey:@"receptinis"] isEqualToNumber:[NSNumber numberWithInt:1]]) 
				drug.recept = [NSNumber numberWithInt:1];
			else
				drug.recept = [NSNumber numberWithInt:0];
			if([[row objectForKey:@"anotacija_yra"] isEqualToNumber:[NSNumber numberWithInt:1]])
				drug.anotacija_yra = [NSNumber numberWithInt:1];
			else
				drug.anotacija_yra = [NSNumber numberWithInt:0];
			drug.anotacija = [row objectForKey:@"anotacija"];
			[ret addObject:drug];
		}
	}
	return ret;
}


-(Drug *) parseDrugJSON:(NSData *) stringJSON {

	CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
	NSError *error;
	NSDictionary *resultsDictionary = [jsonDeserializer deserializeAsDictionary:stringJSON error:&error];	

	Drug * drug = (Drug *)[NSEntityDescription insertNewObjectForEntityForName:@"Drug" 
													 inManagedObjectContext:[self context]];
	
	drug.alias = [resultsDictionary objectForKey:@"alias"];
	drug.name = [resultsDictionary objectForKey:@"pavadinimas"];
	drug.manufacturer = [resultsDictionary objectForKey:@"gamintojas"];
	drug.price = [resultsDictionary objectForKey:@"kaina"];
	drug.noDrive = [resultsDictionary objectForKey:@"not_drive"];
	drug.noChildren = [resultsDictionary objectForKey:@"not_children"];
	drug.noPregnant = [resultsDictionary objectForKey:@"not_pregnant"];
	drug.noHeart = [resultsDictionary objectForKey:@"not_heart"];
	if ([[resultsDictionary objectForKey:@"kompensuojamas"] isEqualToNumber:[NSNumber numberWithInt:1]]) 
		drug.comp = [NSNumber numberWithInt:1];
	else
		drug.comp = [NSNumber numberWithInt:0];
	if ([[resultsDictionary objectForKey:@"receptinis"] isEqualToNumber:[NSNumber numberWithInt:1]]) 
		drug.recept = [NSNumber numberWithInt:1];
	else
		drug.recept = [NSNumber numberWithInt:0];
	if([[resultsDictionary objectForKey:@"anotacija_yra"] isEqualToNumber:[NSNumber numberWithInt:1]])
		drug.anotacija_yra = [NSNumber numberWithInt:1];
	else
		drug.anotacija_yra = [NSNumber numberWithInt:0];
	drug.anotacija = [resultsDictionary objectForKey:@"anotacija"];
	
	return drug;
}

@end
