//
//  TSFindeTasks.h
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/15/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPModel.h"

@interface TSFindTasks : IDPModel
@property (nonatomic, retain)   NSDate  *startDate;
@property (nonatomic, retain)   NSDate  *endDate;

- (void)findTasks;

@end
