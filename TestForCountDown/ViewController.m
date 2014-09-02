//
//  ViewController.m
//  TestForCountDown
//
//  Created by fei on 14-8-20.
//  Copyright (c) 2014年 self. All rights reserved.
//

#import "ViewController.h"
#import "CountDownView.h"
#import "TestTableViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet CountDownView *testCountDownView;

@property (weak, nonatomic) IBOutlet CountDownView *showCountDownView;
@property (weak, nonatomic) IBOutlet UILabel *labelTest;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    NSLog(@"now :%@",[NSDate dateWithTimeIntervalSinceNow:0]);
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd HH:mm:ss.s"];
    //时区
    NSString *str = [f stringFromDate:[NSDate date]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.s"];
    NSDate *localDate = [dateFormatter dateFromString:str];
    NSLog(@"local :%@",[self dateToString:[NSDate date]]);
    
    
    
    
    //字符串
    NSString *stringTime = @"2014-08-29 11:25:50.3";
    
    _testCountDownView.showImage = YES;
    [_testCountDownView setTimeWithTimesTamp:stringTime andType:CountDownView_CountDown];
    _testCountDownView.backgroundColor = [UIColor greenColor];
    _showCountDownView.showImage = YES;
    _showCountDownView.viewAligment = CountDownViewAligment_left;
    [_showCountDownView setTimeWithTimesTamp:stringTime andType:CountDownView_JustShow];
    _showCountDownView.backgroundColor = [UIColor lightGrayColor];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.s"];
    NSDate *dat = [formatter dateFromString:stringTime];
    NSLog(@"dat :%@",dat);
    
    NSTimeInterval timeInterval = [dat timeIntervalSince1970]*1 - [[NSDate date] timeIntervalSince1970]*1;
    NSLog(@"timInterval :%f",timeInterval);
    
    //时间戳
    NSString *string2 = @"1408560351.385771";
    NSTimeInterval late = [string2 longLongValue];
    NSDate* aaaa = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[aaaa timeIntervalSince1970]*1;
    NSLog(@"aaaa:%f",late);
    NSLog(@"now :%f",now);
    
    NSLog(@"aaaa:%@",[NSDate dateWithTimeIntervalSince1970:late]);
    NSLog(@"now :%@",[NSDate dateWithTimeIntervalSince1970:now]);
    
    NSTimeInterval timeInterval2 = late-now;
    NSLog(@"timeInterval2 :%f",timeInterval2);
    
    
    [self setPriceOfZhenPin:@"1231223" andMarket:@"888989" andDiscount:@"1.89折"];
}

-(void)setPriceOfZhenPin:(NSString *)zhen andMarket:(NSString *)market andDiscount:(NSString *)discount{
    NSString *zpPriceStr = [NSString stringWithFormat:@"¥%@  ¥%@  %@",zhen,market,discount];
    NSMutableAttributedString *zpPStr = [[NSMutableAttributedString alloc] initWithString:zpPriceStr];
    [zpPStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, zhen.length+1)];
    [zpPStr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(zhen.length+3, market.length+1)];
    [zpPStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(zhen.length+market.length+6, discount.length)];
    [zpPStr addAttribute:NSBackgroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(zhen.length+market.length+6, discount.length)];
    
    [zpPStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"STHeitiSC-Light" size:12] range:NSMakeRange(0, 1)];
    [zpPStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"STHeitiSC-Light" size:21] range:NSMakeRange(1, zhen.length)];
    [zpPStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"STHeitiSC-Light" size:12] range:NSMakeRange(zhen.length+3, 1)];
    [zpPStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"STHeitiSC-Light" size:15] range:NSMakeRange(zhen.length+4, market.length)];
    [zpPStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"STHeitiSC-Medium" size:12] range:NSMakeRange(zhen.length+market.length+6, discount.length)];
    
    [zpPStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:2] range:NSMakeRange(zhen.length+3, market.length+1)];
    
    
    zpPStr addAttribute:<#(NSString *)#> value:<#(id)#> range:<#(NSRange)#>
    
    _labelTest.attributedText = zpPStr;
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _showCountDownView.frame = CGRectMake(10, 10, 100, 30);
    TestTableViewController *tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"TestTableViewController"];
    [self.navigationController pushViewController:tvc animated:YES];
}

- (NSString *)dateToString:(NSDate *)date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
