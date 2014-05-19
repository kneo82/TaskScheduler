//
//  TSUser.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/18/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSUser.h"
#import "TSRuleType.h"

#import "IDPActiveRecordKit.h"

#import "NSObject+IDPOCExtensions.h"

static NSString * const kTSRuleTypeSet = @"ruleTypeSet";

@implementation TSUser

@dynamic ruleTypeSet;
@dynamic rulesType;

#pragma mark -
#pragma mark Class Methods

+ (id)managedObject {
    NSArray *array = [self fetchEntityWithSortDescriptors:nil
                                                predicate:nil
                                            prefetchPaths:nil];
    
    TSUser *result = nil;
    
    if (0 != [array count]) {
        result = [array firstObject];
    } else {
        result = [super managedObject];
    }
    
    return  result;
}

#pragma mark -
#pragma mark Accessors

- (void)setRulesType:(NSArray *)rulesType {
    [self setCustomValue:[NSSet setWithArray:rulesType]
                  forKey:NSStringFromSelector(@selector(rulesType))];
}

- (NSArray *)rulesType {
    NSSet *result = [self customValueForKey:NSStringFromSelector(@selector(rulesType))];
    return [result allObjects];
}

- (void)addRuleType:(TSRuleType *)value {
    [self addCustomValue:value inMutableSetForKey:kTSRuleTypeSet];
}

- (void)removeRuleType:(TSRuleType *)value {
    [value deleteManagedObject];
}

#pragma mark -
#pragma mark Public

- (BOOL)isHasRuleType:(NSString *)ruleType {
    for (TSRuleType *rule in self.rulesType) {
        if ([rule.ruleType isEqualToString:ruleType]) {
            return YES;
        }
    }
    
    return NO;
}

@end
