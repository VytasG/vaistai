//
//  DrugService.h
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class vaistai_ltAppDelegate;
@class DrugParser;
@class Drug;
@class PharmacyParser;
@class Pharmacy;

@interface DrugService : NSObject 
{
	vaistai_ltAppDelegate * appDelegate;
	DrugParser *drugParser;
	PharmacyParser * pharmacyParser;
}

-(NSArray *) searchForDrugsByName:(NSString *) searchString;
-(NSData *)jsonFromURLString:(NSString *)urlString;
-(NSString *) serviceURLString:(NSString *) serviceName;
-(Drug *) getDrugByAlias:(NSString *) alias;
-(Drug *) getDrugByBarcode:(NSString *) barcode;
-(NSArray *) searchForDrugsByGroup:(NSString *) groupName;
-(NSArray *) searchForPharmacyByDrug:(NSString *) alias latitude:(NSString *)latitude longitude:(NSString *)longitude;
-(Pharmacy *) getPharmacyByAlias:(NSString *) alias;

@property (nonatomic, retain) vaistai_ltAppDelegate * appDelegate;

@end