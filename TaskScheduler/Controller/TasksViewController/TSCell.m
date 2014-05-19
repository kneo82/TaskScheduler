//
//  TSCell.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/19/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSCell.h"

@implementation TSCell

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.label = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)restorationIdentifier {
    return NSStringFromClass([self class]);
}

@end
