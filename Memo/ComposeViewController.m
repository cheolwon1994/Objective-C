//
//  ComposeViewController.m
//  Memo
//
//  Created by dreamtour on 2020/10/22.
//

#import "ComposeViewController.h"
#import "MemoData.h"
#import "DataManager.h"

@interface ComposeViewController ()

- (IBAction)close:(id)sender;
- (IBAction)save:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *memoTextView;
@property (strong, nonatomic) id willShowToken;
@property (strong, nonatomic) id willHideToken;

@end

@implementation ComposeViewController

-(void) dealloc {
    if(self.willShowToken){
        [[NSNotificationCenter defaultCenter] removeObserver:self.willShowToken];
    }
    if(self.willHideToken){
        [[NSNotificationCenter defaultCenter] removeObserver:self.willHideToken];
    }
}

/*
 이전 설정 유지
 자판이 띄어진 상태에서 뒤로가기를 눌렀다면 재접속시 자판이 자동으로 띄어짐
 자판이 띄어지지 않은 상태에서 뒤로가기를 눌렀다면 재접속시 자판이 자동으로 띄어지지 않음
 */
-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.memoTextView becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.memoTextView resignFirstResponder];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //메모 편집과 새 메모 작성을 구분하기 위한 코드
    if(self.editTarget != nil){
        self.navigationItem.title = @"메모 편집";
        self.memoTextView.text = self.editTarget.content;
    }
    else{
        self.navigationItem.title = @"새 메모";
        self.memoTextView.text = @"";
    }
    
    //자판을 켰을 때, 글을 가리지 않도록 설정
    self.willShowToken = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        CGFloat height = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
        UIEdgeInsets inset = self.memoTextView.contentInset;
        inset.bottom = height;
        self.memoTextView.contentInset = inset;
        
        inset = self.memoTextView.scrollIndicatorInsets;
        inset.bottom = height;
        self.memoTextView.scrollIndicatorInsets = inset;
    }];
    
    //자판 해제
    self.willHideToken = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        UIEdgeInsets inset = self.memoTextView.contentInset;
        inset.bottom = 0;
        self.memoTextView.contentInset = inset;
        
        inset = self.memoTextView.scrollIndicatorInsets;
        inset.bottom = 0;
        self.memoTextView.scrollIndicatorInsets = inset;
    }];
}

/*-
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)save:(id)sender {
    NSString* memo = self.memoTextView.text;
    
    //DB에 저장
    if(self.editTarget !=nil){
        self.editTarget.content = memo;
        [[DataManager sharedInstance] saveContext];
    }else{
        [[DataManager sharedInstance] addNewMemo:memo];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
