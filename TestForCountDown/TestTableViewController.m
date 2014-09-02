//
//  TestTableViewController.m
//  TestForCountDown
//
//  Created by fei on 14-8-25.
//  Copyright (c) 2014年 self. All rights reserved.
//

#import "TestTableViewController.h"
#import "CountDownView.h"
#import "TestTableViewCell.h"
@interface TestTableViewController ()

@end

@implementation TestTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CountDownView *view = (CountDownView *)[cell.contentView viewWithTag:1000];
    view.backgroundColor = [UIColor blackColor];
    view.showStyle = CountDownViewAligment_right;
    view.showImage = YES;
    view.tag = 1000;
    view.labelTextColor = [UIColor whiteColor];
    view.imageName = @"index_clock";
    if (indexPath.row%2 == 0) {
        [view setTimeWithTimesTamp:@"2014-08-25 19:25:50.3" andType:CountDownView_JustShow];
    } else
        [view setTimeWithTimesTamp:@"2014-09-28 19:25:50.3" andType:CountDownView_JustShow];
//    [self setCellCountDownViewWithCell:cell andIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor lightGrayColor];
    
    
    // Configure the cell...
    
    return cell;
}

-(void)setCellCountDownViewWithCell:(UITableViewCell *)cell andIndexPath:(NSIndexPath *)indexPath {
//    CountDownView *view = (CountDownView *)[cell.contentView viewWithTag:1000];
    
    CountDownView *view = [[CountDownView alloc] initWithFrame:CGRectMake(250, 0, 50, 20)];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
