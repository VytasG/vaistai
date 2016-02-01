//
//  vaistai_ltAppDelegate.m
//  vaistai.lt
//
//  Created by Andriukas on 2010-12-11.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "vaistai_ltAppDelegate.h"
#import "RootViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "OmnitelViewController.h"
#import "Reachability.h"

@implementation UINavigationBar (UINavigationBarCategory)

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx 
{
	if([self isMemberOfClass:[UINavigationBar class]])
	{
		UIImage *image = [UIImage imageNamed:@"bg_top_2.jpg"];
		CGContextClip(ctx);
		CGContextTranslateCTM(ctx, 0, image.size.height);
		CGContextScaleCTM(ctx, 1.0, -1.0);
		CGContextDrawImage(ctx,
						   CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), image.CGImage); 
	}
	else 
	{        
		[super drawLayer:layer inContext:ctx];     
	}
}  

@end

@implementation vaistai_ltAppDelegate

@synthesize window;
@synthesize navigationController;

@synthesize settings,service,groups, UID, connection, allow, internetReachable;

#pragma mark -
#pragma mark Application lifecycle

- (void)backButtonPressed {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)awakeFromNib {    
    
//    RootViewController *rootViewController = (RootViewController *)[navigationController topViewController];
  //  rootViewController.managedObjectContext = self.managedObjectContext;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	//init services
	NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"Settings.plist"];
    self.settings = [NSDictionary dictionaryWithContentsOfFile:finalPath];
	
	self.service = [[DrugService alloc] init];
	
	self.groups = [[GroupService alloc] initWithPath:path];
	
	// Generuojam unikalų ID
	NSString *myStr = [NSString stringWithFormat:@"%@%@", [[UIDevice currentDevice] uniqueIdentifier], @"vaistai"];
	const char *cStr = [myStr UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
	NSString *md5str = [NSString stringWithFormat:
						@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
						result[0], result[1], result[2], result[3], 
						result[4], result[5], result[6], result[7],
						result[8], result[9], result[10], result[11],
						result[12], result[13], result[14], result[15]
						]; 
	self.UID = md5str;
	NSLog(@"UID: %@", self.UID);
	
	// Tikrinam carrier
	CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
	CTCarrier *carrier = [netinfo subscriberCellularProvider];
//	NSString *carrierStr = [[carrier carrierName] lowercaseString];
//	NSLog(@"Carrier: %@", carrierStr);
//	if ([carrierStr isEqual:@"omnitel"] || [carrierStr isEqual:@"ezys"] || [carrierStr isEqual:@"extra"])
//		self.allow = YES;
//	else
//		self.allow = NO;
    NSString *MCC = [carrier mobileCountryCode];
    NSString *MNC = [carrier mobileNetworkCode];
    NSLog(@"MCC: %@, MNC: %@", MCC, MNC);
    if ([MCC isEqualToString:@"246"])
    {
        if ([MNC isEqual:@"02"] || [MNC isEqual:@"03"])
        {
            self.allow = NO;
        }
        else
        {
            self.allow = YES;
        }
    }
    else
    {
        self.allow = YES;
    }
	[netinfo release];
	
	
	// Tikrinam ryšį
	self.internetReachable = [Reachability reachabilityForInternetConnection];
	[self.internetReachable startNotifier];
	NetworkStatus internetStatus = [self.internetReachable currentReachabilityStatus];
	switch (internetStatus)
	{
		case NotReachable:
		{
			NSLog(@"The internet is down.");
			self.connection = NO;
			break;
		}
		case ReachableViaWiFi:
		{
			NSLog(@"The internet is working via WIFI.");
			self.connection = YES;
			break;
		}
		case ReachableViaWWAN:
		{
			NSLog(@"The internet is working via WWAN.");
			self.connection = YES;
			break;
		}
	}
	
	// Debuginimui reikia atkomentuot, nes kitaip simuliatoriuj neveiks :)
	self.allow = YES;
	
	if (self.allow == YES && self.connection == NO) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Dėmesio" 
														message:@"Programa negali prisijungti prie duomenų bazės. Be interneto ryšio programa neveiks." 
													   delegate:nil 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	
    // Add the navigation controller's view to the window and display.
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    [self saveContext];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}


- (void)saveContext {
    
    NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}    


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
    
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"vaistai_lt" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"vaistai_lt.sqlite"];
	//NSURL *storeURL = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"vaistai_lt.sqlite"]];

    //NSURL *storeURL = [NSURL fileURLWithPath: [[[self applicationDocumentsDirectory] absoluteString] stringByAppendingPathComponent:@"vaistai_lt.sqlite"] ];
	//NSLog([storeURL description]);
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator_;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
	
	//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString *documentsDirectory = [paths objectAtIndex:0];
//	if (!documentsDirectory) {
//		NSLog(@"Documents directory not found!"); 
//	}    
//	return documentsDirectory;
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    
    [navigationController release];
    [window release];
	[UID release];
	[internetReachable release];
	
    [super dealloc];
}

@end

