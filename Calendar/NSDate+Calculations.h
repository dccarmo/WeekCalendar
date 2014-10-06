//
//  NSDate+Calculations.h
//  Calendar
//
//  Created by Diogo do Carmo on 10/5/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calculations)

- (NSInteger)numberOfDaysUntil:(NSDate*)toDateTime;

- (NSDate *)dateByAddingDayInterval:(NSInteger)interval;

/**
 *  Returns the sunday from the current week (created to organize the calendar view)
 *
 *  @return Date of the current week sunday
 */
- (NSDate *)currentWeekSunday;

/**
 *  Returns the sunday from the previous week
 *
 *  @return Date of the previous week sunday
 */
- (NSDate *)previousWeekSunday;

/**
 *  Returns the sunday from the next week (created to organize the calendar view)
 *
 *  @return Date of the next week sunday
 */
- (NSDate *)nextWeekSunday;

- (NSDate *)midDateForLimitDate:(NSDate *)limitDate;

@end
