//
//  HourView.h
//  Calendar
//
//  Created by Diogo do Carmo on 10/5/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HourView : UIView

@property (weak, nonatomic) IBOutlet UIView *currentTimeLineView;
@property (weak, nonatomic) IBOutlet UIView *horizontalLine;
@property (weak, nonatomic) IBOutlet UIView *verticalLine;

+ (HourView *)hourView;
+ (CGFloat)expectedWidth;
+ (CGFloat)expectedHeight;

- (void)calculateCurrentTimeLine;

@end
