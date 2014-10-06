//
//  DaysRowColumnView.m
//  Calendar
//
//  Created by Diogo do Carmo on 10/5/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import "DaysRowColumnView.h"

//View
#import "HourView.h"

static const CGFloat daysRowColumnViewHeight = 50.0f;

@interface DaysRowColumnView ()

@property (weak, nonatomic) IBOutlet UILabel *monthDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekDayLabel;

@end

@implementation DaysRowColumnView

+ (DaysRowColumnView *)daysRowColumnViewWithDate:(NSDate *)date
{
    DaysRowColumnView *daysRowColumnView = [[[UINib nibWithNibName:@"DaysRowColumnView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    
    daysRowColumnView.frame = CGRectMake(0, 0, [HourView expectedWidth], daysRowColumnViewHeight);
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    
    if ([dateComponents weekday] == 1 || [dateComponents weekday] == 7) {
        daysRowColumnView.monthDayLabel.textColor = [UIColor lightGrayColor];
        daysRowColumnView.weekDayLabel.textColor = [UIColor lightGrayColor];
    }
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    
    [dateFormatter setDateFormat:@"dd"];
    daysRowColumnView.monthDayLabel.text = [dateFormatter stringFromDate:date];
    
    [dateFormatter setDateFormat:@"EEE"];
    daysRowColumnView.weekDayLabel.text = [dateFormatter stringFromDate:date];
    
    return daysRowColumnView;
}

#pragma mark - DaysRowColumnView

+ (CGFloat)expectedWidth
{
    return daysRowColumnViewHeight;
}

+ (CGFloat)expectedHeight
{
    return [HourView expectedHeight];
}

- (void)changeColorIfCurrentDay:(BOOL)currentDay
{
    if (currentDay) {
        self.monthDayLabel.backgroundColor = [UIColor colorWithRed:0.203 green:0.802 blue:1 alpha:1];
        self.monthDayLabel.layer.cornerRadius = 13.0f;
        self.monthDayLabel.textColor = [UIColor whiteColor];
    } else {
        self.monthDayLabel.backgroundColor = [UIColor clearColor];
        self.monthDayLabel.layer.cornerRadius = 0;
        self.monthDayLabel.textColor = [UIColor blackColor];
    }
}

@end

