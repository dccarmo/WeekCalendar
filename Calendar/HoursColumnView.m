//
//  HoursColumnView.m
//  Calendar
//
//  Created by Diogo do Carmo on 10/5/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import "HoursColumnView.h"

//View
#import "HoursColumnRowView.h"

static const NSUInteger updateInterval = 10;

@interface HoursColumnView ()

@property (nonatomic) NSMutableArray *hoursColumnRowDescriptions;
@property (nonatomic) NSTimer *currentHourTimer;

@end

@implementation HoursColumnView

+ (HoursColumnView *)hoursColumnViewFrom:(NSUInteger)fromHour to:(NSUInteger)toHour
{
    NSInteger deltaHours = toHour - fromHour;
    
    if (deltaHours < 0) {
        return nil;
    }
    
    HoursColumnView *hoursColumnView = [[HoursColumnView alloc] initWithFrame:CGRectMake(0, 0, [HoursColumnRowView expectedWidth], [HoursColumnRowView expectedHeight] * deltaHours)];
    
    for (NSUInteger i = 0; i < deltaHours; i++) {
        HoursColumnRowView *hoursColumnRowView = [HoursColumnRowView hoursColumnRowViewWithHour:[NSString stringWithFormat:@"%d",fromHour + i + 1]];
        
        hoursColumnRowView.frame = CGRectOffset(hoursColumnRowView.frame, 0, CGRectGetHeight(hoursColumnRowView.frame) * i);
        
        [hoursColumnView addSubview:hoursColumnRowView];
        [hoursColumnView.hoursColumnRowDescriptions addObject:@{@"hoursColumnRow":hoursColumnRowView, @"hour":@(fromHour + i)}];
        
    }
    
    [hoursColumnView updateCurrentHour];
    hoursColumnView.currentHourTimer = [NSTimer scheduledTimerWithTimeInterval:updateInterval target:hoursColumnView selector:@selector(updateCurrentHour) userInfo:nil repeats:YES];
    
    return hoursColumnView;
}

- (NSMutableArray *)hoursColumnRowDescriptions
{
    if (!_hoursColumnRowDescriptions) {
        _hoursColumnRowDescriptions = [NSMutableArray new];
    }
    
    return _hoursColumnRowDescriptions;
}

#pragma mark - HoursColumnView

- (void)updateCurrentHour
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    
    for (NSDictionary *hourColumnRowDescription in self.hoursColumnRowDescriptions) {
        HoursColumnRowView *hourColumnRowView = hourColumnRowDescription[@"hoursColumnRow"];
        
        if ([hourColumnRowDescription[@"hour"] intValue] == [dateComponents hour]) {
            hourColumnRowView.currentHourLabel.hidden = NO;
            [hourColumnRowView calculateCurrentHour];
        } else {
            hourColumnRowView.currentHourLabel.hidden = YES;
        }
    }
}

@end

