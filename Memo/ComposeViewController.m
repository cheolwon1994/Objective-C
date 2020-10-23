//
//  ComposeViewController.m
//  Memo
//
//  Created by dreamtour on 2020/10/22.
//

#import "ComposeViewController.h"
#import "MemoData.h"
@interface ComposeViewController ()

- (IBAction)close:(id)sender;
- (IBAction)save:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *memoTextView;


@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)save:(id)sender {
    NSString* memo = self.memoTextView.text;
    
    MemoData* newMemo = [[MemoData alloc] initWithContent:memo];
    [[MemoData dummyMemoList] addObject:newMemo];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
