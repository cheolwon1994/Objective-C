//
//  DataManager.h
//  Memo
//
//  Created by dreamtour on 2020/10/23.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject
@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (readonly, strong) NSManagedObjectContext* mainContext;
@property (strong, nonatomic) NSMutableArray* memoList;

-(void)fetchMemo;       //DBd에서 정보를 읽어와서 memoList에 저장
-(void)addNewMemo:(NSString*)memo;
- (void)saveContext;

+(instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
