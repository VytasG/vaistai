//
//  Drug.h
//  vaistai.lt
//
//  Created by Vytautas on 1/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Group;

@interface Drug :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSNumber * noDrive;
@property (nonatomic, retain) NSNumber * comp;
@property (nonatomic, retain) NSNumber * noHeart;
@property (nonatomic, retain) NSNumber * noPregnant;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) NSString * banner;
@property (nonatomic, retain) NSString * alias;
@property (nonatomic, retain) NSString * manufacturer;
@property (nonatomic, retain) NSNumber * noChildren;
@property (nonatomic, retain) NSNumber * recept;
@property (nonatomic, retain) NSString * anotacija;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Group * group;

@end



