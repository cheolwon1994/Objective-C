//
//  MemoData.m
//  Memo
//
//  Created by dreamtour on 2020/10/22.
//

#import "MemoData.h"

@implementation MemoData

static NSMutableArray* _dummyMemoList = nil;

-(instancetype)initWithContent:(NSString*)content{
    self = [super init];
    if(self){
        self.content = content;
        self.insertDate = [NSDate date]; 
    }
    return self;
}

+(NSMutableArray*)dummyMemoList{
    if(_dummyMemoList == nil){
        MemoData* memo1 = [[MemoData alloc] initWithContent:@"Lorem Ipsum 11"];
        MemoData* memo2 = [[MemoData alloc] initWithContent:@"Lorem Ipsum 22"];
        _dummyMemoList =  [NSMutableArray arrayWithObjects:memo1,memo2, nil];
    }
    return _dummyMemoList;
}

@end
