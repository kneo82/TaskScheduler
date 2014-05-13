//
//  TSAppDelegate.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/13/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSAppDelegate.h"

#import "UIWindow+TDExtensions.h"

@interface TSAppDelegate ()

@end

@implementation TSAppDelegate

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.window = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark View Lifecycle

-           (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [UIWindow window];
    UIWindow *window = self.window;
    
  
//    [IDPCoreDataManager sharedManagerWithMomName:kTDStoreName];
    
//    UINavigationController *controller = nil;
//    controller = [[UINavigationController alloc] initWithRootViewController:loginController];
//    [controller autorelease];
    
//    window.rootViewController = controller;
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
//    TDSession *session = [TDSession managedObject];
//    [session saveManagedObject];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
//    TDSession *session = [TDSession managedObject];
//    [session saveManagedObject];
}


@end

