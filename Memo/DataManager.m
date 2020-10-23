//
//  DataManager.m
//  Memo
//
//  Created by dreamtour on 2020/10/23.
//

#import "DataManager.h"
#import "MemoData+CoreDataProperties.h"
@implementation DataManager

+(instancetype)sharedInstance{
    static DataManager* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataManager alloc] init];
        sharedInstance.memoList = [[NSMutableArray alloc] init];
    });
    return sharedInstance;
}

-(void)addNewMemo:(NSString *)memo{
    //기본 형태 객체생성
    MemoData* newMemo = [[MemoData alloc] initWithContext:self.mainContext];
    newMemo.content = memo;
    newMemo.insertDate = [NSDate date];
    
    [self saveContext];
}

- (void)fetchMemo {
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"MemoData"];
    
    NSSortDescriptor* sortByDateDesc = [NSSortDescriptor sortDescriptorWithKey:@"insertDate" ascending:NO];
    request.sortDescriptors = @[sortByDateDesc];
    NSError* error = nil;
    NSArray* result = [self.mainContext executeFetchRequest:request error:&error];
    [self.memoList setArray:result];
}

-(NSManagedObjectContext*)mainContext{
    return self.persistentContainer.viewContext;
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {

    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Memo"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
@end
