//
//  CountDownView.h
//  ZPSALE
//
//  Created by fei on 14-8-20.
//  Copyright (c) 2014年 self. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    CountDownView_CountDown,
    CountDownView_JustShow,
    
}CountDownViewStyle;
typedef enum {
    CountDownViewAligment_left,
    CountDownViewAligment_right,
}CountDownViewAligment;
@interface CountDownView : UIView

@property (nonatomic,assign)CountDownViewStyle showStyle;
@property (nonatomic,assign) CountDownViewAligment viewAligment;
@property (nonatomic,retain) UIColor *labelTextColor;
@property (nonatomic,retain) UIFont *labelFont;
@property (nonatomic,assign) BOOL showImage;
@property (nonatomic,retain) NSString *imageName;
-(void)setTimeWithTimesTamp:(NSString *)tampString andType:(CountDownViewStyle) type;

-(void)setTimeWithTimeIntervalString:(NSString *)intervalString andType:(CountDownViewStyle)type;

@end
