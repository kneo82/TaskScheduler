//
//  TSRuleType.h
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/14/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TSTask;

@interface TSRuleType : NSManagedObject
@property (nonatomic, retain) NSString  *ruleType;
@property (nonatomic, retain) NSSet     *tasksSet;
@property (nonatomic, retain) NSArray   *tasks;

@end

@interface TSRuleType (CoreDataGeneratedAccessors)

- (void)addTask:(TSTask *)value;
- (void)removeTask:(TSTask *)value;
- (void)addTasksSet:(NSSet *)values;
- (void)removeTasksSet:(NSSet *)values;

@end
