//
//  NSDate+Calculations.m
//  Calendar
//
//  Created by Diogo do Carmo on 10/5/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import "NSDate+Calculations.h"

@implementation NSDate (Calculations)

- (NSInteger)numberOfDaysUntil:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:self];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

- (NSDate *)dateByAddingDayInterval:(NSInteger)interval {
    NSDateComponents *componentsToAdd;
    
    componentsToAdd = [NSDateComponents new];
    [componentsToAdd setDay: interval];
    
    return [[NSCalendar currentCalendar] dateByAddingComponents:componentsToAdd toDate:self options:0];
}

- (NSDate *)currentWeekSunday {
    NSDateComponents *todayComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    
    return [self dateByAddingDayInterval:- ([todayComponents weekday] - 1)];
}

- (NSDate *)previousWeekSunday {
    NSDateComponents *todayComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    
    return [self dateByAddingDayInterval:- ([todayComponents weekday] + 6)];
}

- (NSDate *)nextWeekSunday {
    NSDateComponents *todayComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    
    return [self dateByAddingDayInterval: [todayComponents weekday]];
}

- (NSDate *)midDateForLimitDate:(NSDate *)limitDate
{
    NSTimeInterval difference = [limitDate timeIntervalSinceDate:self];
    
    return [NSDate dateWithTimeInterval:difference / 2 sinceDate:self];
}

@end
