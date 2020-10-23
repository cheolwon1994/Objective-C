//
//  MemoData.h
//  Memo
//
//  Created by dreamtour on 2020/10/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemoData : NSObject
@property (strong, nonatomic) NSString* content;
@property (strong, nonatomic) NSString* insertDate;

-(instancetype)initWithContent:(NSString*)content;
//+(NSMutableArray*)dummyMemoList;
@property (strong,nonatomic,readonly,class) NSMutableArray* dummyMemoList;
@end

NS_ASSUME_NONNULL_END
