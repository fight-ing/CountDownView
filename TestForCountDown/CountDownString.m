//
//  CountDownString.m
//  ZPSALE
//
//  Created by fei on 14-8-20.
//  Copyright (c) 2014年 self. All rights reserved.
//

#import "CountDownString.h"
#define Day_Time (3600*24)
#define Hour_Time 3600
#define Minute_Time 60
#define Second_Time 60
@implementation CountDownString
//yyyy-MM-dd HH:mm:ss.s
+(NSString *)countDownStringFormNowToDeadTime:(NSString *)deadTime {
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss.s"];
    NSDate *d=[date dateFromString:deadTime];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    
    NSMutableString *timeString=[[NSMutableString alloc] init];
    
    NSTimeInterval timeInterval=late-now;
    int dayNumber = (int)timeInterval/Day_Time;
    int hour = (int)((int)timeInterval%Day_Time)/Hour_Time;

    if (dayNumber > 0) {
        [timeString appendFormat:@"剩%d天",dayNumber];
    } else if (hour > 0) {
        [timeString appendFormat:@"剩%d小时",hour];
    } else {
        [timeString appendFormat:@" "];
    }
    
    return timeString;
}

//timeInterval
+(NSString *)returnJustDayOrHourStringWith:(NSTimeInterval )timeInterval {
    
    
    NSMutableString *timeString=[[NSMutableString alloc] init];
    
    int dayNumber = (int)timeInterval/Day_Time;
    int hour = (int)((int)timeInterval%Day_Time)/Hour_Time;
    
    if (dayNumber > 0) {
        [timeString appendFormat:@"剩%d天",dayNumber];
    } else if (hour > 0) {
        [timeString appendFormat:@"剩%d小时",hour];
    } else {
        [timeString appendFormat:@" "];
    }
    
    return timeString;
}

+(NSString *)returnCountStringFromTimeInterval:(NSTimeInterval)timeInterval {
    NSString *stringTime;
    int dayNumber = (int)timeInterval/Day_Time;
    int hour = (int)((int)timeInterval%Day_Time)/Hour_Time;
    int minute = (int)((int)timeInterval%Hour_Time)/Minute_Time;
    int second = (int)((int)timeInterval%Second_Time);
    if (dayNumber > 0) {
        stringTime = [NSString stringWithFormat:@"剩%d天 %@:%@:%@",dayNumber,[self trans:hour],[self trans:minute],[self trans:second]];
    } else {
        stringTime = [NSString stringWithFormat:@"剩 %@:%@:%@",[self trans:hour],[self trans:minute],[self trans:second]];
    }
    return stringTime;
}

+(NSString *)trans:(int)old {
    NSString *str;
    if (old >= 10) {
        str = [NSString stringWithFormat:@"%d",old];
    } else {
        str = [NSString stringWithFormat:@"0%d",old];
    }
    return str;
}


@end
