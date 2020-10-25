//
//  DetailViewController.m
//  Memo
//
//  Created by dreamtour on 2020/10/23.
//

#import "DetailViewController.h"
#import "ComposeViewController.h"
@interface DetailViewController () <UITableViewDataSource>

@property (strong,nonatomic) NSDateFormatter* formatter;

@end

@implementation DetailViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row==0){       //첫 번째 셀
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"memoCell" forIndexPath:indexPath];
        cell.textLabel.text = self.memo.content;
        
        return cell;
    }
    else if(indexPath.row==1){      //두 번째 셀
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"dateCell" forIndexPath:indexPath];
        cell.textLabel.text = [self.formatter stringFromDate:self.memo.insertDate];
        return cell;
    }
    return [[UITableView alloc] init];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ComposeViewController* vc = [[segue.destinationViewController childViewControllers] objectAtIndex:0];
    vc.editTarget = self.memo;
    [vc setModalPresentationStyle: UIModalPresentationFullScreen];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateStyle = NSDateFormatterLongStyle;
    self.formatter.timeStyle = NSDateFormatterMediumStyle;
    self.formatter.locale = [NSLocale localeWithLocaleIdentifier:@"Ko_kr"];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
