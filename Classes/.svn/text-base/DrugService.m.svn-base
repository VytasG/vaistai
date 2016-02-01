//
//  DrugService.m
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DrugService.h"
#import "vaistai_ltAppDelegate.h"
#import "DrugParser.h"
#import "Drug.h"

#import "Pharmacy.h"
#import "PharmacyParser.h"


@implementation DrugService
@synthesize appDelegate;



- (id)init {
	if (self = [super init]) {
		self.appDelegate = [[UIApplication sharedApplication] delegate];
		drugParser = [[DrugParser alloc] init]; 
		drugParser.context = self.appDelegate.managedObjectContext;
		
		pharmacyParser = [[PharmacyParser alloc] init]; 
		pharmacyParser.context = self.appDelegate.managedObjectContext;

	
	}
	return self;
}


/*- (NSData *)jsonFromURLString:(NSString *)urlString {
	NSURL *url = [NSURL URLWithString:urlString]; 
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url]; 
	[request setHTTPMethod:@"GET"];
	NSLog(@"request url: %@",urlString);
	NSURLResponse *response = nil;
	NSError *error = nil;
	NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error]; 
	[request release]; 
	if (error) {
		NSLog(@"ERROR fetching string");
		return nil;
	}
	return result;
}*/

- (NSData *)jsonFromURLString:(NSString *)urlString {
	NSURL *url = [NSURL URLWithString:urlString]; 
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20]; 
	[request setHTTPMethod:@"GET"];
	NSLog(@"request url: %@",urlString);
	NSURLResponse *response = nil;
	NSError *error = nil;
	NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error]; 
	[request release]; 
	/*if ([error code] == NSURLErrorNotConnectedToInternet) {
		NSLog(@"ERROR - NO CONNECTION!");
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Klaida" 
														message:@"Nėra ryšio su duomenų baze" 
													   delegate:nil 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		return nil;
	}*/
	return result;
}

-(NSArray *) searchForDrugsByName:(NSString *) searchString {

	NSString * searchDrugsServiceURL = [self serviceURLString:@"drug_search"];	
	NSString * url = [NSString stringWithFormat:searchDrugsServiceURL, [searchString stringByAddingPercentEscapesUsingEncoding:
																		NSASCIIStringEncoding], appDelegate.UID];
    NSLog(@"linkas: %@", url);
	
	NSArray * array  = [drugParser parseJSON:[self	jsonFromURLString:url]];
	//NSLog([array description]);
	return array;
	
}

  
-(Drug *) getDrugByAlias:(NSString *) alias {
	
	NSString * searchDrugsServiceURL = [appDelegate.settings objectForKey:@"drug_anotation_ito"];	
	NSString * url = [NSString stringWithFormat:searchDrugsServiceURL, alias, appDelegate.UID];
	NSLog(@"linkas: %@", url);
	
	return  [drugParser parseDrugJSON:[self jsonFromURLString:url]];
	//return array;
	
}

// gauname drug pagal barkodą
-(Drug *) getDrugByBarcode:(NSString *) barcode {
	
	NSString * searchDrugsServiceURL = [appDelegate.settings objectForKey:@"drug_barcode_ito"];
	NSString * url = [NSString stringWithFormat:searchDrugsServiceURL, barcode, appDelegate.UID];
	NSLog(@"linkas: %@", url);
	
	NSLog(@"DRUG: %@", [[drugParser parseDrugJSON:[self jsonFromURLString:url]] description]);
	return [drugParser parseDrugJSON:[self jsonFromURLString:url]];
}
// --

-(NSArray *) searchForPharmacyByDrug:(NSString *) alias latitude:(NSString *)latitude longitude:(NSString *)longitude {
	
	NSString * searchDrugsServiceURL = [self serviceURLString:@"pharmacies"];	
	NSString * url = [NSString stringWithFormat:searchDrugsServiceURL, alias, latitude, longitude, appDelegate.UID];
	NSLog(@"linkas: %@", url);
	
	NSArray * array  = [pharmacyParser parseJSON:[self jsonFromURLString:url]];
	return array;
}



-(Pharmacy *) getPharmacyByAlias:(NSString *) alias {
	
	NSString * searchDrugsServiceURL =  [self serviceURLString:@"pharmacy_info"];	
	NSString * url = [NSString stringWithFormat:searchDrugsServiceURL, alias, appDelegate.UID];
	NSLog(@"linkas: %@", url);
	
	return  [pharmacyParser parsePharmacyJSON:[self jsonFromURLString:url]];
	//return array;
	
}

-(NSArray *) searchForDrugsByGroup:(NSString *) groupName {
	
	NSString * searchDrugsServiceURL = [self serviceURLString:@"grupe"];	
	NSString * url = [NSString stringWithFormat:searchDrugsServiceURL, [groupName stringByAddingPercentEscapesUsingEncoding:
																		NSASCIIStringEncoding], appDelegate.UID];
	NSLog(@"linkas: %@", url);
	
	NSArray * array  = [drugParser parseJSON:[self	jsonFromURLString:url]];
	//NSLog([array description]);
	return array;
}

-(NSString *) serviceURLString:(NSString *) serviceName {
	
	return [NSString stringWithFormat:@"%@%@",[appDelegate.settings objectForKey:@"server"],[appDelegate.settings valueForKey:serviceName]];
}


@end
