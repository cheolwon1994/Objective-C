//
//  DetailViewController.m
//  Memo
//
//  Created by dreamtour on 2020/10/23.
//

#import "DetailViewController.h"
#import "ComposeViewController.h"
#import "DataManager.h"
@interface DetailViewController () <UITableViewDataSource>

@property (strong,nonatomic) NSDateFormatter* formatter;
@property (weak, nonatomic) IBOutlet UITableView *memoTableView;
- (IBAction)deleteMemo:(id)sender;


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
    //전체화면 설정을 위해 사용
    ComposeViewController* obj = [segue destinationViewController];
    [obj setModalPresentationStyle: UIModalPresentationFullScreen];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.memoTableView reloadData];
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

- (IBAction)deleteMemo:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"삭제 확인" message:@"메모를 삭제할까요?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"삭제" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *_Nonnull action){
        [[DataManager sharedInstance] deleteMemo:self.memo];
        [self.navigationController popViewControllerAnimated:YES];      //현재 표시되어 있는 화면이 Pop(그전에 미리 NavigationController로 가야한다)
    }];
    [alert addAction:okAction];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action){
        
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
