//
//  ViewController.m
//  Calendar
//
//  Created by Diogo do Carmo on 10/5/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import "CalendarViewController.h"

//View
#import "WeekView.h"
#import "HoursColumnView.h"
#import "DaysRowView.h"

//Support
#import "NSDate+Calculations.h"

static const NSUInteger numberOfFutureDays = 30;

@interface CalendarViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *daysRowScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *hoursColumnScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *weekScrollView;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@property (nonatomic) NSMutableArray *agendas;
@property (nonatomic) NSDate *fromDate;
@property (nonatomic) NSDate *toDate;

@end

@implementation CalendarViewController

- (void)awakeFromNib
{
    self.navigationController.navigationBar.translucent = NO;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.fromDate = [[NSDate date] currentWeekSunday];
    self.toDate = [self.fromDate dateByAddingDayInterval:numberOfFutureDays];
    
    [self refreshCalendar];
    [self changeMonthYearLabel];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self syncScrollViewsOffset];
    [self changeMonthYearLabel];
}

#pragma mark - CalendarViewController

- (void)refreshCalendar
{
    WeekView *weekView = [WeekView weekViewFrom:self.fromDate to:self.toDate];
    
    for (UIView *view in self.weekScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.weekScrollView addSubview:weekView];
    self.weekScrollView.contentSize = weekView.frame.size;
    
    HoursColumnView *hoursColumnView = [HoursColumnView hoursColumnViewFrom:0 to:23];
    
    for (UIView *view in self.hoursColumnScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.hoursColumnScrollView addSubview:hoursColumnView];
    self.hoursColumnScrollView.contentSize = hoursColumnView.frame.size;
    
    
    DaysRowView *daysRowView = [DaysRowView daysRowViewFrom:self.fromDate to:self.toDate];
    
    for (UIView *view in self.daysRowScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.daysRowScrollView addSubview:daysRowView];
    self.daysRowScrollView.contentSize = daysRowView.frame.size;
}

- (void)syncScrollViewsOffset
{
    CGPoint weekScrollViewOffset = self.weekScrollView.contentOffset;
    
    self.hoursColumnScrollView.contentOffset = CGPointMake(self.hoursColumnScrollView.contentOffset.x, weekScrollViewOffset.y);
    self.daysRowScrollView.contentOffset = CGPointMake(weekScrollViewOffset.x, self.daysRowScrollView.contentOffset.y);
}

- (void)changeMonthYearLabel
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    CGFloat dayRowWidth = self.weekScrollView.contentSize.width / numberOfFutureDays;
    NSDate *middleDate = [self.fromDate dateByAddingDayInterval:(NSUInteger) (self.weekScrollView.contentOffset.x / dayRowWidth) + CGRectGetWidth(self.view.frame) / dayRowWidth / 2];
    
    [dateFormatter setDateFormat:@"MMMM"];
    self.monthLabel.text = [dateFormatter stringFromDate:middleDate];
    
    [dateFormatter setDateFormat:@"YYYY"];
    self.yearLabel.text = [dateFormatter stringFromDate:middleDate];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self syncScrollViewsOffset];
    [self changeMonthYearLabel];
}

@end
