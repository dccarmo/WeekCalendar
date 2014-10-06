//
//  HoursColumnRowView.h
//  Calendar
//
//  Created by Diogo do Carmo on 10/5/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HoursColumnRowView : UIView

@property (weak, nonatomic) IBOutlet UILabel *currentHourLabel;

+ (HoursColumnRowView *)hoursColumnRowViewWithHour:(NSString *)hour;
+ (CGFloat)expectedWidth;
+ (CGFloat)expectedHeight;

- (void)calculateCurrentHour;

@end
