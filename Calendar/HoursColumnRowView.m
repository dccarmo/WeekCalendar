//
//  HoursColumnRowView.m
//  Calendar
//
//  Created by Diogo do Carmo on 10/5/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import "HoursColumnRowView.h"

//View
#import "HourView.h"

static const CGFloat hoursColumnRowViewWidth = 50.0f;

@interface HoursColumnRowView ()

@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *currentHourVerticalSpaceLayoutConstraint;

@end

@implementation HoursColumnRowView

+ (HoursColumnRowView *)hoursColumnRowViewWithHour:(NSString *)hour
{
    HoursColumnRowView *hoursColumnRowView = [[[UINib nibWithNibName:@"HoursColumnRowView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    
    hoursColumnRowView.frame = CGRectMake(0, 0, hoursColumnRowViewWidth, [HourView expectedHeight]);
    hoursColumnRowView.hourLabel.text = hour;
    hoursColumnRowView.currentHourLabel.hidden = YES;
    
    return hoursColumnRowView;
}

+ (CGFloat)expectedWidth
{
    return hoursColumnRowViewWidth;
}

+ (CGFloat)expectedHeight
{
    return [HourView expectedHeight];
}

- (void)calculateCurrentHour
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    CGFloat minutesInHourHeight = CGRectGetHeight(self.frame) / 60;
    
    self.currentHourVerticalSpaceLayoutConstraint.constant = ([dateComponents minute] * minutesInHourHeight) - CGRectGetHeight(self.currentHourLabel.frame)/2;
    
    self.currentHourLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",(long)[dateComponents hour], (long)[dateComponents minute]];
    self.currentHourLabel.hidden = NO;
}

@end
