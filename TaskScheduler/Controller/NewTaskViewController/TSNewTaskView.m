//
//  TSNewTaskView.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/19/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSNewTaskView.h"

@implementation TSNewTaskView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.dateLable = nil;
    self.rulePicker = nil;
    self.titleTextField = nil;
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


@end
