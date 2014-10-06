//
//  WeekView.h
//  Calendar
//
//  Created by Diogo do Carmo on 10/5/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekView : UIView

@property (nonatomic) NSMutableArray *daysInfo;

+ (WeekView *)weekViewFrom:(NSDate *)fromDateTime to:(NSDate *)toDateTime;

@end
