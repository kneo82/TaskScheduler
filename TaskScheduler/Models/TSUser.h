//
//  TSUser.h
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/18/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TSRuleType;

@interface TSUser : NSManagedObject
@property (nonatomic, retain)   NSSet   *ruleTypeSet;
@property (nonatomic, retain)   NSArray *rulesType;

@end

@interface TSUser (CoreDataGeneratedAccessors)

- (void)addRuleType:(TSRuleType *)value;
- (void)removeRuleType:(TSRuleType *)value;
- (void)addRuleTypeSet:(NSSet *)values;
- (void)removeRuleTypeSet:(NSSet *)values;

@end
