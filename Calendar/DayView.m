//
//  DayView.m
//  Calendar
//
//  Created by Diogo do Carmo on 10/5/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import "DayView.h"

//View
#import "HourView.h"

static const NSUInteger updateInterval = 10;

@interface DayView ()

@property (nonatomic) NSTimer *currentTimeLineTimer;

@end

@implementation DayView

+ (DayView *)dayViewFrom:(NSUInteger)fromHour to:(NSUInteger)toHour
{
    NSInteger deltaHours = toHour - fromHour;
    
    if (deltaHours < 0) {
        return nil;
    }
    
    DayView *dayView = [[DayView alloc] initWithFrame:CGRectMake(0, 0, [HourView expectedWidth], [HourView expectedHeight] * deltaHours)];
    
    for (NSUInteger i = 0; i < deltaHours; i++) {
        HourView *hourView = [HourView hourView];
        
        hourView.frame = CGRectOffset(hourView.frame, 0, CGRectGetHeight(hourView.frame) * i);
        
        [dayView addSubview:hourView];
        [dayView.hourDescriptions addObject:@{@"hourView":hourView, @"hour": @(fromHour + i)}];
    }
    
    [dayView updateCurrentTimeLine];
    dayView.currentTimeLineTimer = [NSTimer scheduledTimerWithTimeInterval:updateInterval target:dayView selector:@selector(updateCurrentTimeLine) userInfo:nil repeats:YES];
    
    return dayView;
}

- (NSMutableArray *)hourDescriptions
{
    if (!_hourDescriptions) {
        _hourDescriptions = [NSMutableArray new];
    }
    
    return _hourDescriptions;
}

#pragma mark - DayView

+ (CGFloat)expectedWidth
{
    return [HourView expectedWidth];
}

+ (CGFloat)expectedHeightFrom:(NSUInteger)fromHour to:(NSUInteger)toHour
{
    NSInteger deltaHours = toHour - fromHour;
    
    if (deltaHours < 0) {
        return 0;
    }
    
    return [HourView expectedHeight] * deltaHours;
}

- (void)updateCurrentTimeLine
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    
    for (NSDictionary *hourInfo in self.hourDescriptions) {
        HourView *hourView = hourInfo[@"hourView"];
        
        if ([hourInfo[@"hour"] intValue] == [dateComponents hour]) {
            hourView.currentTimeLineView.hidden = NO;
            [hourView calculateCurrentTimeLine];
        } else {
            hourView.currentTimeLineView.hidden = YES;
        }
    }
}

@end
