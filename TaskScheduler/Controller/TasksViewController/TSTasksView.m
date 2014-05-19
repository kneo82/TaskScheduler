//
//  TSTasksView.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/19/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSTasksView.h"

@implementation TSTasksView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.table = nil;

    [super dealloc];
}

@end
