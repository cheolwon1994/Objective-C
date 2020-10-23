//
//  MemoData+CoreDataProperties.h
//  Memo
//
//  Created by dreamtour on 2020/10/23.
//
//

#import "MemoData+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MemoData (CoreDataProperties)

+ (NSFetchRequest<MemoData *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSDate *insertDate;

@end

NS_ASSUME_NONNULL_END
