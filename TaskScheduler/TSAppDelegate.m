//
//  TSAppDelegate.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/13/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSAppDelegate.h"
#import "TSCalendarViewController.h"

#import "IDPCoreDataManager.h"
#import "NSManagedObject+IDPExtensions.h"

#import "UIWindow+TDExtensions.h"
#import "UIViewController+IDPInitialization.h"

#import "TSTask.h"
#import "TSRuleType.h"

static NSString * const kTSStoreName = @"TaskScheduler";

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
  
    [IDPCoreDataManager sharedManagerWithMomName:kTSStoreName];
    
    TSCalendarViewController *calendarController = [TSCalendarViewController viewControllerWithDefaultNib];
    
    UINavigationController *controller = nil;
    controller = [[UINavigationController alloc] initWithRootViewController:calendarController];
    [controller autorelease];
    
    window.rootViewController = controller;
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
    
    
    
//    TSRuleType *ruleOnceDay = [TSRuleType managedObject];
//
//    ruleOnceDay.ruleType = @"TSRuleOnceDay";
//    
//    TSRuleType *ruleOnceMonth = [TSRuleType managedObject];
//
//    ruleOnceMonth.ruleType = @"TSRuleOnceMonth";
//    
//    TSRuleType *ruleOnceWeek = [TSRuleType managedObject];
//
//    ruleOnceWeek.ruleType = @"TSRuleOnceWeek";
//    
//    TSRuleType *ruleOnceYear = [TSRuleType managedObject];
//
//    ruleOnceYear.ruleType = @"TSRuleOnceYear";
//    
//    TSTask *task1 = [TSTask managedObject];
//    task1.date = [NSDate date];
//    
//    [ruleOnceYear addTask:task1];
//    
//    TSTask *task2 = [TSTask managedObject];
//    task2.date =  [task1.date dateByAddingTimeInterval:24*60*60];
//    
//    [ruleOnceYear addTask:task2];
//    
//    TSTask *task3 = [TSTask managedObject];
//    task3.date =  task2.date;
//    [ruleOnceWeek addTask:task3];
//
//    [ruleOnceYear saveManagedObject];
//    [ruleOnceWeek saveManagedObject];
//    [ruleOnceMonth saveManagedObject];
//    [ruleOnceDay saveManagedObject];
//    
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

