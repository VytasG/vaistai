//
//  DrugParser.m
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PharmacyParser.h"
#import "CJSONDeserializer.h"

#import "Pharmacy.h"


@implementation PharmacyParser
@synthesize context;

-(NSArray *) parseJSON:(NSData *) stringJSON {
	
	CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
	NSError *error;
	
	NSDictionary *resultsDictionary = [jsonDeserializer deserializeAsDictionary:stringJSON error:&error];	
	//NSLog([resultsDictionary description]);
	
	Pharmacy * pharmacy;
	NSMutableArray * ret = [[NSMutableArray alloc] init];
	//	NSLog([resultsDictionary description]);
	if ([[[resultsDictionary objectForKey:@"1"] objectForKey:@"vaistines"] count] > 19)
	{
		if([[resultsDictionary objectForKey:@"1"] isKindOfClass:[NSDictionary class]]){
			//NSLog([[resultsDictionary objectForKey:@"2"] description]);
			for (NSDictionary * row in [[resultsDictionary objectForKey:@"1"] objectForKey:@"vaistines"]) {
				pharmacy = (Pharmacy *)[NSEntityDescription insertNewObjectForEntityForName:@"Pharmacy" 
																	 inManagedObjectContext:[self context]];
			
				pharmacy.alias = [row objectForKey:@"alias"];
				pharmacy.firm = [row objectForKey:@"Firma"];
				pharmacy.longitude = [row objectForKey:@"google_lng"];
				pharmacy.latitude = [row objectForKey:@"google_lat"];
				
				pharmacy.address = [row objectForKey:@"Adresas"];
				
				[ret addObject:pharmacy];
			}
		}
	}
	else
	{
		if([[resultsDictionary objectForKey:@"2"] isKindOfClass:[NSDictionary class]]){
			//NSLog([[resultsDictionary objectForKey:@"2"] description]);
			for (NSDictionary * row in [[resultsDictionary objectForKey:@"2"] objectForKey:@"vaistines"]) {
				pharmacy = (Pharmacy *)[NSEntityDescription insertNewObjectForEntityForName:@"Pharmacy" 
																	 inManagedObjectContext:[self context]];
				
				pharmacy.alias = [row objectForKey:@"alias"];
				pharmacy.firm = [row objectForKey:@"Firma"];
				pharmacy.longitude = [row objectForKey:@"google_lng"];
				pharmacy.latitude = [row objectForKey:@"google_lat"];
				
				pharmacy.address = [row objectForKey:@"Adresas"];
				
				[ret addObject:pharmacy];
			}
		}
	}
	return ret;
}


-(Pharmacy *) parsePharmacyJSON:(NSData *) stringJSON {
	
	CJSONDeserializer *jsonDeserializer = [CJSONDeserializer deserializer];
	NSError *error;
	//NSLog(@"ASDFADF");
	NSDictionary *resultsDictionary = [jsonDeserializer deserializeAsDictionary:stringJSON error:&error];	
	NSLog([resultsDictionary description]);
	
	Pharmacy * pharmacy = (Pharmacy *)[NSEntityDescription insertNewObjectForEntityForName:@"Pharmacy" 
														inManagedObjectContext:[self context]];
	
	pharmacy.alias = [resultsDictionary objectForKey:@"alias"];
	pharmacy.firm = [resultsDictionary objectForKey:@"Firma"];
	pharmacy.longitude = [resultsDictionary objectForKey:@"google_lng"];
	pharmacy.latitude = [resultsDictionary objectForKey:@"google_lat"];
	pharmacy.address = [resultsDictionary objectForKey:@"Adresas"];
	pharmacy.phones = [resultsDictionary objectForKey:@"Telefonai"];

	
	
	return pharmacy;
}

@end
