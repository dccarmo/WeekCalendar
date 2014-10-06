//
//  HourView.m
//  Calendar
//
//  Created by Diogo do Carmo on 10/5/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import "HourView.h"

static const CGFloat hourViewWidth = 150.0f;
static const CGFloat hourViewHeight = 90.0f;

@interface HourView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *currentTimeLineVerticalSpaceLayoutConstraint;

@end

@implementation HourView

+ (HourView *)hourView
{
    HourView *hourView = [[[UINib nibWithNibName:@"HourView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    
    hourView.frame = CGRectMake(0, 0, hourViewWidth, hourViewHeight);
    hourView.currentTimeLineView.hidden = YES;
    
    return hourView;
}

#pragma mark - HourView

+ (CGFloat)expectedWidth
{
    return hourViewWidth;
}

+ (CGFloat)expectedHeight
{
    return hourViewHeight;
}

- (void)calculateCurrentTimeLine
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:[NSDate date]];
    CGFloat minutesInHourHeight = CGRectGetHeight(self.frame) / 60;
    
    self.currentTimeLineVerticalSpaceLayoutConstraint.constant = [dateComponents minute] * minutesInHourHeight;
    self.currentTimeLineView.hidden = NO;
}

@end
