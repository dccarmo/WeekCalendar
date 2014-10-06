//
//  DaysRowColumnView.h
//  Calendar
//
//  Created by Diogo do Carmo on 10/5/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaysRowColumnView : UIView

+ (DaysRowColumnView *)daysRowColumnViewWithDate:(NSDate *)date;
+ (CGFloat)expectedWidth;
+ (CGFloat)expectedHeight;

- (void)changeColorIfCurrentDay:(BOOL)currentDay;

@end
