//
//  WeekView.m
//  Calendar
//
//  Created by Diogo do Carmo on 10/5/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import "WeekView.h"

//View
#import "DayView.h"
#import "HourView.h"

//Support
#import "NSDate+Calculations.h"

@interface WeekView ()

@end

@implementation WeekView

+ (WeekView *)weekViewFrom:(NSDate *)fromDate to:(NSDate *)toDate
{
    NSInteger numberOfDays = [fromDate numberOfDaysUntil:toDate];
    
    WeekView *weekView = [[WeekView alloc] initWithFrame:CGRectMake(0, 0, [DayView expectedWidth] * numberOfDays, [DayView expectedHeightFrom:0 to:23])];
    
    for (NSUInteger i = 0; i < numberOfDays; i++) {
        DayView *dayView = [DayView dayViewFrom:0 to:23];
        
        BOOL lastColumn = i + 1 == numberOfDays;
        
        if (lastColumn) {
            for (NSDictionary *hourInfo in dayView.hourDescriptions) {
                HourView *hour = hourInfo[@"hourView"];
                
                hour.verticalLine.hidden = YES;
            }
        }
        
        dayView.frame = CGRectOffset(dayView.frame, CGRectGetWidth(dayView.frame) * i, 0);
        
        [weekView addSubview:dayView];
        [weekView.daysInfo addObject:@{@"dayView":dayView, @"date":[fromDate dateByAddingDayInterval:i]}];
    }
    
    return weekView;
}

- (NSMutableArray *)daysInfo
{
    if (!_daysInfo) {
        _daysInfo = [NSMutableArray new];
    }
    
    return _daysInfo;
}

#pragma mark - WeekView

@end
