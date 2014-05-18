//
//  TSCalendarView.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/13/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSCalendarView.h"

@implementation TSCalendarView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.calendar = nil;
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

#pragma mark -
#pragma mark View Lifecycle

- (void)awakeFromNib {
    
}


@end
