//
//  DaysRowView.h
//  Calendar
//
//  Created by Diogo do Carmo on 10/5/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaysRowView : UIView

+ (DaysRowView *)daysRowViewFrom:(NSDate *)fromDate to:(NSDate *)toDate;

@end
