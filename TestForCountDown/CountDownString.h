//
//  CountDownString.h
//  ZPSALE
//
//  Created by fei on 14-8-20.
//  Copyright (c) 2014年 self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountDownString : NSObject

+(NSString *)countDownStringFormNowToDeadTime:(NSString *)deadTime;

+(NSString *)returnJustDayOrHourStringWith:(NSTimeInterval )timeInterval;
+(NSString *)returnCountStringFromTimeInterval:(NSTimeInterval)timeInterval;
@end
