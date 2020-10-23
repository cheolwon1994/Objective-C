//
//  DetailViewController.h
//  Memo
//
//  Created by dreamtour on 2020/10/23.
//

#import <UIKit/UIKit.h>
#import "MemoData.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (strong, nonatomic) MemoData* memo;

@end

NS_ASSUME_NONNULL_END
