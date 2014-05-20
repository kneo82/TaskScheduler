//
//  TSNewTaskViewController.m
//  TaskScheduler
//
//  Created by Vitaliy Voronok on 5/19/14.
//  Copyright (c) 2014 Vitaliy Voronok. All rights reserved.
//

#import "TSNewTaskViewController.h"
#import "TSNewTaskView.h"
#import "TSUser.h"
#import "TSTask.h"
#import "TSRuleType.h"
#import "IDPActiveRecordKit.h"

#import "TSRuleOnceYear.h"
#import "TSRuleOnceWeek.h"
#import "TSRuleOnceMonth.h"
#import "TSRuleOnceDay.h"

#import "IDPActiveRecordKit.h"
#import "UIViewController+IDPInitialization.h"
#import "UIViewController+IDPExtensions.h"

@interface TSNewTaskViewController ()
@property (nonatomic, readonly) TSNewTaskView   *taskView;
@property (nonatomic, retain)   NSDictionary    *taskRules;
@property (nonatomic, retain)   TSUser          *user;
//@property (nonatomic, retain)   TSRuleType      *selectedRule;

@end

@implementation TSNewTaskViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.taskRules = nil;
    self.date = nil;
    self.user = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Accessors

IDPViewControllerViewOfClassGetterSynthesize(TSNewTaskView, taskView);

#pragma mark -
#pragma mark Private

- (void)setup {
    UIBarButtonItem *saveEventButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveEvent)];
    [saveEventButton autorelease];
    
    self.navigationItem.rightBarButtonItem = saveEventButton;
    
    TSUser *user = [TSUser managedObject];
    self.user = user;
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:NSStringFromClass([TSRuleOnceDay class]) forKey:@"Once a Day"];
    [dictionary setObject:NSStringFromClass([TSRuleOnceWeek class]) forKey:@"Once a Week"];
    [dictionary setObject:NSStringFromClass([TSRuleOnceMonth class]) forKey:@"Once a Month"];
    [dictionary setObject:NSStringFromClass([TSRuleOnceYear class]) forKey:@"Once a Year"];
    
//    NSArray *keys = [dictionary allKeys];
//    for (NSString *key in keys) {
//        TSRuleType *rule = nil;
//        rule = [TSRuleType managedObjectForKey:[dictionary objectForKey:key]];
//        if (!rule.ruleType) {
//            rule.ruleType = NSStringFromClass([TSUser class]);
//            [user addRuleType:rule];
//        }
//        [dictionary setObject:rule forKey:key];
//    }
    
    self.taskRules = dictionary;
}

- (void)saveEvent {
    TSRuleType *rule = nil;
    NSArray *keys = [self.taskRules allKeys];
    NSString *selectedKey = keys[[self.taskView.rulePicker selectedRowInComponent:0]];
    rule = [TSRuleType managedObjectForKey:[self.taskRules objectForKey:selectedKey]];
    if (!rule.ruleType) {
        rule.ruleType = NSStringFromClass([TSUser class]);
        [self.user addRuleType:rule];
    }
    
    TSTask *task = [TSTask managedObject];
    task.title = self.taskView.titleTextField.text;
    task.date = self.date;
    [rule addTask:task];
    
    [self.user saveManagedObject];
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.taskRules count];
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    NSArray *keys = [self.taskRules allKeys];

    return keys[row];
}

//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    NSArray *keys = [self.taskRules allKeys];
//    
//    TSRuleType *rule = [self.taskRules objectForKey:keys[row]];
//    
//    NSLog(@"************##############  %@", keys[row]);
//}

@end
