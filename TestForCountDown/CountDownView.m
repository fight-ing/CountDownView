//
//  CountDownView.m
//  ZPSALE
//
//  Created by fei on 14-8-20.
//  Copyright (c) 2014年 self. All rights reserved.
//

#import "CountDownView.h"
#define ImageView_Height 15
#define ImageView_Width 15
#define Day_Time (3600*24)
#define Hour_Time 3600
#define Minute_Time 60
#define Second_Time 60
#define View_Height 18
@implementation CountDownView
{
    UIImageView *basicImageView;
    NSTimeInterval countDownTime;
    dispatch_source_t _timer;
    NSMutableString *timeString;
    UILabel *timeLabel;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _showStyle = CountDownView_JustShow;
        [self addSubViews];
    }
    return self;
}

-(void)awakeFromNib {
    _viewAligment = CountDownViewAligment_right;
    _showStyle = CountDownView_JustShow;
    [self addSubViews];
}

-(void)addSubViews {
    timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    timeLabel.textAlignment = NSTextAlignmentRight;
    basicImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    basicImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:timeLabel];
    [self addSubview:basicImageView];
}

-(void)setSubViews {
    self.hidden = YES;
    timeLabel.hidden = YES;
    basicImageView.hidden = YES;
    if (_labelTextColor) {
        timeLabel.textColor = _labelTextColor;
    } else
        timeLabel.textColor = [UIColor blackColor];
    if (_labelFont) {
        timeLabel.font = _labelFont;
    } else
        timeLabel.font = [UIFont systemFontOfSize:12];
    if (!_imageName) {
        basicImageView.image = [UIImage imageNamed:@"index_clock"];
    } else
        basicImageView.image = [UIImage imageNamed:_imageName];
    
    
    
}

-(void)setTimeWithTimesTamp:(NSString *)tampString andType:(CountDownViewStyle)type {
    
    [self setSubViews];
    _showStyle = type;
    NSDateFormatter *dateF=[[NSDateFormatter alloc] init];
    [dateF setDateFormat:@"yyyy-MM-dd HH:mm:ss.s"];
    NSDate *d=[dateF dateFromString:tampString];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    countDownTime = late-now;
    //    if (countDownTime<100*3600) {
    [self setTime];
    //    }
    
}

-(void)setTimeWithTimeIntervalString:(NSString *)intervalString andType:(CountDownViewStyle)type {
//    [self setSubViews];
    _showStyle = type;
    
    NSTimeInterval late = [intervalString longLongValue];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    countDownTime = late-now;
    //    if (countDownTime<100*3600) {
    [self setTime];
    //    }
    
}

-(void)setTime {
    if (_showStyle == CountDownView_CountDown) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        
        dispatch_source_set_event_handler(_timer, ^{
            if(countDownTime<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                //            dispatch_release(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    timeLabel.hidden = YES;
                    basicImageView.hidden = YES;
                    self.hidden = YES;
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.hidden = NO;
                    timeLabel.hidden = NO;
                    basicImageView.hidden = !_showImage;
                    //设置界面的按钮显示 根据自己需求设置
                    timeLabel.text = [self returnCountStringFromTimeInterval:countDownTime];
                    [timeLabel sizeToFit];
                    [self changeSelfViewFrame];
                });
                countDownTime--;
                
            }
        });
        dispatch_resume(_timer);
    } else if (_showStyle == CountDownView_JustShow) {
        if (countDownTime > 0) {
            self.hidden = NO;
            timeLabel.hidden = NO;
            basicImageView.hidden = !_showImage;
            timeLabel.text = [self returnJustDayOrHourStringWith:countDownTime];
            [timeLabel sizeToFit];
            
            [self changeSelfViewFrame];
            
            
        } else {
            self.hidden = YES;
            timeLabel.hidden = YES;
            basicImageView.hidden = YES;
        }
    }
    
}

-(void)changeSelfViewFrame {
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionShowHideTransitionViews animations:^{
        timeLabel.frame = CGRectMake(ImageView_Width+10, 0, timeLabel.frame.size.width, timeLabel.frame.size.height);
        basicImageView.frame = CGRectMake(5, 0, ImageView_Width, ImageView_Height);
        
        if (self.frame.size.width == basicImageView.frame.size.width+timeLabel.frame.size.width+15) {
            
        } else {
            if (_viewAligment == CountDownViewAligment_right) {
                self.frame = CGRectMake(self.frame.origin.x+(self.frame.size.width-timeLabel.frame.size.width-basicImageView.frame.size.width-15), self.frame.origin.y, timeLabel.frame.size.width+basicImageView.frame.size.width+15, timeLabel.frame.size.height);
            } else if (_viewAligment == CountDownViewAligment_left) {
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, timeLabel.frame.size.width+basicImageView.frame.size.width+15, timeLabel.frame.size.height);
            }
        }
    } completion:^(BOOL finished){
        
    }];
    
}



//timeInterval
-(NSString *)returnJustDayOrHourStringWith:(NSTimeInterval )timeInterval {
    
    
    NSMutableString *strings=[[NSMutableString alloc] init];
    
    int dayNumber = (int)timeInterval/Day_Time;
    int hour = (int)((int)timeInterval%Day_Time)/Hour_Time;
    
    if (dayNumber > 0) {
        [strings appendFormat:@"剩%d天",dayNumber+1];
    } else if (hour >= 0) {
        [strings appendFormat:@"剩%d小时",hour+1];
    }
    
    return strings;
}

-(NSString *)returnCountStringFromTimeInterval:(NSTimeInterval)timeInterval {
    NSString *stringTime;
    int dayNumber = (int)timeInterval/Day_Time;
    int hour = (int)((int)timeInterval%Day_Time)/Hour_Time;
    int minute = (int)((int)timeInterval%Hour_Time)/Minute_Time;
    int second = (int)((int)timeInterval%Second_Time);
    
    
    if (dayNumber > 0) {
        stringTime = [NSString stringWithFormat:@"剩: %d天%@时%@分%@秒",dayNumber,[self trans:hour],[self trans:minute],[self trans:second]];
    } else {
        stringTime = [NSString stringWithFormat:@"剩: %@时%@分%@秒",[self trans:hour],[self trans:minute],[self trans:second]];
    }
    return stringTime;
}

-(NSString *)trans:(int)old {
    NSString *str;
    if (old >= 10) {
        str = [NSString stringWithFormat:@"%d",old];
    } else {
        str = [NSString stringWithFormat:@"0%d",old];
    }
    return str;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
