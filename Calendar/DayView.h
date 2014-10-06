//
//  DayView.h
//  Calendar
//
//  Created by Diogo do Carmo on 10/5/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AgendaCalendarView;

@interface DayView : UIView

@property (nonatomic) NSMutableArray *hourDescriptions;

+ (DayView *)dayViewFrom:(NSUInteger)fromHour to:(NSUInteger)toHour;
+ (CGFloat)expectedWidth;
+ (CGFloat)expectedHeightFrom:(NSUInteger)fromHour to:(NSUInteger)toHour;

@end
