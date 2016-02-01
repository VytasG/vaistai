//
//  vaistai_ltAppDelegate.h
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DrugService.h"
#import "GroupService.h"

@class Reachability;

@interface vaistai_ltAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	
	NSDictionary * settings;
	
	NSString *UID;
	BOOL connection;
	BOOL allow;
	
	Reachability *internetReachable;

@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}


@property (nonatomic, retain) NSDictionary * settings;
@property (nonatomic, retain) DrugService * service;
@property (nonatomic, retain) GroupService *groups;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) NSString *UID;
@property BOOL connection;
@property BOOL allow;

@property (nonatomic, retain) Reachability *internetReachable;

- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;
- (void)backButtonPressed;

@end

