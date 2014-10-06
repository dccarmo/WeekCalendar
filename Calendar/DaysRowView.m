//
//  DaysRowView.m
//  Calendar
//
//  Created by Diogo do Carmo on 10/5/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import "DaysRowView.h"

//View
#import "DaysRowColumnView.h"

//Support
#import "NSDate+Calculations.h"

static const NSUInteger updateInterval = 60;

@interface DaysRowView ()

@property (nonatomic) NSMutableArray *daysRowColumnDescriptions;
@property (nonatomic) NSTimer *currentDayTimer;

@end

@implementation DaysRowView

+ (DaysRowView *)daysRowViewFrom:(NSDate *)fromDate to:(NSDate *)toDate
{
    NSInteger numberOfDays = [fromDate numberOfDaysUntil:toDate];
    
    DaysRowView *daysRowView = [[DaysRowView alloc] initWithFrame:CGRectMake(0, 0, [DaysRowColumnView expectedWidth] * numberOfDays, [DaysRowColumnView expectedHeight])];
    
    for (NSUInteger i = 0; i < numberOfDays; i++) {
        DaysRowColumnView *daysRowColumnView = [DaysRowColumnView daysRowColumnViewWithDate:[fromDate dateByAddingDayInterval:i]];
        
        daysRowColumnView.frame = CGRectOffset(daysRowColumnView.frame, CGRectGetWidth(daysRowColumnView.frame) * i, 0);
        
        [daysRowView addSubview:daysRowColumnView];
        [daysRowView.daysRowColumnDescriptions addObject:@{@"daysRowColumn":daysRowColumnView, @"date":[fromDate dateByAddingDayInterval:i]}];
    }
    
    [daysRowView checkCurrentDay];
    daysRowView.currentDayTimer = [NSTimer scheduledTimerWithTimeInterval:updateInterval target:daysRowView selector:@selector(checkCurrentDay) userInfo:nil repeats:YES];
    
    return daysRowView;
}

- (NSMutableArray *)daysRowColumnDescriptions
{
    if (!_daysRowColumnDescriptions) {
        _daysRowColumnDescriptions = [NSMutableArray new];
    }
    
    return _daysRowColumnDescriptions;
}

#pragma mark - DaysRowView

- (void)checkCurrentDay
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    
    for (NSDictionary *daysRowColumnDescription in self.daysRowColumnDescriptions) {
        NSDate *date = daysRowColumnDescription[@"date"];
        components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
        
        NSDate *otherDate = [cal dateFromComponents:components];
        DaysRowColumnView *daysRowColumnView = daysRowColumnDescription[@"daysRowColumn"];
        
        if([today isEqualToDate:otherDate]) {
            [daysRowColumnView changeColorIfCurrentDay:YES];
        } else {
            [daysRowColumnView changeColorIfCurrentDay:NO];
        }
    }
}

@end
