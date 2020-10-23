//
//  MemoListTableViewController.m
//  Memo
//
//  Created by dreamtour on 2020/10/22.
//

#import "MemoListTableViewController.h"
#import "MemoData.h"
#import "ComposeViewController.h"
#import "DetailViewController.h"
#import "DataManager.h"

@interface MemoListTableViewController () 
@property (strong,nonatomic) NSDateFormatter* formatter;
@end

@implementation MemoListTableViewController

-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"Appeared!!");
    [super viewWillAppear:animated];
    [[DataManager sharedInstance] fetchMemo];       //DB에서 데이터 채워오기
    [self.tableView reloadData]; 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ViewDidLog 호출!!!");
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateStyle = NSDateFormatterLongStyle;
    self.formatter.timeStyle = NSDateFormatterNoStyle;
    self.formatter.locale = [NSLocale localeWithLocaleIdentifier:@"Ko_kr"];
}
- (IBAction)memoListRefresh:(id)sender {
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath* indexPath = [self.tableView indexPathForCell:(UITableViewCell*) sender];
    if(indexPath!=nil){
        MemoData* target = [[[DataManager sharedInstance] memoList] objectAtIndex:indexPath.row];
        DetailViewController* vc = (DetailViewController*)segue.destinationViewController;
        vc.memo = target;
//        [vc setModalPresentationStyle: UIModalPresentationFullScreen];
    }
    ComposeViewController* obj = [segue destinationViewController];
    [obj setModalPresentationStyle: UIModalPresentationFullScreen];
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[DataManager sharedInstance] memoList] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    MemoData* target = [[[DataManager sharedInstance] memoList] objectAtIndex:indexPath.row];
    cell.textLabel.text = target.content;
//    cell.detailTextLabel.text = target.insertDate.description;
    cell.detailTextLabel.text = [self.formatter stringFromDate:target.insertDate];
    return cell;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
