//
//  TSTask.h
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/14/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TSRuleType;

@interface TSTask : NSManagedObject 
@property (nonatomic, retain) NSDate        *date;
@property (nonatomic, retain) NSString      *title;
@property (nonatomic, retain) TSRuleType    *ruleType;

@end
