//
//  TSCalendarView.h
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/13/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ABCalendarPicker/ABCalendarPicker.h>

@interface TSCalendarView : UIView
@property (nonatomic, retain) IBOutlet ABCalendarPicker *calendar;

@end
